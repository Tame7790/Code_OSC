function [bit,reward,deadline,p] = front_es_re(flow_front_re_ES1,TASK1_bit_all,TASK1_reward_all,TASK1_deadline_all, TASK1_p_all,TASK1_number_all)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
% flow_front_re_ES1=(flow_front_1(1,2:1+TASK1_number_all))';%ES1:remain taska
i=1;
h=1;
while 1<=i && i<=TASK1_number_all
    if flow_front_re_ES1(i)==0
        if h==1
            bit=TASK1_bit_all(i);
            reward=TASK1_reward_all(i);
            deadline=TASK1_deadline_all(i);
            p=TASK1_p_all(i);
            h=h+1;
        else
            bit=[bit,TASK1_bit_all(i)];
            reward=[reward,TASK1_reward_all(i)];
            deadline=[deadline,TASK1_deadline_all(i)];
            p=[p,TASK1_p_all(i)];
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

