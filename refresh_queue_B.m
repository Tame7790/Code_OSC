function [result_ES,Queue_1B_inf,Queue_1B_task,B_battery_MO] = refresh_queue_B(slot,Queue_1B_task,frequency_ES1,Queue_1B_inf,B_battery_MO,k)
%refresh queue B
% Queue_1B_task={Queue_1B_task_p,Queue_1B_task_reward,Queue_1B_task_deadline,Queue_1B_task_bit,Queue_1B_task_time};

Queue_1B_task_p=Queue_1B_task{1};
Queue_1B_task_reward=Queue_1B_task{2};
Queue_1B_task_deadline=Queue_1B_task{3};
Queue_1B_task_bit=Queue_1B_task{4};
Queue_1B_task_time=Queue_1B_task{5};
Queue_1B_task_number=size(Queue_1B_task_bit,2);
frequency_ES1_inf=frequency_ES1/Queue_1B_task_number*ones(1,Queue_1B_task_number);
Queue_1B_task_bit_inf=Queue_1B_task_bit-frequency_ES1_inf*slot./Queue_1B_task_p;
%% judge if task complete in time +refresh complete task + energy refresh
if Queue_1B_task_number~=0
    
    i_task_complete=1;
    reward_com_task_inf=0;%complete  reward
    number_com_task_inf=0;%complete number
    time_com_task_inf=0;%complete time_
    w_inf=0;
    while  i_task_complete<=Queue_1B_task_number
        if Queue_1B_task_bit_inf(i_task_complete)<=0
            if Queue_1B_task_bit_inf(i_task_complete)==0
                time_com_task_inf=time_com_task_inf+slot+Queue_1B_task_time(i_task_complete);%count time
                w_inf=w_inf+slot*frequency_ES1/Queue_1B_task_number;
                if Queue_1B_task_time(i_task_complete)+slot<=Queue_1B_task_deadline(i_task_complete)
                    reward_com_task_inf=reward_com_task_inf+Queue_1B_task_reward(i_task_complete);%count success task reward & number
                    number_com_task_inf=number_com_task_inf+1;
                end
            else
                time_com_task_inf=time_com_task_inf+Queue_1B_task_time(i_task_complete)+Queue_1B_task_bit(i_task_complete)*Queue_1B_task_p(i_task_complete)/frequency_ES1/Queue_1B_task_number;
                w_inf=w_inf+Queue_1B_task_bit(i_task_complete)*Queue_1B_task_p(i_task_complete);
                if Queue_1B_task_time(i_task_complete)+Queue_1B_task_bit(i_task_complete)/frequency_ES1/Queue_1B_task_number<=Queue_1B_task_deadline(i_task_complete)
                    reward_com_task_inf=reward_com_task_inf+Queue_1B_task_reward(i_task_complete);%count success task reward & number
                    number_com_task_inf=number_com_task_inf+1;
                end
            end
            Queue_1B_inf=Queue_1B_inf-Queue_1B_task_bit(i_task_complete);%%Queue_1B_inf:queue B bit
            Queue_1B_task_bit(i_task_complete)=0;
        end
        if Queue_1B_task_bit_inf(i_task_complete)>0
            Queue_1B_task_bit(i_task_complete)=Queue_1B_task_bit_inf(i_task_complete);
            Queue_1B_task_time(i_task_complete)=Queue_1B_task_time(i_task_complete)+slot;
            Queue_1B_inf=Queue_1B_inf-slot*frequency_ES1/Queue_1B_task_number/Queue_1B_task_p(i_task_complete);
            w_inf=w_inf+slot*frequency_ES1/Queue_1B_task_number;
        end
        i_task_complete=i_task_complete+1;
    end
    i_task_refresh=Queue_1B_task_number;
    while  i_task_refresh>=1
        if Queue_1B_task_bit(i_task_refresh)==0
            Queue_1B_task_p(:,i_task_refresh)=[];
            Queue_1B_task_reward(:,i_task_refresh)=[];
            Queue_1B_task_deadline(:,i_task_refresh)=[];
            Queue_1B_task_bit(:,i_task_refresh)=[];
            Queue_1B_task_time(:,i_task_refresh)=[];
        end
        i_task_refresh=i_task_refresh-1;
    end
    %%emplty;[]
    B_battery_MO=B_battery_MO-k*(frequency_ES1/Queue_1B_task_number)*(frequency_ES1/Queue_1B_task_number)*w_inf;
    result_ES={reward_com_task_inf,number_com_task_inf,time_com_task_inf};
    Queue_1B_task={Queue_1B_task_p,Queue_1B_task_reward,Queue_1B_task_deadline,Queue_1B_task_bit,Queue_1B_task_time};
else
    reward_com_task_inf=0;
    number_com_task_inf=0;
    time_com_task_inf=0;
    result_ES={reward_com_task_inf,number_com_task_inf,time_com_task_inf};
end

end

