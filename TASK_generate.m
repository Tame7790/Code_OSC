function [NUM,data] = TASK_generate (inputArg1)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
NUM = inputArg1;%task number:6~8
TASK_deadline=0.005+0.001*round(13*rand( 1, NUM)) ;%每个任务的deadline;0.01~0.1
TASK_bit=400+100*rand( 1, NUM);%每个计算任务的大小
TASK_p=2000+round(100*rand( 1, NUM));%每个计算任务的计算密度
REWARD=(1400+100*rand( 1, NUM));%每个计算任务的奖励;10~16
data={TASK_deadline,TASK_bit,TASK_p,REWARD};
end

