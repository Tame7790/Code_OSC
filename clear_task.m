function [TASK1_bit,TASK1_reward,TASK1_deadline,TASK1_p,mumber] = ...
    clear_task(TASK1_bit_all_mo,TASK1_reward_all_mo,TASK1_deadline_all_mo,TASK1_p_all_mo)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
TASK1_bit=[];%每个计算任务的大小
TASK1_reward=[];%每个计算任务的奖励
TASK1_deadline=[];%每个任务的deadline
TASK1_p=[];
a=1;
b=size(TASK1_bit_all_mo,2);
while a<=b
    if TASK1_deadline_all_mo(a) > 0
        TASK1_bit = [TASK1_bit,TASK1_bit_all_mo(a)];%每个计算任务的大小
        TASK1_reward = [TASK1_reward,TASK1_reward_all_mo(a)];%每个计算任务的奖励
        TASK1_deadline = [TASK1_deadline,TASK1_deadline_all_mo(a)];%每个任务的deadline
        TASK1_p = [TASK1_p,TASK1_p_all_mo(a)];
    end
    a = a + 1;
end
mumber = b - a + 1;
end

