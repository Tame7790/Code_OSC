function [bit,reward,deadline,p] = front_es(flow_front_1_ES1,TASK1_bit_all,TASK1_reward_all,TASK1_deadline_all, TASK1_p_all,TASK1_number_all)
%front ES:offload & compute
i=2;
h=1;
while 2<=i && i<=TASK1_number_all+1
    if flow_front_1_ES1(i)==1
        if h==1
            bit=TASK1_bit_all(i-1);
            reward=TASK1_reward_all(i-1);
            deadline=TASK1_deadline_all(i-1);
            p=TASK1_p_all(i-1);
            h=h+1;
        else
            bit=[bit,TASK1_bit_all(i-1)];
            reward=[reward,TASK1_reward_all(i-1)];
            deadline=[deadline,TASK1_deadline_all(i-1)];
            p=[p,TASK1_p_all(i-1)];
        end
    end
    i=i+1;
end
if h==1
    bit=[];
    reward=[];
    deadline=[];
    p=[];
end
end

