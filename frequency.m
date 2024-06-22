function [result,frequency_ES1] = frequency(k,slot,Eop,yz,MAX1frequency,Queue_B_ES1,Queue_1B_task_num,Queue_1B_task_p,Queue_1B_task_bit,B_battery_MO_1ES,B_battery_MO_1ES_MIN,B_battery_MO_1ES_MAX,Btran_MO_ES1)
%aculate frequency
hih=size(Queue_1B_task_bit,2);
if Queue_1B_task_num~=0 || hih~=0
    frequency_min=(B_battery_MO_1ES_MIN/k/slot)^(1/3);
    if Queue_1B_task_num==0
        frequency_ES1=frequency_min;
        result=0;
    else
        if Btran_MO_ES1<=B_battery_MO_1ES_MAX
            B_battery_MO_1ES_MAX=Btran_MO_ES1;
        end
        frequency_max=(B_battery_MO_1ES_MAX/k/slot)^(1/3);
        if MAX1frequency<=frequency_max
            frequency_max=MAX1frequency;
        end
        if frequency_min<=frequency_max
            t1 = frequency_min:10:frequency_max;
            size1=size(t1,2);
            %% 算法求出所有x、y下的函数值
            % 假设算法y=t1^2+t2^2，求y最小值与位置
            y = ones(1,size1)*inf;
            for i1 = 1:size1
                [y(i1)] = jisuan(t1(i1),k,slot,Eop,yz,Queue_1B_task_num,Queue_1B_task_p,Queue_1B_task_bit,B_battery_MO_1ES,Queue_B_ES1);
            end
            [result,y_loc]=min(y);%得到的是整个矩阵最小值的值和纵坐标
            frequency_ES1=t1(y_loc);
        else
            frequency_ES1=0;
            result=0;
            
        end
    end
else
    frequency_ES1=0;
    result=0;
end
end

