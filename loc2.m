function [bit_1re_loc,reward_1re_loc,deadline_1re_loc,p_1re_loc,bit_1to1_loc,reward_1to1_loc,deadline_1to1_loc,p_1to1_loc] = loc2(ALLOW1_computate_loc,TASK1_bit_all_loc,TASK1_reward_all_loc,TASK1_deadline_all_loc, TASK1_p_all_loc)
%local process task
TASK1_number_all_loc=size(TASK1_bit_all_loc,2);
num_min=0;
num_max=TASK1_number_all_loc;
if ALLOW1_computate_loc>TASK1_number_all_loc
    num_min=TASK1_number_all_loc;
else
    num_min=ALLOW1_computate_loc;
end
bit_1re_loc=[];
reward_1re_loc=[];
deadline_1re_loc=[];
p_1re_loc=[];
bit_1to1_loc=[];
reward_1to1_loc=[];
deadline_1to1_loc=[];
p_1to1_loc=[];

b=1;
while b<=num_max
    if b<=num_min
        bit_1to1_loc=[bit_1to1_loc,TASK1_bit_all_loc(b)];
        reward_1to1_loc=[reward_1to1_loc,TASK1_reward_all_loc(b)];
        deadline_1to1_loc=[deadline_1to1_loc,TASK1_deadline_all_loc(b)];
        p_1to1_loc=[p_1to1_loc,TASK1_p_all_loc(b)];
    end
    if b>num_min && b<=num_max
        bit_1re_loc=[bit_1re_loc,TASK1_bit_all_loc(b)];
        reward_1re_loc=[reward_1re_loc,TASK1_reward_all_loc(b)];
        deadline_1re_loc=[deadline_1re_loc,TASK1_deadline_all_loc(b)];
        p_1re_loc=[p_1re_loc,TASK1_p_all_loc(b)];
    end
    b=b+1;
end

end

