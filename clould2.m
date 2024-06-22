function [task_1to6_sio,task_1to1_sio,task_1re_sio] =...
    clould2(ALLOW1_computate_sio,ALLOW1_offload_sio,...
    TASK1_bit_all_sio,TASK1_reward_all_sio,...
    TASK1_deadline_all_sio, TASK1_p_all_sio,TRAN_BIT1_mo_clould)
%clould +greedy
TASK1_number_all_sio = size(TASK1_bit_all_sio,2);
bit_1to1_sio = [];
reward_1to1_sio = [];
deadline_1to1_sio = [];
p_1to1_sio = [];
bit_1to6_sio = [];
reward_1to6_sio = [];
deadline_1to6_sio = [];
p_1to6_sio = [];
bit_1re_sio = [];
reward_1re_sio = [];
deadline_1re_sio = [];
p_1re_sio = [];

a = 1;
while a<=TASK1_number_all_sio
    if a<=ALLOW1_computate_sio && TASK1_deadline_all_sio(a)<=TRAN_BIT1_mo_clould*TASK1_bit_all_sio(a)
        bit_1to1_sio=[bit_1to1_sio,TASK1_bit_all_sio(a)];
        reward_1to1_sio=[reward_1to1_sio,TASK1_reward_all_sio(a)];
        deadline_1to1_sio=[deadline_1to1_sio,TASK1_deadline_all_sio(a)];
        p_1to1_sio=[p_1to1_sio,TASK1_p_all_sio(a)];
    end
    if a>ALLOW1_computate_sio && a<=ALLOW1_computate_sio+ALLOW1_offload_sio
        bit_1to6_sio=[bit_1to6_sio,TASK1_bit_all_sio(a)];
        reward_1to6_sio=[reward_1to6_sio,TASK1_reward_all_sio(a)];
        deadline_1to6_sio=[deadline_1to6_sio,TASK1_deadline_all_sio(a)];
        p_1to6_sio=[p_1to6_sio,TASK1_p_all_sio(a)];
    end
    if a>ALLOW1_computate_sio+ALLOW1_offload_sio 
        bit_1re_sio=[bit_1re_sio,TASK1_bit_all_sio(a)];
        reward_1re_sio=[reward_1re_sio,TASK1_reward_all_sio(a)];
        deadline_1re_sio=[deadline_1re_sio,TASK1_deadline_all_sio(a)];
        p_1re_sio=[p_1re_sio,TASK1_p_all_sio(a)];
    end
    a=a+1;
end
task_1to6_sio = {bit_1to6_sio,reward_1to6_sio,deadline_1to6_sio,p_1to6_sio};
task_1to1_sio = {bit_1to1_sio,reward_1to1_sio,deadline_1to1_sio,p_1to1_sio};
task_1re_sio = {bit_1re_sio,reward_1re_sio,deadline_1re_sio,p_1re_sio};
end

