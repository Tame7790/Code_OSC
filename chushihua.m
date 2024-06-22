function [TASK1_bit_all,TASK1_reward_all,TASK1_deadline_all,...
    TASK1_p_all,Queue_1B_task_p,Queue_1B_task_reward,...
    Queue_1B_task_deadline,Queue_1B_task_bit] = ...
    chushihua(TASK1bit,REWARD1,TASK1deadline,TASK1p)
TASK1_bit_all = [TASK1bit];%每个计算任务的大小
TASK1_reward_all = [REWARD1];%每个计算任务的奖励
TASK1_deadline_all = [TASK1deadline];%每个任务的deadline
TASK1_p_all = [TASK1p];%每个计算任务的计算密度
%%back_queue
Queue_1B_task_p=[];
Queue_1B_task_reward=[];
Queue_1B_task_deadline=[];
Queue_1B_task_bit=[];
end

