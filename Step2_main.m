while T<=T_ALL
    
    inputArg = random('poisson',15,1,6);
    inputArg1 = inputArg(1);
    inputArg2 = inputArg(2);
    inputArg3 = inputArg(3);
    inputArg4 = inputArg(4);
    inputArg5 = inputArg(5);
    inputArg6 = inputArg(6);
    %% TASK OF ALL ES GENERATE
    [TASK1number, data1] = TASK_generate(inputArg1);
    [TASK2number, data2] = TASK_generate(inputArg2);
    [TASK3number, data3] = TASK_generate(inputArg3);
    [TASK4number, data4] = TASK_generate(inputArg4);
    [TASK5number, data5] = TASK_generate(inputArg5);
    [TASK6number, data6] = TASK_generate(inputArg6);
    
    %% 1 ES
    TASK1deadline =  data1{1};
    TASK1bit = data1{2};
    TASK1p = data1{3};
    REWARD1 = data1{4};
    TASK1time = zeros(1, TASK1number);
    %%2 ES
    TASK2deadline = data2{1};
    TASK2bit = data2{2};
    TASK2p = data2{3};
    REWARD2 = data2{4};
    TASK2time = zeros(1, TASK2number);
    %%3 ES
    TASK3deadline = data3{1};
    TASK3bit = data3{2};
    TASK3p = data3{3};
    REWARD3 = data3{4};
    TASK3time = zeros(1, TASK3number);
    %%4 ES
    TASK4deadline = data4{1};
    TASK4bit = data4{2};
    TASK4p = data4{3};
    REWARD4 = data4{4};
    TASK4time = zeros(1, TASK4number);
    %%5 ES
    TASK5deadline = data5{1};
    TASK5bit = data5{2};
    TASK5p = data5{3};
    REWARD5 = data5{4};
    TASK5time = zeros(1, TASK5number);
    
    TASK_inf =  TASK1number + TASK2number + TASK3number + TASK4number + TASK5number;
    GE = 5 * round(10 * rand(1,  ES));
    TASK_all_deadline = [TASK1deadline, TASK2deadline, TASK3deadline, TASK4deadline, TASK5deadline];
    %% OSC algorim
    p1_OSC = 1;
    while p1_OSC <= ES
        if B_battery_OSC(p1_OSC) - yz - Eop>0
            GEtime_OSC(p1_OSC) = 0;
        else
            GEtime_OSC(p1_OSC) = GE(p1_OSC);
        end
        if B_battery_OSC(p1_OSC) - yz - Eop + U  *  price_grid > 0
            Bbatterytime_OSC(p1_OSC) = 0;
        elseif B_battery_OSC(p1_OSC) - yz - Eop + U  *  price_grid <= 0
            Bbatterytime_OSC(p1_OSC) = GE(p1_OSC);
        end
        p1_OSC = p1_OSC + 1;
    end
    %% DTG algorim
    p1_DTG = 1;
    while p1_DTG <=  ES
        if B_battery_DTG(p1_DTG) - yz - Eop > 0
            GEtime_DTG(p1_DTG) = 0;
        else
            GEtime_DTG(p1_DTG) = GE(p1_DTG);
        end
        if B_battery_DTG(p1_DTG) - yz - Eop + U  *  price_grid > 0
            Bbatterytime_DTG(p1_DTG) = 0;
        else
            Bbatterytime_DTG(p1_DTG) = GE(p1_DTG);
        end
        p1_DTG = p1_DTG + 1;
    end
    
    %% CTG algorim
    p1_CTG = 1;
    while p1_CTG <=  ES
        if B_battery_CTG(p1_CTG) - yz - Eop > 0
            GEtime_CTG(p1_CTG) = 0;
        else
            GEtime_CTG(p1_CTG) = GE(p1_CTG);
        end
        if B_battery_CTG(p1_CTG) - yz - Eop + U  *  price_grid > 0
            Bbatterytime_CTG(p1_CTG) = 0;
        else
            Bbatterytime_CTG(p1_CTG) = GE(p1_CTG);
        end
        p1_CTG = p1_CTG + 1;
    end
    %% ETG algorim
    p1_ETG = 1;
    while p1_ETG <=  ES
        if B_battery_ETG(p1_ETG) - yz - Eop > 0
            GEtime_ETG(p1_ETG) = 0;
        else
            GEtime_ETG(p1_ETG) = GE(p1_ETG);
        end
        if B_battery_ETG(p1_ETG) - yz - Eop + U  *  price_grid > 0
            Bbatterytime_ETG(p1_ETG) = 0;
        else
            Bbatterytime_ETG(p1_ETG) = GE(p1_ETG);
        end
        p1_ETG = p1_ETG + 1;
    end
    %% algorim
    Btran_OSC =  B_battery_OSC + GEtime_OSC + Bbatterytime_OSC;
    Btran_DTG =  B_battery_DTG + GEtime_DTG + Bbatterytime_DTG;
    Btran_CTG =  B_battery_CTG + GEtime_CTG + Bbatterytime_CTG;
    Btran_ETG =  B_battery_ETG + GEtime_ETG + Bbatterytime_ETG;
    
    %% task queue
    if T == 1%chushihua
        [TASK1_bit_all_OSC, TASK1_reward_all_OSC, TASK1_deadline_all_OSC, TASK1_p_all_OSC, ...
            Queue_1B_task_p_OSC, Queue_1B_task_reward_OSC, Queue_1B_task_deadline_OSC, Queue_1B_task_bit_OSC]  =  chushihua(TASK1bit, REWARD1, TASK1deadline, TASK1p);
        Queue_F_OSC(1) = sum(TASK1_bit_all_OSC);
        TASK1_number_all_OSC = size(TASK1_bit_all_OSC, 2);
        Queue_B_OSC(1) = sum(Queue_1B_task_bit_OSC);
        Queue_1B_task_num_OSC = size(Queue_1B_task_bit_OSC, 2);
        Queue_1B_task_time_OSC = [];
        
        [TASK2_bit_all_OSC, TASK2_reward_all_OSC, TASK2_deadline_all_OSC, TASK2_p_all_OSC, ...
            Queue_2B_task_p_OSC, Queue_2B_task_reward_OSC, Queue_2B_task_deadline_OSC, Queue_2B_task_bit_OSC]  =  chushihua(TASK2bit, REWARD2, TASK2deadline, TASK2p);
        Queue_F_OSC(2) = sum(TASK2_bit_all_OSC);
        TASK2_number_all_OSC = size(TASK2_bit_all_OSC, 2);
        Queue_B_OSC(2) = sum(Queue_2B_task_bit_OSC);
        Queue_2B_task_num_OSC = size(Queue_2B_task_bit_OSC, 2);
        Queue_2B_task_time_OSC = [];
        
        [TASK3_bit_all_OSC, TASK3_reward_all_OSC, TASK3_deadline_all_OSC, TASK3_p_all_OSC, ...
            Queue_3B_task_p_OSC, Queue_3B_task_reward_OSC, Queue_3B_task_deadline_OSC, Queue_3B_task_bit_OSC]  =  chushihua(TASK3bit, REWARD3, TASK3deadline, TASK3p);
        Queue_F_OSC(3) = sum(TASK3_bit_all_OSC);
        TASK3_number_all_OSC = size(TASK3_bit_all_OSC, 2);
        Queue_B_OSC(3) = sum(Queue_3B_task_bit_OSC);
        Queue_3B_task_num_OSC = size(Queue_3B_task_bit_OSC, 2);
        Queue_3B_task_time_OSC = [];
        
        [TASK4_bit_all_OSC, TASK4_reward_all_OSC, TASK4_deadline_all_OSC, TASK4_p_all_OSC, ...
            Queue_4B_task_p_OSC, Queue_4B_task_reward_OSC, Queue_4B_task_deadline_OSC, Queue_4B_task_bit_OSC]  =  chushihua(TASK4bit, REWARD4, TASK4deadline, TASK4p);
        Queue_F_OSC(4) = sum(TASK4_bit_all_OSC);
        TASK4_number_all_OSC = size(TASK4_bit_all_OSC, 2);
        Queue_B_OSC(4) = sum(Queue_4B_task_bit_OSC);
        Queue_4B_task_num_OSC = size(Queue_4B_task_bit_OSC, 2);
        Queue_4B_task_time_OSC = [];
        
        [TASK5_bit_all_OSC, TASK5_reward_all_OSC, TASK5_deadline_all_OSC, TASK5_p_all_OSC, ...
            Queue_5B_task_p_OSC, Queue_5B_task_reward_OSC, Queue_5B_task_deadline_OSC, Queue_5B_task_bit_OSC]  =  chushihua(TASK5bit, REWARD5, TASK5deadline, TASK5p);
        Queue_F_OSC(5) = sum(TASK5_bit_all_OSC);
        TASK5_number_all_OSC = size(TASK5_bit_all_OSC, 2);
        Queue_B_OSC(5) = sum(Queue_5B_task_bit_OSC);
        Queue_5B_task_num_OSC = size(Queue_5B_task_bit_OSC, 2);
        Queue_5B_task_time_OSC = [];
        
        %% _DTG
        [TASK1_bit_all_DTG, TASK1_reward_all_DTG, TASK1_deadline_all_DTG, TASK1_p_all_DTG, ...
            Queue_1B_task_p_DTG, Queue_1B_task_reward_DTG, Queue_1B_task_deadline_DTG, Queue_1B_task_bit_DTG]  =  chushihua(TASK1bit, REWARD1, TASK1deadline, TASK1p);
        Queue_F_DTG(1) = sum(TASK1_bit_all_DTG);
        TASK1_number_all_DTG = size(TASK1_bit_all_DTG, 2);
        Queue_B_DTG(1) = sum(Queue_1B_task_bit_DTG);
        Queue_1B_task_num_DTG = size(Queue_1B_task_bit_DTG, 2);
        Queue_1B_task_time_DTG = [];
        
        [TASK2_bit_all_DTG, TASK2_reward_all_DTG, TASK2_deadline_all_DTG, TASK2_p_all_DTG, ...
            Queue_2B_task_p_DTG, Queue_2B_task_reward_DTG, Queue_2B_task_deadline_DTG, Queue_2B_task_bit_DTG]  =  chushihua(TASK2bit, REWARD2, TASK2deadline, TASK2p);
        Queue_F_DTG(2) = sum(TASK2_bit_all_DTG);
        TASK2_number_all_DTG = size(TASK2_bit_all_DTG, 2);
        Queue_B_DTG(2) = sum(Queue_2B_task_bit_DTG);
        Queue_2B_task_num_DTG = size(Queue_2B_task_bit_DTG, 2);
        Queue_2B_task_time_DTG = [];
        
        [TASK3_bit_all_DTG, TASK3_reward_all_DTG, TASK3_deadline_all_DTG, TASK3_p_all_DTG, ...
            Queue_3B_task_p_DTG, Queue_3B_task_reward_DTG, Queue_3B_task_deadline_DTG, Queue_3B_task_bit_DTG]  =  chushihua(TASK3bit, REWARD3, TASK3deadline, TASK3p);
        Queue_F_DTG(3) = sum(TASK3_bit_all_DTG);
        TASK3_number_all_DTG = size(TASK3_bit_all_DTG, 2);
        Queue_B_DTG(3) = sum(Queue_3B_task_bit_DTG);
        Queue_3B_task_num_DTG = size(Queue_3B_task_bit_DTG, 2);
        Queue_3B_task_time_DTG = [];
        
        [TASK4_bit_all_DTG, TASK4_reward_all_DTG, TASK4_deadline_all_DTG, TASK4_p_all_DTG, ...
            Queue_4B_task_p_DTG, Queue_4B_task_reward_DTG, Queue_4B_task_deadline_DTG, Queue_4B_task_bit_DTG]  =  chushihua(TASK4bit, REWARD4, TASK4deadline, TASK4p);
        Queue_F_DTG(4) = sum(TASK4_bit_all_DTG);
        TASK4_number_all_DTG = size(TASK4_bit_all_DTG, 2);
        Queue_B_DTG(4) = sum(Queue_4B_task_bit_DTG);
        Queue_4B_task_num_DTG = size(Queue_4B_task_bit_DTG, 2);
        Queue_4B_task_time_DTG = [];
        
        [TASK5_bit_all_DTG, TASK5_reward_all_DTG, TASK5_deadline_all_DTG, TASK5_p_all_DTG, ...
            Queue_5B_task_p_DTG, Queue_5B_task_reward_DTG, Queue_5B_task_deadline_DTG, Queue_5B_task_bit_DTG]  =  chushihua(TASK5bit, REWARD5, TASK5deadline, TASK5p);
        Queue_F_DTG(5) = sum(TASK5_bit_all_DTG);
        TASK5_number_all_DTG = size(TASK5_bit_all_DTG, 2);
        Queue_B_DTG(5) = sum(Queue_5B_task_bit_DTG);
        Queue_5B_task_num_DTG = size(Queue_5B_task_bit_DTG, 2);
        Queue_5B_task_time_DTG = [];
        
        %% _CTG
        [TASK1_bit_all_CTG, TASK1_reward_all_CTG, TASK1_deadline_all_CTG, TASK1_p_all_CTG, ...
            Queue_1B_task_p_CTG, Queue_1B_task_reward_CTG, Queue_1B_task_deadline_CTG, Queue_1B_task_bit_CTG]  =  chushihua(TASK1bit, REWARD1, TASK1deadline, TASK1p);
        Queue_F_CTG(1) = sum(TASK1_bit_all_CTG);
        TASK1_number_all_CTG = size(TASK1_bit_all_CTG, 2);
        Queue_B_CTG(1) = sum(Queue_1B_task_bit_CTG);
        Queue_1B_task_num_CTG = size(Queue_1B_task_bit_CTG, 2);
        Queue_1B_task_time_CTG = [];
        
        [TASK2_bit_all_CTG, TASK2_reward_all_CTG, TASK2_deadline_all_CTG, TASK2_p_all_CTG, ...
            Queue_2B_task_p_CTG, Queue_2B_task_reward_CTG, Queue_2B_task_deadline_CTG, Queue_2B_task_bit_CTG]  =  chushihua(TASK2bit, REWARD2, TASK2deadline, TASK2p);
        Queue_F_CTG(2) = sum(TASK2_bit_all_CTG);
        TASK2_number_all_CTG = size(TASK2_bit_all_CTG, 2);
        Queue_B_CTG(2) = sum(Queue_2B_task_bit_CTG);
        Queue_2B_task_num_CTG = size(Queue_2B_task_bit_CTG, 2);
        Queue_2B_task_time_CTG = [];
        
        [TASK3_bit_all_CTG, TASK3_reward_all_CTG, TASK3_deadline_all_CTG, TASK3_p_all_CTG, ...
            Queue_3B_task_p_CTG, Queue_3B_task_reward_CTG, Queue_3B_task_deadline_CTG, Queue_3B_task_bit_CTG]  =  chushihua(TASK3bit, REWARD3, TASK3deadline, TASK3p);
        Queue_F_CTG(3) = sum(TASK3_bit_all_CTG);
        TASK3_number_all_CTG = size(TASK3_bit_all_CTG, 2);
        Queue_B_CTG(3) = sum(Queue_3B_task_bit_CTG);
        Queue_3B_task_num_CTG = size(Queue_3B_task_bit_CTG, 2);
        Queue_3B_task_time_CTG = [];
        
        [TASK4_bit_all_CTG, TASK4_reward_all_CTG, TASK4_deadline_all_CTG, TASK4_p_all_CTG, ...
            Queue_4B_task_p_CTG, Queue_4B_task_reward_CTG, Queue_4B_task_deadline_CTG, Queue_4B_task_bit_CTG]  =  chushihua(TASK4bit, REWARD4, TASK4deadline, TASK4p);
        Queue_F_CTG(4) = sum(TASK4_bit_all_CTG);
        TASK4_number_all_CTG = size(TASK4_bit_all_CTG, 2);
        Queue_B_CTG(4) = sum(Queue_4B_task_bit_CTG);
        Queue_4B_task_num_CTG = size(Queue_4B_task_bit_CTG, 2);
        Queue_4B_task_time_CTG = [];
        
        [TASK5_bit_all_CTG, TASK5_reward_all_CTG, TASK5_deadline_all_CTG, TASK5_p_all_CTG, ...
            Queue_5B_task_p_CTG, Queue_5B_task_reward_CTG, Queue_5B_task_deadline_CTG, Queue_5B_task_bit_CTG]  =  chushihua(TASK5bit, REWARD5, TASK5deadline, TASK5p);
        Queue_F_CTG(5) = sum(TASK5_bit_all_CTG);
        TASK5_number_all_CTG = size(TASK5_bit_all_CTG, 2);
        Queue_B_CTG(5) = sum(Queue_5B_task_bit_CTG);
        Queue_5B_task_num_CTG = size(Queue_5B_task_bit_CTG, 2);
        Queue_5B_task_time_CTG = [];
        
        %% _ETG
        [TASK1_bit_all_ETG, TASK1_reward_all_ETG, TASK1_deadline_all_ETG, TASK1_p_all_ETG, ...
            Queue_1B_task_p_ETG, Queue_1B_task_reward_ETG, Queue_1B_task_deadline_ETG, Queue_1B_task_bit_ETG]  =  chushihua(TASK1bit, REWARD1, TASK1deadline, TASK1p);
        Queue_F_ETG(1) = sum(TASK1_bit_all_ETG);
        TASK1_number_all_ETG = size(TASK1_bit_all_ETG, 2);
        Queue_B_ETG(1) = sum(Queue_1B_task_bit_ETG);
        Queue_1B_task_num_ETG = size(Queue_1B_task_bit_ETG, 2);
        Queue_1B_task_time_ETG = [];
        
        [TASK2_bit_all_ETG, TASK2_reward_all_ETG, TASK2_deadline_all_ETG, TASK2_p_all_ETG, Queue_2B_task_p_ETG, Queue_2B_task_reward_ETG, Queue_2B_task_deadline_ETG, Queue_2B_task_bit_ETG]  =  chushihua(TASK2bit, REWARD2, TASK2deadline, TASK2p);
        Queue_F_ETG(2) = sum(TASK2_bit_all_ETG);
        TASK2_number_all_ETG = size(TASK2_bit_all_ETG, 2);
        Queue_B_ETG(2) = sum(Queue_2B_task_bit_ETG);
        Queue_2B_task_num_ETG = size(Queue_2B_task_bit_ETG, 2);
        Queue_2B_task_time_ETG = [];
        
        [TASK3_bit_all_ETG, TASK3_reward_all_ETG, TASK3_deadline_all_ETG, TASK3_p_all_ETG, Queue_3B_task_p_ETG, Queue_3B_task_reward_ETG, Queue_3B_task_deadline_ETG, Queue_3B_task_bit_ETG]  =  chushihua(TASK3bit, REWARD3, TASK3deadline, TASK3p);
        Queue_F_ETG(3) = sum(TASK3_bit_all_ETG);
        TASK3_number_all_ETG = size(TASK3_bit_all_ETG, 2);
        Queue_B_ETG(3) = sum(Queue_3B_task_bit_ETG);
        Queue_3B_task_num_ETG = size(Queue_3B_task_bit_ETG, 2);
        Queue_3B_task_time_ETG = [];
        
        [TASK4_bit_all_ETG, TASK4_reward_all_ETG, TASK4_deadline_all_ETG, TASK4_p_all_ETG, Queue_4B_task_p_ETG, Queue_4B_task_reward_ETG, Queue_4B_task_deadline_ETG, Queue_4B_task_bit_ETG]  =  chushihua(TASK4bit, REWARD4, TASK4deadline, TASK4p);
        Queue_F_ETG(4) = sum(TASK4_bit_all_ETG);
        TASK4_number_all_ETG = size(TASK4_bit_all_ETG, 2);
        Queue_B_ETG(4) = sum(Queue_4B_task_bit_ETG);
        Queue_4B_task_num_ETG = size(Queue_4B_task_bit_ETG, 2);
        Queue_4B_task_time_ETG = [];
        
        [TASK5_bit_all_ETG, TASK5_reward_all_ETG, TASK5_deadline_all_ETG, TASK5_p_all_ETG, Queue_5B_task_p_ETG, Queue_5B_task_reward_ETG, Queue_5B_task_deadline_ETG, Queue_5B_task_bit_ETG]  =  chushihua(TASK5bit, REWARD5, TASK5deadline, TASK5p);
        Queue_F_ETG(5) = sum(TASK5_bit_all_ETG);
        TASK5_number_all_ETG = size(TASK5_bit_all_ETG, 2);
        Queue_B_ETG(5) = sum(Queue_5B_task_bit_ETG);
        Queue_5B_task_num_ETG = size(Queue_5B_task_bit_ETG, 2);
        Queue_5B_task_time_ETG = [];
    else
        %% OSC
        %% ES1;
        %%front_queue
        TASK1_bit_all_OSC = [bit_1re_OSC, TASK1bit, bit_2to1_OSC, bit_3to1_OSC, bit_4to1_OSC, bit_5to1_OSC];
        TASK1_reward_all_OSC = [reward_1re_OSC, REWARD1, reward_2to1_OSC, reward_3to1_OSC, reward_4to1_OSC, reward_5to1_OSC];
        TASK1_deadline_all_OSC = [deadline_1re_OSC, TASK1deadline, deadline_2to1_OSC, deadline_3to1_OSC, deadline_4to1_OSC, deadline_5to1_OSC];
        TASK1_p_all_OSC = [p_1re_OSC, TASK1p, p_2to1_OSC, p_3to1_OSC, p_4to1_OSC, p_5to1_OSC];
        %% task clear:out deadline task
        [TASK1_bit_all_OSC, TASK1_reward_all_OSC, TASK1_deadline_all_OSC, TASK1_p_all_OSC, mumber1_OSC]  =  clear_task(TASK1_bit_all_OSC, TASK1_reward_all_OSC, TASK1_deadline_all_OSC, TASK1_p_all_OSC);
        Queue_F_OSC(1) = sum(TASK1_bit_all_OSC);
        TASK1_number_all_OSC = size(TASK1_bit_all_OSC, 2);
        %%back_queue
        Queue_1B_task_p_OSC = Queue_1B_task_OSC{1};
        Queue_1B_task_reward_OSC = Queue_1B_task_OSC{2};
        Queue_1B_task_deadline_OSC = Queue_1B_task_OSC{3};
        Queue_1B_task_bit_OSC = Queue_1B_task_OSC{4};
        Queue_1B_task_p_OSC = [Queue_1B_task_p_OSC, p_1to1_OSC];
        Queue_1B_task_reward_OSC = [Queue_1B_task_reward_OSC, reward_1to1_OSC];
        Queue_1B_task_deadline_OSC = [Queue_1B_task_deadline_OSC, deadline_1to1_OSC];
        Queue_1B_task_bit_OSC = [Queue_1B_task_bit_OSC, bit_1to1_OSC];
        Queue_B_OSC(1) = sum(Queue_1B_task_bit_OSC);
        Queue_1B_task_num_OSC = size(Queue_1B_task_bit_OSC, 2);
        num_add1 = size(bit_1to1_OSC, 2);
        Queue_1B_task_time_OSC = [Queue_1B_task_time_OSC, zeros(1, num_add1)];
        disp('Queue_1B_task_time');
        %% ES2;
        TASK2_bit_all_OSC = [bit_2re_OSC, TASK2bit, bit_1to2_OSC, bit_3to2_OSC, bit_4to2_OSC, bit_5to2_OSC];
        TASK2_reward_all_OSC = [reward_2re_OSC, REWARD2, reward_1to2_OSC, reward_3to2_OSC, reward_4to2_OSC, reward_5to2_OSC];
        TASK2_deadline_all_OSC = [deadline_2re_OSC, TASK2deadline, deadline_1to2_OSC, deadline_3to2_OSC, deadline_4to2_OSC, deadline_5to2_OSC];
        TASK2_p_all_OSC = [p_2re_OSC, TASK2p, p_1to2_OSC, p_3to2_OSC, p_4to2_OSC, p_5to2_OSC];
        %% task clear:out deadline task
        [TASK2_bit_all_OSC, TASK2_reward_all_OSC, TASK2_deadline_all_OSC, TASK2_p_all_OSC, mumber2_OSC]  =  clear_task(TASK2_bit_all_OSC, TASK2_reward_all_OSC, TASK2_deadline_all_OSC, TASK2_p_all_OSC);
        Queue_F_OSC(2) = sum(TASK2_bit_all_OSC);
        TASK2_number_all_OSC = size(TASK2_bit_all_OSC, 2);
        %%back_queue
        %ES2;
        Queue_2B_task_p_OSC = Queue_2B_task_OSC{1};
        Queue_2B_task_reward_OSC = Queue_2B_task_OSC{2};
        Queue_2B_task_deadline_OSC = Queue_2B_task_OSC{3};
        Queue_2B_task_bit_OSC = Queue_2B_task_OSC{4};
        Queue_2B_task_p_OSC = [Queue_2B_task_p_OSC, p_2to2_OSC];
        Queue_2B_task_reward_OSC = [Queue_2B_task_reward_OSC, reward_2to2_OSC];
        Queue_2B_task_deadline_OSC = [Queue_2B_task_deadline_OSC, deadline_2to2_OSC];
        Queue_2B_task_bit_OSC = [Queue_2B_task_bit_OSC, bit_2to2_OSC];
        Queue_B_OSC(2) = sum(Queue_2B_task_bit_OSC);
        Queue_2B_task_num_OSC = size(Queue_2B_task_bit_OSC, 2);
        num_add2 = size(bit_2to2_OSC, 2);
        Queue_2B_task_time_OSC = [Queue_2B_task_time_OSC, zeros(1, num_add2)];
        %% ES3;
        TASK3_bit_all_OSC = [bit_3re_OSC, TASK3bit, bit_1to3_OSC, bit_2to3_OSC, bit_4to3_OSC, bit_5to3_OSC];
        TASK3_reward_all_OSC = [reward_3re_OSC, REWARD3, reward_1to3_OSC, reward_2to3_OSC, reward_4to3_OSC, reward_5to3_OSC];
        TASK3_deadline_all_OSC = [deadline_3re_OSC, TASK3deadline, deadline_1to3_OSC, deadline_2to3_OSC, deadline_4to3_OSC, deadline_5to3_OSC];
        TASK3_p_all_OSC = [p_3re_OSC, TASK3p, p_1to3_OSC, p_2to3_OSC, p_4to3_OSC, p_5to3_OSC];
        %% task clear:out deadline task
        [TASK3_bit_all_OSC, TASK3_reward_all_OSC, TASK3_deadline_all_OSC, TASK3_p_all_OSC, mumber3_OSC]  =  clear_task(TASK3_bit_all_OSC, TASK3_reward_all_OSC, TASK3_deadline_all_OSC, TASK3_p_all_OSC);
        Queue_F_OSC(3) = sum(TASK3_bit_all_OSC);
        TASK3_number_all_OSC = size(TASK3_bit_all_OSC, 2);
        %%back_queue
        %ES3;
        Queue_3B_task_p_OSC = Queue_3B_task_OSC{1};
        Queue_3B_task_reward_OSC = Queue_3B_task_OSC{2};
        Queue_3B_task_deadline_OSC = Queue_3B_task_OSC{3};
        Queue_3B_task_bit_OSC = Queue_3B_task_OSC{4};
        Queue_3B_task_p_OSC = [Queue_3B_task_p_OSC, p_3to3_OSC];
        Queue_3B_task_reward_OSC = [Queue_3B_task_reward_OSC, reward_3to3_OSC];
        Queue_3B_task_deadline_OSC = [Queue_3B_task_deadline_OSC, deadline_3to3_OSC];
        Queue_3B_task_bit_OSC = [Queue_3B_task_bit_OSC, bit_3to3_OSC];
        Queue_B_OSC(3) = sum(Queue_3B_task_bit_OSC);
        Queue_3B_task_num_OSC = size(Queue_3B_task_bit_OSC, 2);
        num_add3 = size(bit_3to3_OSC, 2);
        Queue_3B_task_time_OSC = [Queue_3B_task_time_OSC, zeros(1, num_add3)];
        %% ES4;
        TASK4_bit_all_OSC = [bit_4re_OSC, TASK4bit, bit_1to4_OSC, bit_2to4_OSC, bit_3to4_OSC, bit_5to4_OSC];
        TASK4_reward_all_OSC = [reward_4re_OSC, REWARD4, reward_1to4_OSC, reward_2to4_OSC, reward_3to4_OSC, reward_5to4_OSC];
        TASK4_deadline_all_OSC = [deadline_4re_OSC, TASK4deadline, deadline_1to4_OSC, deadline_2to4_OSC, deadline_3to4_OSC, deadline_5to4_OSC];
        TASK4_p_all_OSC = [p_4re_OSC, TASK4p, p_1to4_OSC, p_2to4_OSC, p_3to4_OSC, p_5to4_OSC];
        %% task clear:out deadline task
        [TASK4_bit_all_OSC, TASK4_reward_all_OSC, TASK4_deadline_all_OSC, TASK4_p_all_OSC, mumber4_OSC]  =  clear_task(TASK4_bit_all_OSC, TASK4_reward_all_OSC, TASK4_deadline_all_OSC, TASK4_p_all_OSC);
        Queue_F_OSC(4) = sum(TASK4_bit_all_OSC);
        TASK4_number_all_OSC = size(TASK4_bit_all_OSC, 2);
        %%back_queue
        %ES4;
        Queue_4B_task_p_OSC = Queue_4B_task_OSC{1};
        Queue_4B_task_reward_OSC = Queue_4B_task_OSC{2};
        Queue_4B_task_deadline_OSC = Queue_4B_task_OSC{3};
        Queue_4B_task_bit_OSC = Queue_4B_task_OSC{4};
        Queue_4B_task_p_OSC = [Queue_4B_task_p_OSC, p_4to4_OSC];
        Queue_4B_task_reward_OSC = [Queue_4B_task_reward_OSC, reward_4to4_OSC];
        Queue_4B_task_deadline_OSC = [Queue_4B_task_deadline_OSC, deadline_4to4_OSC];
        Queue_4B_task_bit_OSC = [Queue_4B_task_bit_OSC, bit_4to4_OSC];
        Queue_B_OSC(4) = sum(Queue_4B_task_bit_OSC);
        Queue_4B_task_num_OSC = size(Queue_4B_task_bit_OSC, 2);
        num_add4 = size(bit_4to4_OSC, 2);
        Queue_4B_task_time_OSC = [Queue_4B_task_time_OSC, zeros(1, num_add4)];
        %% ES5;
        TASK5_bit_all_OSC = [bit_5re_OSC, TASK5bit, bit_1to5_OSC, bit_2to5_OSC, bit_3to5_OSC, bit_4to5_OSC];
        TASK5_reward_all_OSC = [reward_5re_OSC, REWARD5, reward_1to5_OSC, reward_2to5_OSC, reward_3to5_OSC, reward_4to5_OSC];
        TASK5_deadline_all_OSC = [deadline_5re_OSC, TASK5deadline, deadline_1to5_OSC, deadline_2to5_OSC, deadline_3to5_OSC, deadline_4to5_OSC];
        TASK5_p_all_OSC = [p_5re_OSC, TASK5p, p_1to5_OSC, p_2to5_OSC, p_3to5_OSC, p_4to5_OSC];
        %% task clear:out deadline task
        [TASK5_bit_all_OSC, TASK5_reward_all_OSC, TASK5_deadline_all_OSC, TASK5_p_all_OSC, mumber5_OSC]  =  clear_task(TASK5_bit_all_OSC, TASK5_reward_all_OSC, TASK5_deadline_all_OSC, TASK5_p_all_OSC);
        Queue_F_OSC(5) = sum(TASK5_bit_all_OSC);
        TASK5_number_all_OSC = size(TASK5_bit_all_OSC, 2);
        %%back_queue
        %ES5;
        Queue_5B_task_p_OSC = Queue_5B_task_OSC{1};
        Queue_5B_task_reward_OSC = Queue_5B_task_OSC{2};
        Queue_5B_task_deadline_OSC = Queue_5B_task_OSC{3};
        Queue_5B_task_bit_OSC = Queue_5B_task_OSC{4};
        Queue_5B_task_p_OSC = [Queue_5B_task_p_OSC, p_5to5_OSC];
        Queue_5B_task_reward_OSC = [Queue_5B_task_reward_OSC, reward_5to5_OSC];
        Queue_5B_task_deadline_OSC = [Queue_5B_task_deadline_OSC, deadline_5to5_OSC];
        Queue_5B_task_bit_OSC = [Queue_5B_task_bit_OSC, bit_5to5_OSC];
        Queue_B_OSC(5) = sum(Queue_5B_task_bit_OSC);
        Queue_5B_task_num_OSC = size(Queue_5B_task_bit_OSC, 2);
        num_add5 = size(bit_5to5_OSC, 2);
        Queue_5B_task_time_OSC = [Queue_5B_task_time_OSC, zeros(1, num_add5)];
        
        %% DTG algorim
        %% ES1;
        %%front_queue
        TASK1_bit_all_DTG = [bit_1re_DTG, TASK1bit, bit_2to1_DTG, bit_3to1_DTG, bit_4to1_DTG, bit_5to1_DTG];
        TASK1_reward_all_DTG = [reward_1re_DTG, REWARD1, reward_2to1_DTG, reward_3to1_DTG, reward_4to1_DTG, reward_5to1_DTG];
        TASK1_deadline_all_DTG = [deadline_1re_DTG, TASK1deadline, deadline_2to1_DTG, deadline_3to1_DTG, deadline_4to1_DTG, deadline_5to1_DTG];
        TASK1_p_all_DTG = [p_1re_DTG, TASK1p, p_2to1_DTG, p_3to1_DTG, p_4to1_DTG, p_5to1_DTG];
        %% task clear:out deadline task
        [TASK1_bit_all_DTG, TASK1_reward_all_DTG, TASK1_deadline_all_DTG, TASK1_p_all_DTG, mumber1_DTG]  =  clear_task(TASK1_bit_all_DTG, TASK1_reward_all_DTG, TASK1_deadline_all_DTG, TASK1_p_all_DTG);
        Queue_F_DTG(1) = sum(TASK1_bit_all_DTG);
        TASK1_number_all_DTG = size(TASK1_bit_all_DTG, 2);
        %%back_queue
        Queue_1B_task_p_DTG = Queue_1B_task_DTG{1};
        Queue_1B_task_reward_DTG = Queue_1B_task_DTG{2};
        Queue_1B_task_deadline_DTG = Queue_1B_task_DTG{3};
        Queue_1B_task_bit_DTG = Queue_1B_task_DTG{4};
        Queue_1B_task_p_DTG = [Queue_1B_task_p_DTG, p_1to1_DTG];
        Queue_1B_task_reward_DTG = [Queue_1B_task_reward_DTG, reward_1to1_DTG];
        Queue_1B_task_deadline_DTG = [Queue_1B_task_deadline_DTG, deadline_1to1_DTG];
        Queue_1B_task_bit_DTG = [Queue_1B_task_bit_DTG, bit_1to1_DTG];
        Queue_B_DTG(1) = sum(Queue_1B_task_bit_DTG);
        Queue_1B_task_num_DTG = size(Queue_1B_task_bit_DTG, 2);
        num_add1_DTG = size(bit_1to1_DTG, 2);
        Queue_1B_task_time_DTG = [Queue_1B_task_time_DTG, zeros(1, num_add1_DTG)];
        %% ES2;
        %%front_queue
        TASK2_bit_all_DTG = [bit_2re_DTG, TASK2bit, bit_1to2_DTG, bit_3to2_DTG, bit_4to2_DTG, bit_5to2_DTG];
        TASK2_reward_all_DTG = [reward_2re_DTG, REWARD2, reward_1to2_DTG, reward_3to2_DTG, reward_4to2_DTG, reward_5to2_DTG];
        TASK2_deadline_all_DTG = [deadline_2re_DTG, TASK2deadline, deadline_1to2_DTG, deadline_3to2_DTG, deadline_4to2_DTG, deadline_5to2_DTG];
        TASK2_p_all_DTG = [p_2re_DTG, TASK2p, p_1to2_DTG, p_3to2_DTG, p_4to2_DTG, p_5to2_DTG];
        %% task clear:out deadline task
        [TASK2_bit_all_DTG, TASK2_reward_all_DTG, TASK2_deadline_all_DTG, TASK2_p_all_DTG, mumber2_DTG]  =  clear_task(TASK2_bit_all_DTG, TASK2_reward_all_DTG, TASK2_deadline_all_DTG, TASK2_p_all_DTG);
        Queue_F_DTG(2) = sum(TASK2_bit_all_DTG);
        TASK2_number_all_DTG = size(TASK2_bit_all_DTG, 2);
        %%back_queue
        Queue_2B_task_p_DTG = Queue_2B_task_DTG{1};
        Queue_2B_task_reward_DTG = Queue_2B_task_DTG{2};
        Queue_2B_task_deadline_DTG = Queue_2B_task_DTG{3};
        Queue_2B_task_bit_DTG = Queue_2B_task_DTG{4};
        Queue_2B_task_p_DTG = [Queue_2B_task_p_DTG, p_2to2_DTG];
        Queue_2B_task_reward_DTG = [Queue_2B_task_reward_DTG, reward_2to2_DTG];
        Queue_2B_task_deadline_DTG = [Queue_2B_task_deadline_DTG, deadline_2to2_DTG];
        Queue_2B_task_bit_DTG = [Queue_2B_task_bit_DTG, bit_2to2_DTG];
        Queue_B_DTG(2) = sum(Queue_2B_task_bit_DTG);
        Queue_2B_task_num_DTG = size(Queue_2B_task_bit_DTG, 2);
        num_add2_DTG = size(bit_2to2_DTG, 2);
        Queue_2B_task_time_DTG = [Queue_2B_task_time_DTG, zeros(1, num_add2_DTG)];
        %% ES3;
        %%front_queue
        TASK3_bit_all_DTG = [bit_3re_DTG, TASK3bit, bit_1to3_DTG, bit_2to3_DTG, bit_4to3_DTG, bit_5to3_DTG];
        TASK3_reward_all_DTG = [reward_3re_DTG, REWARD3, reward_1to3_DTG, reward_2to3_DTG, reward_4to3_DTG, reward_5to3_DTG];
        TASK3_deadline_all_DTG = [deadline_3re_DTG, TASK3deadline, deadline_1to3_DTG, deadline_2to3_DTG, deadline_4to3_DTG, deadline_5to3_DTG];
        TASK3_p_all_DTG = [p_3re_DTG, TASK3p, p_1to3_DTG, p_2to3_DTG, p_4to3_DTG, p_5to3_DTG];
        %% task clear:out deadline task
        [TASK3_bit_all_DTG, TASK3_reward_all_DTG, TASK3_deadline_all_DTG, TASK3_p_all_DTG, mumber3_DTG]  =  clear_task(TASK3_bit_all_DTG, TASK3_reward_all_DTG, TASK3_deadline_all_DTG, TASK3_p_all_DTG);
        Queue_F_DTG(3) = sum(TASK3_bit_all_DTG);
        TASK3_number_all_DTG = size(TASK3_bit_all_DTG, 2);
        %%back_queue
        Queue_3B_task_p_DTG = Queue_3B_task_DTG{1};
        Queue_3B_task_reward_DTG = Queue_3B_task_DTG{2};
        Queue_3B_task_deadline_DTG = Queue_3B_task_DTG{3};
        Queue_3B_task_bit_DTG = Queue_3B_task_DTG{4};
        Queue_3B_task_p_DTG = [Queue_3B_task_p_DTG, p_3to3_DTG];
        Queue_3B_task_reward_DTG = [Queue_3B_task_reward_DTG, reward_3to3_DTG];
        Queue_3B_task_deadline_DTG = [Queue_3B_task_deadline_DTG, deadline_3to3_DTG];
        Queue_3B_task_bit_DTG = [Queue_3B_task_bit_DTG, bit_3to3_DTG];
        Queue_B_DTG(3) = sum(Queue_3B_task_bit_DTG);
        Queue_3B_task_num_DTG = size(Queue_3B_task_bit_DTG, 2);
        num_add3_DTG = size(bit_3to3_DTG, 2);
        Queue_3B_task_time_DTG = [Queue_3B_task_time_DTG, zeros(1, num_add3_DTG)];
        %% ES4;
        %%front_queue
        TASK4_bit_all_DTG = [bit_4re_DTG, TASK4bit, bit_1to4_DTG, bit_2to4_DTG, bit_3to4_DTG, bit_5to4_DTG];
        TASK4_reward_all_DTG = [reward_4re_DTG, REWARD4, reward_1to4_DTG, reward_2to4_DTG, reward_3to4_DTG, reward_5to4_DTG];
        TASK4_deadline_all_DTG = [deadline_4re_DTG, TASK4deadline, deadline_1to4_DTG, deadline_2to4_DTG, deadline_3to4_DTG, deadline_5to4_DTG];
        TASK4_p_all_DTG = [p_4re_DTG, TASK4p, p_1to4_DTG, p_2to4_DTG, p_3to4_DTG, p_5to4_DTG];
        %% task clear:out deadline task
        [TASK4_bit_all_DTG, TASK4_reward_all_DTG, TASK4_deadline_all_DTG, TASK4_p_all_DTG, mumber4_DTG]  =  clear_task(TASK4_bit_all_DTG, TASK4_reward_all_DTG, TASK4_deadline_all_DTG, TASK4_p_all_DTG);
        Queue_F_DTG(4) = sum(TASK4_bit_all_DTG);
        TASK4_number_all_DTG = size(TASK4_bit_all_DTG, 2);
        %%back_queue
        Queue_4B_task_p_DTG = Queue_4B_task_DTG{1};
        Queue_4B_task_reward_DTG = Queue_4B_task_DTG{2};
        Queue_4B_task_deadline_DTG = Queue_4B_task_DTG{3};
        Queue_4B_task_bit_DTG = Queue_4B_task_DTG{4};
        Queue_4B_task_p_DTG = [Queue_4B_task_p_DTG, p_4to4_DTG];
        Queue_4B_task_reward_DTG = [Queue_4B_task_reward_DTG, reward_4to4_DTG];
        Queue_4B_task_deadline_DTG = [Queue_4B_task_deadline_DTG, deadline_4to4_DTG];
        Queue_4B_task_bit_DTG = [Queue_4B_task_bit_DTG, bit_4to4_DTG];
        Queue_B_DTG(4) = sum(Queue_4B_task_bit_DTG);
        Queue_4B_task_num_DTG = size(Queue_4B_task_bit_DTG, 2);
        num_add4_DTG = size(bit_4to4_DTG, 2);
        Queue_4B_task_time_DTG = [Queue_4B_task_time_DTG, zeros(1, num_add4_DTG)];
        %% ES5;
        %%front_queue
        TASK5_bit_all_DTG = [bit_5re_DTG, TASK5bit, bit_1to5_DTG, bit_2to5_DTG, bit_3to5_DTG, bit_4to5_DTG];
        TASK5_reward_all_DTG = [reward_5re_DTG, REWARD5, reward_1to5_DTG, reward_2to5_DTG, reward_3to5_DTG, reward_4to5_DTG];
        TASK5_deadline_all_DTG = [deadline_5re_DTG, TASK5deadline, deadline_1to5_DTG, deadline_2to5_DTG, deadline_3to5_DTG, deadline_4to5_DTG];
        TASK5_p_all_DTG = [p_5re_DTG, TASK5p, p_1to5_DTG, p_2to5_DTG, p_3to5_DTG, p_4to5_DTG];
        %% task clear:out deadline task
        [TASK5_bit_all_DTG, TASK5_reward_all_DTG, TASK5_deadline_all_DTG, TASK5_p_all_DTG, mumber5_DTG]  =  clear_task(TASK5_bit_all_DTG, TASK5_reward_all_DTG, TASK5_deadline_all_DTG, TASK5_p_all_DTG);
        Queue_F_DTG(5) = sum(TASK5_bit_all_DTG);
        TASK5_number_all_DTG = size(TASK5_bit_all_DTG, 2);
        %%back_queue
        Queue_5B_task_p_DTG = Queue_5B_task_DTG{1};
        Queue_5B_task_reward_DTG = Queue_5B_task_DTG{2};
        Queue_5B_task_deadline_DTG = Queue_5B_task_DTG{3};
        Queue_5B_task_bit_DTG = Queue_5B_task_DTG{4};
        Queue_5B_task_p_DTG = [Queue_5B_task_p_DTG, p_5to5_DTG];
        Queue_5B_task_reward_DTG = [Queue_5B_task_reward_DTG, reward_5to5_DTG];
        Queue_5B_task_deadline_DTG = [Queue_5B_task_deadline_DTG, deadline_5to5_DTG];
        Queue_5B_task_bit_DTG = [Queue_5B_task_bit_DTG, bit_5to5_DTG];
        Queue_B_DTG(5) = sum(Queue_5B_task_bit_DTG);
        Queue_5B_task_num_DTG = size(Queue_5B_task_bit_DTG, 2);
        num_add5_DTG = size(bit_5to5_DTG, 2);
        Queue_5B_task_time_DTG = [Queue_5B_task_time_DTG, zeros(1, num_add5_DTG)];
        
        %% CTG algorim
        %% ES1;
        %%front_queue
        TASK1_bit_all_CTG = [bit_1re_CTG, TASK1bit, bit_2to1_CTG, bit_3to1_CTG, bit_4to1_CTG, bit_5to1_CTG];
        TASK1_reward_all_CTG = [reward_1re_CTG, REWARD1, reward_2to1_CTG, reward_3to1_CTG, reward_4to1_CTG, reward_5to1_CTG];
        TASK1_deadline_all_CTG = [deadline_1re_CTG, TASK1deadline, deadline_2to1_CTG, deadline_3to1_CTG, deadline_4to1_CTG, deadline_5to1_CTG];
        TASK1_p_all_CTG = [p_1re_CTG, TASK1p, p_2to1_CTG, p_3to1_CTG, p_4to1_CTG, p_5to1_CTG];
        %% task clear:out deadline task
        [TASK1_bit_all_CTG, TASK1_reward_all_CTG, TASK1_deadline_all_CTG, TASK1_p_all_CTG, mumber1_CTG]  =  clear_task(TASK1_bit_all_CTG, TASK1_reward_all_CTG, TASK1_deadline_all_CTG, TASK1_p_all_CTG);
        Queue_F_CTG(1) = sum(TASK1_bit_all_CTG);
        TASK1_number_all_CTG = size(TASK1_bit_all_CTG, 2);
        %%back_queue
        Queue_1B_task_p_CTG = Queue_1B_task_CTG{1};
        Queue_1B_task_reward_CTG = Queue_1B_task_CTG{2};
        Queue_1B_task_deadline_CTG = Queue_1B_task_CTG{3};
        Queue_1B_task_bit_CTG = Queue_1B_task_CTG{4};
        Queue_1B_task_p_CTG = [Queue_1B_task_p_CTG, p_1to1_CTG];
        Queue_1B_task_reward_CTG = [Queue_1B_task_reward_CTG, reward_1to1_CTG];
        Queue_1B_task_deadline_CTG = [Queue_1B_task_deadline_CTG, deadline_1to1_CTG];
        Queue_1B_task_bit_CTG = [Queue_1B_task_bit_CTG, bit_1to1_CTG];
        Queue_B_CTG(1) = sum(Queue_1B_task_bit_CTG);
        Queue_1B_task_num_CTG = size(Queue_1B_task_bit_CTG, 2);
        num_add1_CTG = size(bit_1to1_CTG, 2);
        Queue_1B_task_time_CTG = [Queue_1B_task_time_CTG, zeros(1, num_add1_CTG)];
        %% ES2;
        %%front_queue
        TASK2_bit_all_CTG = [bit_2re_CTG, TASK2bit, bit_1to2_CTG, bit_3to2_CTG, bit_4to2_CTG, bit_5to2_CTG];
        TASK2_reward_all_CTG = [reward_2re_CTG, REWARD2, reward_1to2_CTG, reward_3to2_CTG, reward_4to2_CTG, reward_5to2_CTG];
        TASK2_deadline_all_CTG = [deadline_2re_CTG, TASK2deadline, deadline_1to2_CTG, deadline_3to2_CTG, deadline_4to2_CTG, deadline_5to2_CTG];
        TASK2_p_all_CTG = [p_2re_CTG, TASK2p, p_1to2_CTG, p_3to2_CTG, p_4to2_CTG, p_5to2_CTG];
        %% task clear:out deadline task
        [TASK2_bit_all_CTG, TASK2_reward_all_CTG, TASK2_deadline_all_CTG, TASK2_p_all_CTG, mumber2_CTG]  =  clear_task(TASK2_bit_all_CTG, TASK2_reward_all_CTG, TASK2_deadline_all_CTG, TASK2_p_all_CTG);
        Queue_F_CTG(2) = sum(TASK2_bit_all_CTG);
        TASK2_number_all_CTG = size(TASK2_bit_all_CTG, 2);
        %%back_queue
        Queue_2B_task_p_CTG = Queue_2B_task_CTG{1};
        Queue_2B_task_reward_CTG = Queue_2B_task_CTG{2};
        Queue_2B_task_deadline_CTG = Queue_2B_task_CTG{3};
        Queue_2B_task_bit_CTG = Queue_2B_task_CTG{4};
        Queue_2B_task_p_CTG = [Queue_2B_task_p_CTG, p_2to2_CTG];
        Queue_2B_task_reward_CTG = [Queue_2B_task_reward_CTG, reward_2to2_CTG];
        Queue_2B_task_deadline_CTG = [Queue_2B_task_deadline_CTG, deadline_2to2_CTG];
        Queue_2B_task_bit_CTG = [Queue_2B_task_bit_CTG, bit_2to2_CTG];
        Queue_B_CTG(2) = sum(Queue_2B_task_bit_CTG);
        Queue_2B_task_num_CTG = size(Queue_2B_task_bit_CTG, 2);
        num_add2_CTG = size(bit_2to2_CTG, 2);
        Queue_2B_task_time_CTG = [Queue_2B_task_time_CTG, zeros(1, num_add2_CTG)];
        %% ES3;
        %%front_queue
        TASK3_bit_all_CTG = [bit_3re_CTG, TASK3bit, bit_1to3_CTG, bit_2to3_CTG, bit_4to3_CTG, bit_5to3_CTG];
        TASK3_reward_all_CTG = [reward_3re_CTG, REWARD3, reward_1to3_CTG, reward_2to3_CTG, reward_4to3_CTG, reward_5to3_CTG];
        TASK3_deadline_all_CTG = [deadline_3re_CTG, TASK3deadline, deadline_1to3_CTG, deadline_2to3_CTG, deadline_4to3_CTG, deadline_5to3_CTG];
        TASK3_p_all_CTG = [p_3re_CTG, TASK3p, p_1to3_CTG, p_2to3_CTG, p_4to3_CTG, p_5to3_CTG];
        %% task clear:out deadline task
        [TASK3_bit_all_CTG, TASK3_reward_all_CTG, TASK3_deadline_all_CTG, TASK3_p_all_CTG, mumber3_CTG]  =  clear_task(TASK3_bit_all_CTG, TASK3_reward_all_CTG, TASK3_deadline_all_CTG, TASK3_p_all_CTG);
        Queue_F_CTG(3) = sum(TASK3_bit_all_CTG);
        TASK3_number_all_CTG = size(TASK3_bit_all_CTG, 2);
        %%back_queue
        Queue_3B_task_p_CTG = Queue_3B_task_CTG{1};
        Queue_3B_task_reward_CTG = Queue_3B_task_CTG{2};
        Queue_3B_task_deadline_CTG = Queue_3B_task_CTG{3};
        Queue_3B_task_bit_CTG = Queue_3B_task_CTG{4};
        Queue_3B_task_p_CTG = [Queue_3B_task_p_CTG, p_3to3_CTG];
        Queue_3B_task_reward_CTG = [Queue_3B_task_reward_CTG, reward_3to3_CTG];
        Queue_3B_task_deadline_CTG = [Queue_3B_task_deadline_CTG, deadline_3to3_CTG];
        Queue_3B_task_bit_CTG = [Queue_3B_task_bit_CTG, bit_3to3_CTG];
        Queue_B_CTG(3) = sum(Queue_3B_task_bit_CTG);
        Queue_3B_task_num_CTG = size(Queue_3B_task_bit_CTG, 2);
        num_add3_CTG = size(bit_3to3_CTG, 2);
        Queue_3B_task_time_CTG = [Queue_3B_task_time_CTG, zeros(1, num_add3_CTG)];
        %% ES4;
        %%front_queue
        TASK4_bit_all_CTG = [bit_4re_CTG, TASK4bit, bit_1to4_CTG, bit_2to4_CTG, bit_3to4_CTG, bit_5to4_CTG];
        TASK4_reward_all_CTG = [reward_4re_CTG, REWARD4, reward_1to4_CTG, reward_2to4_CTG, reward_3to4_CTG, reward_5to4_CTG];
        TASK4_deadline_all_CTG = [deadline_4re_CTG, TASK4deadline, deadline_1to4_CTG, deadline_2to4_CTG, deadline_3to4_CTG, deadline_5to4_CTG];
        TASK4_p_all_CTG = [p_4re_CTG, TASK4p, p_1to4_CTG, p_2to4_CTG, p_3to4_CTG, p_5to4_CTG];
        %% task clear:out deadline task
        [TASK4_bit_all_CTG, TASK4_reward_all_CTG, TASK4_deadline_all_CTG, TASK4_p_all_CTG, mumber4_CTG]  =  clear_task(TASK4_bit_all_CTG, TASK4_reward_all_CTG, TASK4_deadline_all_CTG, TASK4_p_all_CTG);
        Queue_F_CTG(4) = sum(TASK4_bit_all_CTG);
        TASK4_number_all_CTG = size(TASK4_bit_all_CTG, 2);
        %%back_queue
        Queue_4B_task_p_CTG = Queue_4B_task_CTG{1};
        Queue_4B_task_reward_CTG = Queue_4B_task_CTG{2};
        Queue_4B_task_deadline_CTG = Queue_4B_task_CTG{3};
        Queue_4B_task_bit_CTG = Queue_4B_task_CTG{4};
        Queue_4B_task_p_CTG = [Queue_4B_task_p_CTG, p_4to4_CTG];
        Queue_4B_task_reward_CTG = [Queue_4B_task_reward_CTG, reward_4to4_CTG];
        Queue_4B_task_deadline_CTG = [Queue_4B_task_deadline_CTG, deadline_4to4_CTG];
        Queue_4B_task_bit_CTG = [Queue_4B_task_bit_CTG, bit_4to4_CTG];
        Queue_B_CTG(4) = sum(Queue_4B_task_bit_CTG);
        Queue_4B_task_num_CTG = size(Queue_4B_task_bit_CTG, 2);
        num_add4_CTG = size(bit_4to4_CTG, 2);
        Queue_4B_task_time_CTG = [Queue_4B_task_time_CTG, zeros(1, num_add4_CTG)];
        %% ES5;
        %%front_queue
        TASK5_bit_all_CTG = [bit_5re_CTG, TASK5bit, bit_1to5_CTG, bit_2to5_CTG, bit_3to5_CTG, bit_4to5_CTG];
        TASK5_reward_all_CTG = [reward_5re_CTG, REWARD5, reward_1to5_CTG, reward_2to5_CTG, reward_3to5_CTG, reward_4to5_CTG];
        TASK5_deadline_all_CTG = [deadline_5re_CTG, TASK5deadline, deadline_1to5_CTG, deadline_2to5_CTG, deadline_3to5_CTG, deadline_4to5_CTG];
        TASK5_p_all_CTG = [p_5re_CTG, TASK5p, p_1to5_CTG, p_2to5_CTG, p_3to5_CTG, p_4to5_CTG];
        %% task clear:out deadline task
        [TASK5_bit_all_CTG, TASK5_reward_all_CTG, TASK5_deadline_all_CTG, TASK5_p_all_CTG, mumber5_CTG]  =  clear_task(TASK5_bit_all_CTG, TASK5_reward_all_CTG, TASK5_deadline_all_CTG, TASK5_p_all_CTG);
        Queue_F_CTG(5) = sum(TASK5_bit_all_CTG);
        TASK5_number_all_CTG = size(TASK5_bit_all_CTG, 2);
        %%back_queue
        Queue_5B_task_p_CTG = Queue_5B_task_CTG{1};
        Queue_5B_task_reward_CTG = Queue_5B_task_CTG{2};
        Queue_5B_task_deadline_CTG = Queue_5B_task_CTG{3};
        Queue_5B_task_bit_CTG = Queue_5B_task_CTG{4};
        Queue_5B_task_p_CTG = [Queue_5B_task_p_CTG, p_5to5_CTG];
        Queue_5B_task_reward_CTG = [Queue_5B_task_reward_CTG, reward_5to5_CTG];
        Queue_5B_task_deadline_CTG = [Queue_5B_task_deadline_CTG, deadline_5to5_CTG];
        Queue_5B_task_bit_CTG = [Queue_5B_task_bit_CTG, bit_5to5_CTG];
        Queue_B_CTG(5) = sum(Queue_5B_task_bit_CTG);
        Queue_5B_task_num_CTG = size(Queue_5B_task_bit_CTG, 2);
        num_add5_CTG = size(bit_5to5_CTG, 2);
        Queue_5B_task_time_CTG = [Queue_5B_task_time_CTG, zeros(1, num_add5_CTG)];
        
        %% ETG algorim
        %% ES1;
        %%front_queue
        TASK1_bit_all_ETG = [bit_1re_ETG, TASK1bit, bit_2to1_ETG, bit_3to1_ETG, bit_4to1_ETG, bit_5to1_ETG];
        TASK1_reward_all_ETG = [reward_1re_ETG, REWARD1, reward_2to1_ETG, reward_3to1_ETG, reward_4to1_ETG, reward_5to1_ETG];
        TASK1_deadline_all_ETG = [deadline_1re_ETG, TASK1deadline, deadline_2to1_ETG, deadline_3to1_ETG, deadline_4to1_ETG, deadline_5to1_ETG];
        TASK1_p_all_ETG = [p_1re_ETG, TASK1p, p_2to1_ETG, p_3to1_ETG, p_4to1_ETG, p_5to1_ETG];
        %% task clear:out deadline task
        [TASK1_bit_all_ETG, TASK1_reward_all_ETG, TASK1_deadline_all_ETG, TASK1_p_all_ETG, mumber1_ETG]  =  clear_task(TASK1_bit_all_ETG, TASK1_reward_all_ETG, TASK1_deadline_all_ETG, TASK1_p_all_ETG);
        Queue_F_ETG(1) = sum(TASK1_bit_all_ETG);
        TASK1_number_all_ETG = size(TASK1_bit_all_ETG, 2);
        %%back_queue
        Queue_1B_task_p_ETG = Queue_1B_task_ETG{1};
        Queue_1B_task_reward_ETG = Queue_1B_task_ETG{2};
        Queue_1B_task_deadline_ETG = Queue_1B_task_ETG{3};
        Queue_1B_task_bit_ETG = Queue_1B_task_ETG{4};
        Queue_1B_task_p_ETG = [Queue_1B_task_p_ETG, p_1to1_ETG];
        Queue_1B_task_reward_ETG = [Queue_1B_task_reward_ETG, reward_1to1_ETG];
        Queue_1B_task_deadline_ETG = [Queue_1B_task_deadline_ETG, deadline_1to1_ETG];
        Queue_1B_task_bit_ETG = [Queue_1B_task_bit_ETG, bit_1to1_ETG];
        Queue_B_ETG(1) = sum(Queue_1B_task_bit_ETG);
        Queue_1B_task_num_ETG = size(Queue_1B_task_bit_ETG, 2);
        num_add1_ETG = size(bit_1to1_ETG, 2);
        Queue_1B_task_time_ETG = [Queue_1B_task_time_ETG, zeros(1, num_add1_ETG)];
        %% ES2;
        %%front_queue
        TASK2_bit_all_ETG = [bit_2re_ETG, TASK2bit, bit_1to2_ETG, bit_3to2_ETG, bit_4to2_ETG, bit_5to2_ETG];
        TASK2_reward_all_ETG = [reward_2re_ETG, REWARD2, reward_1to2_ETG, reward_3to2_ETG, reward_4to2_ETG, reward_5to2_ETG];
        TASK2_deadline_all_ETG = [deadline_2re_ETG, TASK2deadline, deadline_1to2_ETG, deadline_3to2_ETG, deadline_4to2_ETG, deadline_5to2_ETG];
        TASK2_p_all_ETG = [p_2re_ETG, TASK2p, p_1to2_ETG, p_3to2_ETG, p_4to2_ETG, p_5to2_ETG];
        %% task clear:out deadline task
        [TASK2_bit_all_ETG, TASK2_reward_all_ETG, TASK2_deadline_all_ETG, TASK2_p_all_ETG, mumber2_ETG]  =  clear_task(TASK2_bit_all_ETG, TASK2_reward_all_ETG, TASK2_deadline_all_ETG, TASK2_p_all_ETG);
        Queue_F_ETG(2) = sum(TASK2_bit_all_ETG);
        TASK2_number_all_ETG = size(TASK2_bit_all_ETG, 2);
        %%back_queue
        Queue_2B_task_p_ETG = Queue_2B_task_ETG{1};
        Queue_2B_task_reward_ETG = Queue_2B_task_ETG{2};
        Queue_2B_task_deadline_ETG = Queue_2B_task_ETG{3};
        Queue_2B_task_bit_ETG = Queue_2B_task_ETG{4};
        Queue_2B_task_p_ETG = [Queue_2B_task_p_ETG, p_2to2_ETG];
        Queue_2B_task_reward_ETG = [Queue_2B_task_reward_ETG, reward_2to2_ETG];
        Queue_2B_task_deadline_ETG = [Queue_2B_task_deadline_ETG, deadline_2to2_ETG];
        Queue_2B_task_bit_ETG = [Queue_2B_task_bit_ETG, bit_2to2_ETG];
        Queue_B_ETG(2) = sum(Queue_2B_task_bit_ETG);
        Queue_2B_task_num_ETG = size(Queue_2B_task_bit_ETG, 2);
        num_add2_ETG = size(bit_2to2_ETG, 2);
        Queue_2B_task_time_ETG = [Queue_2B_task_time_ETG, zeros(1, num_add2_ETG)];
        %% ES3;
        %%front_queue
        TASK3_bit_all_ETG = [bit_3re_ETG, TASK3bit, bit_1to3_ETG, bit_2to3_ETG, bit_4to3_ETG, bit_5to3_ETG];
        TASK3_reward_all_ETG = [reward_3re_ETG, REWARD3, reward_1to3_ETG, reward_2to3_ETG, reward_4to3_ETG, reward_5to3_ETG];
        TASK3_deadline_all_ETG = [deadline_3re_ETG, TASK3deadline, deadline_1to3_ETG, deadline_2to3_ETG, deadline_4to3_ETG, deadline_5to3_ETG];
        TASK3_p_all_ETG = [p_3re_ETG, TASK3p, p_1to3_ETG, p_2to3_ETG, p_4to3_ETG, p_5to3_ETG];
        %% task clear:out deadline task
        [TASK3_bit_all_ETG, TASK3_reward_all_ETG, TASK3_deadline_all_ETG, TASK3_p_all_ETG, mumber3_ETG]  =  clear_task(TASK3_bit_all_ETG, TASK3_reward_all_ETG, TASK3_deadline_all_ETG, TASK3_p_all_ETG);
        Queue_F_ETG(3) = sum(TASK3_bit_all_ETG);
        TASK3_number_all_ETG = size(TASK3_bit_all_ETG, 2);
        %%back_queue
        Queue_3B_task_p_ETG = Queue_3B_task_ETG{1};
        Queue_3B_task_reward_ETG = Queue_3B_task_ETG{2};
        Queue_3B_task_deadline_ETG = Queue_3B_task_ETG{3};
        Queue_3B_task_bit_ETG = Queue_3B_task_ETG{4};
        Queue_3B_task_p_ETG = [Queue_3B_task_p_ETG, p_3to3_ETG];
        Queue_3B_task_reward_ETG = [Queue_3B_task_reward_ETG, reward_3to3_ETG];
        Queue_3B_task_deadline_ETG = [Queue_3B_task_deadline_ETG, deadline_3to3_ETG];
        Queue_3B_task_bit_ETG = [Queue_3B_task_bit_ETG, bit_3to3_ETG];
        Queue_B_ETG(3) = sum(Queue_3B_task_bit_ETG);
        Queue_3B_task_num_ETG = size(Queue_3B_task_bit_ETG, 2);
        num_add3_ETG = size(bit_3to3_ETG, 2);
        Queue_3B_task_time_ETG = [Queue_3B_task_time_ETG, zeros(1, num_add3_ETG)];
        %% ES4;
        %%front_queue
        TASK4_bit_all_ETG = [bit_4re_ETG, TASK4bit, bit_1to4_ETG, bit_2to4_ETG, bit_3to4_ETG, bit_5to4_ETG];
        TASK4_reward_all_ETG = [reward_4re_ETG, REWARD4, reward_1to4_ETG, reward_2to4_ETG, reward_3to4_ETG, reward_5to4_ETG];
        TASK4_deadline_all_ETG = [deadline_4re_ETG, TASK4deadline, deadline_1to4_ETG, deadline_2to4_ETG, deadline_3to4_ETG, deadline_5to4_ETG];
        TASK4_p_all_ETG = [p_4re_ETG, TASK4p, p_1to4_ETG, p_2to4_ETG, p_3to4_ETG, p_5to4_ETG];
        %% task clear:out deadline task
        [TASK4_bit_all_ETG, TASK4_reward_all_ETG, TASK4_deadline_all_ETG, TASK4_p_all_ETG, mumber4_ETG]  =  clear_task(TASK4_bit_all_ETG, TASK4_reward_all_ETG, TASK4_deadline_all_ETG, TASK4_p_all_ETG);
        Queue_F_ETG(4) = sum(TASK4_bit_all_ETG);
        TASK4_number_all_ETG = size(TASK4_bit_all_ETG, 2);
        %%back_queue
        Queue_4B_task_p_ETG = Queue_4B_task_ETG{1};
        Queue_4B_task_reward_ETG = Queue_4B_task_ETG{2};
        Queue_4B_task_deadline_ETG = Queue_4B_task_ETG{3};
        Queue_4B_task_bit_ETG = Queue_4B_task_ETG{4};
        Queue_4B_task_p_ETG = [Queue_4B_task_p_ETG, p_4to4_ETG];
        Queue_4B_task_reward_ETG = [Queue_4B_task_reward_ETG, reward_4to4_ETG];
        Queue_4B_task_deadline_ETG = [Queue_4B_task_deadline_ETG, deadline_4to4_ETG];
        Queue_4B_task_bit_ETG = [Queue_4B_task_bit_ETG, bit_4to4_ETG];
        Queue_B_ETG(4) = sum(Queue_4B_task_bit_ETG);
        Queue_4B_task_num_ETG = size(Queue_4B_task_bit_ETG, 2);
        num_add4_ETG = size(bit_4to4_ETG, 2);
        Queue_4B_task_time_ETG = [Queue_4B_task_time_ETG, zeros(1, num_add4_ETG)];
        %% ES5;
        %%front_queue
        TASK5_bit_all_ETG = [bit_5re_ETG, TASK5bit, bit_1to5_ETG, bit_2to5_ETG, bit_3to5_ETG, bit_4to5_ETG];
        TASK5_reward_all_ETG = [reward_5re_ETG, REWARD5, reward_1to5_ETG, reward_2to5_ETG, reward_3to5_ETG, reward_4to5_ETG];
        TASK5_deadline_all_ETG = [deadline_5re_ETG, TASK5deadline, deadline_1to5_ETG, deadline_2to5_ETG, deadline_3to5_ETG, deadline_4to5_ETG];
        TASK5_p_all_ETG = [p_5re_ETG, TASK5p, p_1to5_ETG, p_2to5_ETG, p_3to5_ETG, p_4to5_ETG];
        %% task clear:out deadline task
        [TASK5_bit_all_ETG, TASK5_reward_all_ETG, TASK5_deadline_all_ETG, TASK5_p_all_ETG, mumber5_ETG]  =  clear_task(TASK5_bit_all_ETG, TASK5_reward_all_ETG, TASK5_deadline_all_ETG, TASK5_p_all_ETG);
        Queue_F_ETG(5) = sum(TASK5_bit_all_ETG);
        TASK5_number_all_ETG = size(TASK5_bit_all_ETG, 2);
        %%back_queue
        Queue_5B_task_p_ETG = Queue_5B_task_ETG{1};
        Queue_5B_task_reward_ETG = Queue_5B_task_ETG{2};
        Queue_5B_task_deadline_ETG = Queue_5B_task_ETG{3};
        Queue_5B_task_bit_ETG = Queue_5B_task_ETG{4};
        Queue_5B_task_p_ETG = [Queue_5B_task_p_ETG, p_5to5_ETG];
        Queue_5B_task_reward_ETG = [Queue_5B_task_reward_ETG, reward_5to5_ETG];
        Queue_5B_task_deadline_ETG = [Queue_5B_task_deadline_ETG, deadline_5to5_ETG];
        Queue_5B_task_bit_ETG = [Queue_5B_task_bit_ETG, bit_5to5_ETG];
        Queue_B_ETG(5) = sum(Queue_5B_task_bit_ETG);
        Queue_5B_task_num_ETG = size(Queue_5B_task_bit_ETG, 2);
        num_add5_ETG = size(bit_5to5_ETG, 2);
        Queue_5B_task_time_ETG = [Queue_5B_task_time_ETG, zeros(1, num_add5_ETG)];
    end
    %% allow
    ALLOW0offload = [0, 5, 4, 6, 5, 5;
        5     0     3     4     0     3;
        4     3     0     6     5     5;
        6     4     6     0     5     6;
        5     0     5     5     0     6;
        4     5     5     6     4     0];
    ALLOW0computate = [6, 8, 7, 6, 8, 9];
    %% predict
    Queue_N_OSC = [Queue_1B_task_num_OSC, Queue_2B_task_num_OSC, Queue_3B_task_num_OSC, Queue_4B_task_num_OSC, Queue_5B_task_num_OSC];
    Btran_OSC1_all(cnt) = Btran_OSC(1);
    Btran_OSC2_all(cnt) = Btran_OSC(2);
    Btran_OSC3_all(cnt) = Btran_OSC(3);
    Btran_OSC4_all(cnt) = Btran_OSC(4);
    Btran_OSC5_all(cnt) = Btran_OSC(5);
    Queue_B_OSC1(cnt) = Queue_B_OSC(1);
    Queue_B_OSC2(cnt) = Queue_B_OSC(2);
    Queue_B_OSC3(cnt) = Queue_B_OSC(3);
    Queue_B_OSC4(cnt) = Queue_B_OSC(4);
    Queue_B_OSC5(cnt) = Queue_B_OSC(5);
    Queue_N_OSC1(cnt) = Queue_N_OSC(1);
    Queue_N_OSC2(cnt) = Queue_N_OSC(2);
    Queue_N_OSC3(cnt) = Queue_N_OSC(3);
    Queue_N_OSC4(cnt) = Queue_N_OSC(4);
    Queue_N_OSC5(cnt) = Queue_N_OSC(5);
    if cnt   <=  15
        Btran_OSC1_allp(cnt) = Btran_OSC(1);
        Btran_OSC2_allp(cnt) = Btran_OSC(2);
        Btran_OSC3_allp(cnt) = Btran_OSC(3);
        Btran_OSC4_allp(cnt) = Btran_OSC(4);
        Btran_OSC5_allp(cnt) = Btran_OSC(5);
        Queue_B_OSC1p(cnt) = Queue_B_OSC(1);
        Queue_B_OSC2p(cnt) = Queue_B_OSC(2);
        Queue_B_OSC3p(cnt) = Queue_B_OSC(3);
        Queue_B_OSC4p(cnt) = Queue_B_OSC(4);
        Queue_B_OSC5p(cnt) = Queue_B_OSC(5);
        Queue_N_OSC1p(cnt) = Queue_N_OSC(1);
        Queue_N_OSC2p(cnt) = Queue_N_OSC(2);
        Queue_N_OSC3p(cnt) = Queue_N_OSC(3);
        Queue_N_OSC4p(cnt) = Queue_N_OSC(4);
        Queue_N_OSC5p(cnt) = Queue_N_OSC(5);
        Btran_OSC1_allpp = Btran_OSC(1)  *  ones(1, 10);
        Btran_OSC2_allpp = Btran_OSC(2)  *  ones(1, 10);
        Btran_OSC3_allpp = Btran_OSC(3)  *  ones(1, 10);
        Btran_OSC4_allpp = Btran_OSC(4)  *  ones(1, 10);
        Btran_OSC5_allpp = Btran_OSC(5)  *  ones(1, 10);
        Btran_OSC_allpp = {Btran_OSC1_allpp, Btran_OSC2_allpp, Btran_OSC3_allpp, Btran_OSC4_allpp, Btran_OSC5_allpp};
        Queue_B_OSC1pp = Queue_B_OSC(1)  *  ones(1, 10);
        Queue_B_OSC2pp = Queue_B_OSC(2)  *  ones(1, 10);
        Queue_B_OSC3pp = Queue_B_OSC(3)  *  ones(1, 10);
        Queue_B_OSC4pp = Queue_B_OSC(4)  *  ones(1, 10);
        Queue_B_OSC5pp = Queue_B_OSC(5)  *  ones(1, 10);
        Queue_B_OSCpp = {Queue_B_OSC1pp, Queue_B_OSC2pp, Queue_B_OSC3pp, Queue_B_OSC4pp, Queue_B_OSC5pp};
        Queue_N_OSC1pp = Queue_N_OSC(1)  *  ones(1, 10);
        Queue_N_OSC2pp = Queue_N_OSC(2)  *  ones(1, 10);
        Queue_N_OSC3pp = Queue_N_OSC(3)  *  ones(1, 10);
        Queue_N_OSC4pp = Queue_N_OSC(4)  *  ones(1, 10);
        Queue_N_OSC5pp = Queue_N_OSC(5)  *  ones(1, 10);
        Queue_N_OSCpp = {Queue_N_OSC1pp, Queue_N_OSC2pp, Queue_N_OSC3pp, Queue_N_OSC4pp, Queue_N_OSC5pp};
    else
        Btran_OSC_all = {Btran_OSC1_all(1, cnt - 11:cnt), Btran_OSC2_all(1, cnt - 11:cnt), Btran_OSC3_all(1, cnt - 11:cnt), Btran_OSC4_all(1, cnt - 11:cnt), Btran_OSC5_all(1, cnt - 11:cnt)};
        Btran_OSC_allp = {Btran_OSC1_allp(1, cnt - 12:cnt - 1), Btran_OSC2_allp(1, cnt - 12:cnt - 1), Btran_OSC3_allp(1, cnt - 12:cnt - 1), Btran_OSC4_allp(1, cnt - 12:cnt - 1), Btran_OSC5_allp(1, cnt - 12:cnt - 1)};
        Queue_B_OSC_inf = {Queue_B_OSC1(1, cnt - 12:cnt - 1), Queue_B_OSC2(1, cnt - 12:cnt - 1), Queue_B_OSC3(1, cnt - 12:cnt - 1), Queue_B_OSC4(1, cnt - 12:cnt - 1), Queue_B_OSC5(1, cnt - 12:cnt - 1)};
        Queue_B_OSCp = {Queue_B_OSC1p(1, cnt - 12:cnt - 1), Queue_B_OSC2p(1, cnt - 12:cnt - 1), Queue_B_OSC3p(1, cnt - 12:cnt - 1), Queue_B_OSC4p(1, cnt - 12:cnt - 1), Queue_B_OSC5p(1, cnt - 12:cnt - 1)};
        Queue_N_OSC_inf = {Queue_N_OSC1(1, cnt - 12:cnt - 1), Queue_N_OSC2(1, cnt - 12:cnt - 1), Queue_N_OSC3(1, cnt - 12:cnt - 1), Queue_N_OSC4(1, cnt - 12:cnt - 1), Queue_N_OSC5(1, cnt - 12:cnt - 1)};
        Queue_N_OSCp = {Queue_N_OSC1p(1, cnt - 12:cnt - 1), Queue_N_OSC2p(1, cnt - 12:cnt - 1), Queue_N_OSC3p(1, cnt - 12:cnt - 1), Queue_N_OSC4p(1, cnt - 12:cnt - 1), Queue_N_OSC5p(1, cnt - 12:cnt - 1)};
        [Btran_OSC_allpp, Queue_B_OSCpp, Queue_N_OSCpp]  =  PRIDICT_TIME(Btran_OSC_all, Btran_OSC_allp, Queue_B_OSC_inf, Queue_B_OSCp, Queue_N_OSC_inf, Queue_N_OSCp);%12 data
        %add t + 1 predict
        Btran_OSC1_allp(cnt) = Btran_OSC_allpp{1}(1);
        Btran_OSC2_allp(cnt) = Btran_OSC_allpp{2}(1);
        Btran_OSC3_allp(cnt) = Btran_OSC_allpp{3}(1);
        Btran_OSC4_allp(cnt) = Btran_OSC_allpp{4}(1);
        Btran_OSC5_allp(cnt) = Btran_OSC_allpp{5}(1);
        Queue_B_OSC1p(cnt) = Queue_B_OSCpp{1}(1);
        Queue_B_OSC2p(cnt) = Queue_B_OSCpp{2}(1);
        Queue_B_OSC3p(cnt) = Queue_B_OSCpp{3}(1);
        Queue_B_OSC4p(cnt) = Queue_B_OSCpp{4}(1);
        Queue_B_OSC5p(cnt) = Queue_B_OSCpp{5}(1);
        Queue_N_OSC1p(cnt) = Queue_N_OSCpp{1}(1);
        Queue_N_OSC2p(cnt) = Queue_N_OSCpp{2}(1);
        Queue_N_OSC3p(cnt) = Queue_N_OSCpp{3}(1);
        Queue_N_OSC4p(cnt) = Queue_N_OSCpp{4}(1);
        Queue_N_OSC5p(cnt) = Queue_N_OSCpp{5}(1);
    end
    %% make offload decision:1 count MCMC cost&volume 2 MCMC complete
    targetES = 1;
    while targetES <= ES
        if targetES == 1
            %%OSC Algrim
            Queue_1F_inf_OSC = Queue_F_OSC(targetES);
            Queue_1B_inf_OSC = Queue_B_OSC(targetES);
            ALLOW1_computate_OSC = ALLOW0computate(targetES);
            ALLOW1_offload_OSC = ALLOW0offload(targetES, :);
            ALLOW1_offload_OSC(targetES) = ALLOW1_computate_OSC;
            TRAN_BIT1_OSC = TRAN_BIT(1, :);
            [t_task_es1] =  predict_task_t_time(k, slot, Eop, yz, MAXfrequency, Btran_OSC_allpp, Queue_B_OSCpp, Queue_N_OSCpp, TASK1_bit_all_OSC, TASK1_p_all_OSC, B_battery_OSC_ES_MIN, B_battery_OSC_ES_MAX);
            [cost_inf_OSC, volume_inf_OSC] = MO_way2(targetES, Queue_1F_inf_OSC, yz_F, Queue_1B_inf_OSC, TASK1_bit_all_OSC, TASK1_reward_all_OSC, TASK1_number_all_OSC, TASK1_deadline_all_OSC, U, V, price_clould, TRAN_BIT1_OSC, ALLOW1_offload_OSC, t_task_es1);
            [flow_front_1_OSC] = MCMC_origion(cost_inf_OSC, volume_inf_OSC);%front ES : MCMC flow get
            %% offload & compute queue
            flow_front_1_ES1_OSC = flow_front_1_OSC(:, 2 + TASK1_number_all_OSC);%ES1
            [bit_1to1_OSC, reward_1to1_OSC, deadline_1to1_OSC, p_1to1_OSC]  =  front_es(flow_front_1_ES1_OSC, TASK1_bit_all_OSC, TASK1_reward_all_OSC, TASK1_deadline_all_OSC,  TASK1_p_all_OSC, TASK1_number_all_OSC);
            
            flow_front_1_ES2_OSC = flow_front_1_OSC(:, 3 + TASK1_number_all_OSC);%ES1to2
            [bit_1to2_OSC, reward_1to2_OSC, deadline_1to2_OSC, p_1to2_OSC]  =  front_es(flow_front_1_ES2_OSC, TASK1_bit_all_OSC, TASK1_reward_all_OSC, TASK1_deadline_all_OSC,  TASK1_p_all_OSC, TASK1_number_all_OSC);
            
            flow_front_1_ES3_OSC = flow_front_1_OSC(:, 4 + TASK1_number_all_OSC);%ES1to3
            [bit_1to3_OSC, reward_1to3_OSC, deadline_1to3_OSC, p_1to3_OSC]  =  front_es(flow_front_1_ES3_OSC, TASK1_bit_all_OSC, TASK1_reward_all_OSC, TASK1_deadline_all_OSC,  TASK1_p_all_OSC, TASK1_number_all_OSC);
            
            flow_front_1_ES4_OSC = flow_front_1_OSC(:, 5 + TASK1_number_all_OSC);%ES1to4
            [bit_1to4_OSC, reward_1to4_OSC, deadline_1to4_OSC, p_1to4_OSC]  =  front_es(flow_front_1_ES4_OSC, TASK1_bit_all_OSC, TASK1_reward_all_OSC, TASK1_deadline_all_OSC,  TASK1_p_all_OSC, TASK1_number_all_OSC);
            
            flow_front_1_ES5_OSC = flow_front_1_OSC(:, 6 + TASK1_number_all_OSC);%ES1to5
            [bit_1to5_OSC, reward_1to5_OSC, deadline_1to5_OSC, p_1to5_OSC]  =  front_es(flow_front_1_ES5_OSC, TASK1_bit_all_OSC, TASK1_reward_all_OSC, TASK1_deadline_all_OSC,  TASK1_p_all_OSC, TASK1_number_all_OSC);
            
            flow_front_1_ES6_OSC = flow_front_1_OSC(:, 7 + TASK1_number_all_OSC);%ES1toclould
            [bit_1to6_OSC, reward_1to6_OSC, deadline_1to6_OSC, p_1to6_OSC]  =  front_es(flow_front_1_ES6_OSC, TASK1_bit_all_OSC, TASK1_reward_all_OSC, TASK1_deadline_all_OSC,  TASK1_p_all_OSC, TASK1_number_all_OSC);
            
            flow_front_re_ES1_OSC = (flow_front_1_OSC(1, 2:1 + TASK1_number_all_OSC))';%ES1:remain taska
            [bit_1re_OSC, reward_1re_OSC, deadline_1re_OSC, p_1re_OSC]  =   front_es_re(flow_front_re_ES1_OSC, TASK1_bit_all_OSC, TASK1_reward_all_OSC, TASK1_deadline_all_OSC,  TASK1_p_all_OSC, TASK1_number_all_OSC);
            deadline_1re_OSC = deadline_1re_OSC - slot;
            %%DTG
            ALLOW1_computate_DTG = ALLOW0computate(targetES);
            [bit_1re_DTG, reward_1re_DTG, deadline_1re_DTG, p_1re_DTG, bit_1to1_DTG, reward_1to1_DTG, deadline_1to1_DTG, p_1to1_DTG]  =  loc2(ALLOW1_computate_DTG, TASK1_bit_all_DTG, TASK1_reward_all_DTG, TASK1_deadline_all_DTG,  TASK1_p_all_DTG);
            bit_1to2_DTG = [];reward_1to2_DTG = [];deadline_1to2_DTG = [];p_1to2_DTG = [];
            bit_1to3_DTG = [];reward_1to3_DTG = [];deadline_1to3_DTG = [];p_1to3_DTG = [];
            bit_1to4_DTG = [];reward_1to4_DTG = [];deadline_1to4_DTG = [];p_1to4_DTG = [];
            bit_1to5_DTG = [];reward_1to5_DTG = [];deadline_1to5_DTG = [];p_1to5_DTG = [];
            bit_1to6_DTG = [];reward_1to6_DTG = [];deadline_1to6_DTG = [];p_1to6_DTG = [];
            deadline_1re_DTG = deadline_1re_DTG - slot;
            %%clould
            ALLOW1_computate_CTG = ALLOW0computate(targetES);
            ALLOW1_offload_CTG = ALLOW0offload(targetES, 6);
            TRAN_BIT1_OSC_clould = TRAN_BIT1_OSC(6);
            [task_1to6_CTG, task_1to1_CTG, task_1re_CTG]  =  clould2(ALLOW1_computate_CTG, ALLOW1_offload_CTG, TASK1_bit_all_CTG, TASK1_reward_all_CTG, TASK1_deadline_all_CTG,  TASK1_p_all_CTG, TRAN_BIT1_OSC_clould);
            bit_1to6_CTG = task_1to6_CTG{1};reward_1to6_CTG = task_1to6_CTG{2};deadline_1to6_CTG = task_1to6_CTG{3};p_1to6_CTG = task_1to6_CTG{4};
            bit_1to1_CTG = task_1to1_CTG{1};reward_1to1_CTG = task_1to1_CTG{2};deadline_1to1_CTG = task_1to1_CTG{3};p_1to1_CTG = task_1to1_CTG{4};
            bit_1re_CTG = task_1re_CTG{1};reward_1re_CTG = task_1re_CTG{2};deadline_1re_CTG = task_1re_CTG{3};p_1re_CTG = task_1re_CTG{4};
            bit_1to2_CTG = [];reward_1to2_CTG = [];deadline_1to2_CTG = [];p_1to2_CTG = [];
            bit_1to3_CTG = [];reward_1to3_CTG = [];deadline_1to3_CTG = [];p_1to3_CTG = [];
            bit_1to4_CTG = [];reward_1to4_CTG = [];deadline_1to4_CTG = [];p_1to4_CTG = [];
            bit_1to5_CTG = [];reward_1to5_CTG = [];deadline_1to5_CTG = [];p_1to5_CTG = [];
            deadline_1re_CTG = deadline_1re_CTG - slot;
            %%lo_offload
            ALLOW1_offload_ETG = ALLOW1_offload_OSC;
            ALLOW1_computate_ETG = ALLOW0computate(targetES);
            ALLOW1_offload_ETG(targetES) = ALLOW1_computate_ETG;
            [cost_inf_ETG, volume_inf_ETG]  =  local_offload2(ALLOW1_offload_ETG, targetES, TASK1_number_all_ETG, TASK1_reward_all_ETG);
            [flow_front_1_ETG] = MCMC_origion(cost_inf_ETG, volume_inf_ETG);%front ES : MCMC flow get
            %% offload & compute queue
            flow_front_1_ES1_ETG = flow_front_1_ETG(:, 2 + TASK1_number_all_ETG);%ES1
            [bit_1to1_ETG, reward_1to1_ETG, deadline_1to1_ETG, p_1to1_ETG]  =  front_es(flow_front_1_ES1_ETG, TASK1_bit_all_ETG, TASK1_reward_all_ETG, TASK1_deadline_all_ETG,  TASK1_p_all_ETG, TASK1_number_all_ETG);
            
            flow_front_1_ES2_ETG = flow_front_1_ETG(:, 3 + TASK1_number_all_ETG);%ES1to2
            [bit_1to2_ETG, reward_1to2_ETG, deadline_1to2_ETG, p_1to2_ETG]  =  front_es(flow_front_1_ES2_ETG, TASK1_bit_all_ETG, TASK1_reward_all_ETG, TASK1_deadline_all_ETG,  TASK1_p_all_ETG, TASK1_number_all_ETG);
            
            flow_front_1_ES3_ETG = flow_front_1_ETG(:, 4 + TASK1_number_all_ETG);%ES1to3
            [bit_1to3_ETG, reward_1to3_ETG, deadline_1to3_ETG, p_1to3_ETG]  =  front_es(flow_front_1_ES3_ETG, TASK1_bit_all_ETG, TASK1_reward_all_ETG, TASK1_deadline_all_ETG,  TASK1_p_all_ETG, TASK1_number_all_ETG);
            
            flow_front_1_ES4_ETG = flow_front_1_ETG(:, 5 + TASK1_number_all_ETG);%ES1to4
            [bit_1to4_ETG, reward_1to4_ETG, deadline_1to4_ETG, p_1to4_ETG]  =  front_es(flow_front_1_ES4_ETG, TASK1_bit_all_ETG, TASK1_reward_all_ETG, TASK1_deadline_all_ETG,  TASK1_p_all_ETG, TASK1_number_all_ETG);
            
            flow_front_1_ES5_ETG = flow_front_1_ETG(:, 6 + TASK1_number_all_ETG);%ES1to5
            [bit_1to5_ETG, reward_1to5_ETG, deadline_1to5_ETG, p_1to5_ETG]  =  front_es(flow_front_1_ES5_ETG, TASK1_bit_all_ETG, TASK1_reward_all_ETG, TASK1_deadline_all_ETG,  TASK1_p_all_ETG, TASK1_number_all_ETG);
            
            flow_front_1_ES6_ETG = flow_front_1_ETG(:, 7 + TASK1_number_all_ETG);%ES1toclould
            [bit_1to6_ETG, reward_1to6_ETG, deadline_1to6_ETG, p_1to6_ETG]  =  front_es(flow_front_1_ES6_ETG, TASK1_bit_all_ETG, TASK1_reward_all_ETG, TASK1_deadline_all_ETG,  TASK1_p_all_ETG, TASK1_number_all_ETG);
            
            flow_front_re_ES1_ETG = (flow_front_1_ETG(1, 2:1 + TASK1_number_all_ETG))';%ES1:remain taska
            [bit_1re_ETG, reward_1re_ETG, deadline_1re_ETG, p_1re_ETG]  =   front_es_re(flow_front_re_ES1_ETG, TASK1_bit_all_ETG, TASK1_reward_all_ETG, TASK1_deadline_all_ETG,  TASK1_p_all_ETG, TASK1_number_all_ETG);
            deadline_1re_ETG = deadline_1re_ETG - slot;
        end
        if targetES == 2
            Queue_2F_inf_OSC = Queue_F_OSC(targetES);
            Queue_2B_inf_OSC = Queue_B_OSC(targetES);
            ALLOW2_computate_OSC = ALLOW0computate(targetES);
            ALLOW2_offload_OSC = ALLOW0offload(targetES, :);
            ALLOW2_offload_OSC(targetES) = ALLOW2_computate_OSC;
            TRAN_BIT2_OSC = TRAN_BIT(2, :);
            [t_task_es2]  =  predict_task_t_time(k, slot, Eop, yz, MAXfrequency, Btran_OSC_allpp, Queue_B_OSCpp, Queue_N_OSCpp, TASK2_bit_all_OSC, TASK2_p_all_OSC, B_battery_OSC_ES_MIN, B_battery_OSC_ES_MAX);
            [cost_inf_OSC, volume_inf_OSC] = MO_way2(targetES, Queue_2F_inf_OSC, yz_F, Queue_2B_inf_OSC, TASK2_bit_all_OSC, TASK2_reward_all_OSC, TASK2_number_all_OSC, TASK2_deadline_all_OSC, U, V, price_clould, TRAN_BIT2_OSC, ALLOW2_offload_OSC, t_task_es2);
            [flow_front_2_OSC] = MCMC_origion(cost_inf_OSC, volume_inf_OSC);%front ES : MCMC flow get
            %% offload & compute queue
            flow_front_2_ES1_OSC = flow_front_2_OSC(:, 2 + TASK2_number_all_OSC);%ES2to1
            [bit_2to1_OSC, reward_2to1_OSC, deadline_2to1_OSC, p_2to1_OSC]  =  front_es(flow_front_2_ES1_OSC, TASK2_bit_all_OSC, TASK2_reward_all_OSC, TASK2_deadline_all_OSC,  TASK2_p_all_OSC, TASK2_number_all_OSC);
            
            flow_front_2_ES2_OSC = flow_front_2_OSC(:, 3 + TASK2_number_all_OSC);%ES2to2
            [bit_2to2_OSC, reward_2to2_OSC, deadline_2to2_OSC, p_2to2_OSC]  =  front_es(flow_front_2_ES2_OSC, TASK2_bit_all_OSC, TASK2_reward_all_OSC, TASK2_deadline_all_OSC,  TASK2_p_all_OSC, TASK2_number_all_OSC);
            
            flow_front_2_ES3_OSC = flow_front_2_OSC(:, 4 + TASK2_number_all_OSC);%ES2to3
            [bit_2to3_OSC, reward_2to3_OSC, deadline_2to3_OSC, p_2to3_OSC]  =  front_es(flow_front_2_ES3_OSC, TASK2_bit_all_OSC, TASK2_reward_all_OSC, TASK2_deadline_all_OSC,  TASK2_p_all_OSC, TASK2_number_all_OSC);
            
            flow_front_2_ES4_OSC = flow_front_2_OSC(:, 5 + TASK2_number_all_OSC);%ES2to4
            [bit_2to4_OSC, reward_2to4_OSC, deadline_2to4_OSC, p_2to4_OSC]  =  front_es(flow_front_2_ES4_OSC, TASK2_bit_all_OSC, TASK2_reward_all_OSC, TASK2_deadline_all_OSC,  TASK2_p_all_OSC, TASK2_number_all_OSC);
            
            flow_front_2_ES5_OSC = flow_front_2_OSC(:, 6 + TASK2_number_all_OSC);%ES2to5
            [bit_2to5_OSC, reward_2to5_OSC, deadline_2to5_OSC, p_2to5_OSC]  =  front_es(flow_front_2_ES5_OSC, TASK2_bit_all_OSC, TASK2_reward_all_OSC, TASK2_deadline_all_OSC,  TASK2_p_all_OSC, TASK2_number_all_OSC);
            
            flow_front_2_ES6_OSC = flow_front_2_OSC(:, 7 + TASK2_number_all_OSC);%ES2to6
            [bit_2to6_OSC, reward_2to6_OSC, deadline_2to6_OSC, p_2to6_OSC]  =  front_es(flow_front_2_ES6_OSC, TASK2_bit_all_OSC, TASK2_reward_all_OSC, TASK2_deadline_all_OSC,  TASK2_p_all_OSC, TASK2_number_all_OSC);
            
            flow_front_re_ES2_OSC = (flow_front_2_OSC(1, 2:1 + TASK2_number_all_OSC))';%ES1:remain taska
            [bit_2re_OSC, reward_2re_OSC, deadline_2re_OSC, p_2re_OSC]  =   front_es_re(flow_front_re_ES2_OSC, TASK2_bit_all_OSC, TASK2_reward_all_OSC, TASK2_deadline_all_OSC,  TASK2_p_all_OSC, TASK2_number_all_OSC);
            deadline_2re_OSC = deadline_2re_OSC - slot;
            
            %%DTG
            
            ALLOW2_computate_DTG = ALLOW0computate(targetES);
            [bit_2re_DTG, reward_2re_DTG, deadline_2re_DTG, p_2re_DTG, bit_2to2_DTG, reward_2to2_DTG, deadline_2to2_DTG, p_2to2_DTG]  =  loc2(ALLOW2_computate_DTG, TASK2_bit_all_DTG, TASK2_reward_all_DTG, TASK2_deadline_all_DTG,  TASK2_p_all_DTG);
            bit_2to1_DTG = [];reward_2to1_DTG = [];deadline_2to1_DTG = [];p_2to1_DTG = [];
            bit_2to3_DTG = [];reward_2to3_DTG = [];deadline_2to3_DTG = [];p_2to3_DTG = [];
            bit_2to4_DTG = [];reward_2to4_DTG = [];deadline_2to4_DTG = [];p_2to4_DTG = [];
            bit_2to5_DTG = [];reward_2to5_DTG = [];deadline_2to5_DTG = [];p_2to5_DTG = [];
            bit_2to6_DTG = [];reward_2to6_DTG = [];deadline_2to6_DTG = [];p_2to6_DTG = [];
            deadline_2re_DTG = deadline_2re_DTG - slot;
            %%clould
            ALLOW2_computate_CTG = ALLOW0computate(targetES);
            ALLOW2_offload_CTG = ALLOW0offload(targetES, 6);
            TRAN_BIT2_OSC_clould = TRAN_BIT2_OSC(6);
            [task_2to6_CTG, task_2to2_CTG, task_2re_CTG]  =  clould2(ALLOW2_computate_CTG, ALLOW2_offload_CTG, TASK2_bit_all_CTG, TASK2_reward_all_CTG, TASK2_deadline_all_CTG,  TASK2_p_all_CTG, TRAN_BIT2_OSC_clould);
            bit_2to6_CTG = task_2to6_CTG{1};reward_2to6_CTG = task_2to6_CTG{2};deadline_2to6_CTG = task_2to6_CTG{3};p_2to6_CTG = task_2to6_CTG{4};
            bit_2to2_CTG = task_2to2_CTG{1};reward_2to2_CTG = task_2to2_CTG{2};deadline_2to2_CTG = task_2to2_CTG{3};p_2to2_CTG = task_2to2_CTG{4};
            bit_2re_CTG = task_2re_CTG{1};reward_2re_CTG = task_2re_CTG{2};deadline_2re_CTG = task_2re_CTG{3};p_2re_CTG = task_2re_CTG{4};
            bit_2to1_CTG = [];reward_2to1_CTG = [];deadline_2to1_CTG = [];p_2to1_CTG = [];
            bit_2to3_CTG = [];reward_2to3_CTG = [];deadline_2to3_CTG = [];p_2to3_CTG = [];
            bit_2to4_CTG = [];reward_2to4_CTG = [];deadline_2to4_CTG = [];p_2to4_CTG = [];
            bit_2to5_CTG = [];reward_2to5_CTG = [];deadline_2to5_CTG = [];p_2to5_CTG = [];
            deadline_2re_CTG = deadline_2re_CTG - slot;
            %%lo_offload
            ALLOW2_offload_ETG = ALLOW2_offload_OSC;
            if Queue_2B_task_num_ETG <= 3  *  ALLOW0computate(targetES)
                ALLOW2_computate_ETG = ALLOW0computate(targetES);
            else
                if Queue_2B_task_num_ETG <= 4  *  ALLOW0computate(targetES)
                    ALLOW2_computate_ETG = 7  *  ALLOW0computate(targetES) - Queue_2B_task_num_ETG;
                else
                    ALLOW2_computate_ETG = 0;
                end
            end
            ALLOW2_offload_ETG(targetES) = ALLOW2_computate_ETG;
            [cost_inf_ETG, volume_inf_ETG]  =  local_offload2(ALLOW2_offload_ETG, targetES, TASK2_number_all_ETG, TASK2_reward_all_ETG);
            [flow_front_2_ETG] = MCMC_origion(cost_inf_ETG, volume_inf_ETG);%front ES : MCMC flow get
            %% offload & compute queue
            flow_front_2_ES1_ETG = flow_front_2_ETG(:, 2 + TASK2_number_all_ETG);%ES2to1
            [bit_2to1_ETG, reward_2to1_ETG, deadline_2to1_ETG, p_2to1_ETG]  =  front_es(flow_front_2_ES1_ETG, TASK2_bit_all_ETG, TASK2_reward_all_ETG, TASK2_deadline_all_ETG,  TASK2_p_all_ETG, TASK2_number_all_ETG);
            
            flow_front_2_ES2_ETG = flow_front_2_ETG(:, 3 + TASK2_number_all_ETG);%ES2to2
            [bit_2to2_ETG, reward_2to2_ETG, deadline_2to2_ETG, p_2to2_ETG]  =  front_es(flow_front_2_ES2_ETG, TASK2_bit_all_ETG, TASK2_reward_all_ETG, TASK2_deadline_all_ETG,  TASK2_p_all_ETG, TASK2_number_all_ETG);
            
            flow_front_2_ES3_ETG = flow_front_2_ETG(:, 4 + TASK2_number_all_ETG);%ES2to3
            [bit_2to3_ETG, reward_2to3_ETG, deadline_2to3_ETG, p_2to3_ETG]  =  front_es(flow_front_2_ES3_ETG, TASK2_bit_all_ETG, TASK2_reward_all_ETG, TASK2_deadline_all_ETG,  TASK2_p_all_ETG, TASK2_number_all_ETG);
            
            flow_front_2_ES4_ETG = flow_front_2_ETG(:, 5 + TASK2_number_all_ETG);%ES2to4
            [bit_2to4_ETG, reward_2to4_ETG, deadline_2to4_ETG, p_2to4_ETG]  =  front_es(flow_front_2_ES4_ETG, TASK2_bit_all_ETG, TASK2_reward_all_ETG, TASK2_deadline_all_ETG,  TASK2_p_all_ETG, TASK2_number_all_ETG);
            
            flow_front_2_ES5_ETG = flow_front_2_ETG(:, 6 + TASK2_number_all_ETG);%ES2to5
            [bit_2to5_ETG, reward_2to5_ETG, deadline_2to5_ETG, p_2to5_ETG]  =  front_es(flow_front_2_ES5_ETG, TASK2_bit_all_ETG, TASK2_reward_all_ETG, TASK2_deadline_all_ETG,  TASK2_p_all_ETG, TASK2_number_all_ETG);
            
            flow_front_2_ES6_ETG = flow_front_2_ETG(:, 7 + TASK2_number_all_ETG);%ES2to6
            [bit_2to6_ETG, reward_2to6_ETG, deadline_2to6_ETG, p_2to6_ETG]  =  front_es(flow_front_2_ES6_ETG, TASK2_bit_all_ETG, TASK2_reward_all_ETG, TASK2_deadline_all_ETG,  TASK2_p_all_ETG, TASK2_number_all_ETG);
            
            flow_front_re_ES2_ETG = (flow_front_2_ETG(1, 2:1 + TASK2_number_all_ETG))';%ES1:remain taska
            [bit_2re_ETG, reward_2re_ETG, deadline_2re_ETG, p_2re_ETG]  =   front_es_re(flow_front_re_ES2_ETG, TASK2_bit_all_ETG, TASK2_reward_all_ETG, TASK2_deadline_all_ETG,  TASK2_p_all_ETG, TASK2_number_all_ETG);
            deadline_2re_ETG = deadline_2re_ETG - slot;
        end
        if targetES == 3
            Queue_3F_inf_OSC = Queue_F_OSC(targetES);
            Queue_3B_inf_OSC = Queue_B_OSC(targetES);
            ALLOW3_computate_OSC = ALLOW0computate(targetES);
            ALLOW3_offload_OSC = ALLOW0offload(targetES, :);
            ALLOW3_offload_OSC(targetES) = ALLOW3_computate_OSC;
            TRAN_BIT3_OSC = TRAN_BIT(3, :);
            [t_task_es3]  =  predict_task_t_time(k, slot, Eop, yz, MAXfrequency, Btran_OSC_allpp, Queue_B_OSCpp, Queue_N_OSCpp, TASK3_bit_all_OSC, TASK3_p_all_OSC, B_battery_OSC_ES_MIN, B_battery_OSC_ES_MAX);
            [cost_inf_OSC, volume_inf_OSC] = MO_way2(targetES, Queue_3F_inf_OSC, yz_F, Queue_3B_inf_OSC, TASK3_bit_all_OSC, TASK3_reward_all_OSC, TASK3_number_all_OSC, TASK3_deadline_all_OSC, U, V, price_clould, TRAN_BIT3_OSC, ALLOW3_offload_OSC, t_task_es3);
            [flow_front_3_OSC] = MCMC_origion(cost_inf_OSC, volume_inf_OSC);%front ES : MCMC flow get
            %% offload & compute queue
            flow_front_3_ES1_OSC = flow_front_3_OSC(:, 2 + TASK3_number_all_OSC);%ES3to1
            [bit_3to1_OSC, reward_3to1_OSC, deadline_3to1_OSC, p_3to1_OSC]  =  front_es(flow_front_3_ES1_OSC, TASK3_bit_all_OSC, TASK3_reward_all_OSC, TASK3_deadline_all_OSC,  TASK3_p_all_OSC, TASK3_number_all_OSC);
            
            flow_front_3_ES2_OSC = flow_front_3_OSC(:, 3 + TASK3_number_all_OSC);%ES3to2
            [bit_3to2_OSC, reward_3to2_OSC, deadline_3to2_OSC, p_3to2_OSC]  =  front_es(flow_front_3_ES2_OSC, TASK3_bit_all_OSC, TASK3_reward_all_OSC, TASK3_deadline_all_OSC,  TASK3_p_all_OSC, TASK3_number_all_OSC);
            
            flow_front_3_ES3_OSC = flow_front_3_OSC(:, 4 + TASK3_number_all_OSC);%ES3to3
            [bit_3to3_OSC, reward_3to3_OSC, deadline_3to3_OSC, p_3to3_OSC]  =  front_es(flow_front_3_ES3_OSC, TASK3_bit_all_OSC, TASK3_reward_all_OSC, TASK3_deadline_all_OSC,  TASK3_p_all_OSC, TASK3_number_all_OSC);
            
            flow_front_3_ES4_OSC = flow_front_3_OSC(:, 5 + TASK3_number_all_OSC);%ES3to4
            [bit_3to4_OSC, reward_3to4_OSC, deadline_3to4_OSC, p_3to4_OSC]  =  front_es(flow_front_3_ES4_OSC, TASK3_bit_all_OSC, TASK3_reward_all_OSC, TASK3_deadline_all_OSC,  TASK3_p_all_OSC, TASK3_number_all_OSC);
            
            flow_front_3_ES5_OSC = flow_front_3_OSC(:, 6 + TASK3_number_all_OSC);%ES3to5
            [bit_3to5_OSC, reward_3to5_OSC, deadline_3to5_OSC, p_3to5_OSC]  =  front_es(flow_front_3_ES5_OSC, TASK3_bit_all_OSC, TASK3_reward_all_OSC, TASK3_deadline_all_OSC,  TASK3_p_all_OSC, TASK3_number_all_OSC);
            
            flow_front_3_ES6_OSC = flow_front_3_OSC(:, 7 + TASK3_number_all_OSC);%ES3to6
            [bit_3to6_OSC, reward_3to6_OSC, deadline_3to6_OSC, p_3to6_OSC]  =  front_es(flow_front_3_ES6_OSC, TASK3_bit_all_OSC, TASK3_reward_all_OSC, TASK3_deadline_all_OSC,  TASK3_p_all_OSC, TASK3_number_all_OSC);
            
            flow_front_re_ES3_OSC = (flow_front_3_OSC(1, 2:1 + TASK3_number_all_OSC))';%ES1:remain taska
            [bit_3re_OSC, reward_3re_OSC, deadline_3re_OSC, p_3re_OSC]  =   front_es_re(flow_front_re_ES3_OSC, TASK3_bit_all_OSC, TASK3_reward_all_OSC, TASK3_deadline_all_OSC,  TASK3_p_all_OSC, TASK3_number_all_OSC);
            deadline_3re_OSC = deadline_3re_OSC - slot;
            %%DTG
            
            ALLOW3_computate_DTG = ALLOW0computate(targetES);
            [bit_3re_DTG, reward_3re_DTG, deadline_3re_DTG, p_3re_DTG, bit_3to3_DTG, reward_3to3_DTG, deadline_3to3_DTG, p_3to3_DTG]  =  loc2(ALLOW3_computate_DTG, TASK3_bit_all_DTG, TASK3_reward_all_DTG, TASK3_deadline_all_DTG,  TASK3_p_all_DTG);
            bit_3to2_DTG = [];reward_3to2_DTG = [];deadline_3to2_DTG = [];p_3to2_DTG = [];
            bit_3to1_DTG = [];reward_3to1_DTG = [];deadline_3to1_DTG = [];p_3to1_DTG = [];
            bit_3to4_DTG = [];reward_3to4_DTG = [];deadline_3to4_DTG = [];p_3to4_DTG = [];
            bit_3to5_DTG = [];reward_3to5_DTG = [];deadline_3to5_DTG = [];p_3to5_DTG = [];
            bit_3to6_DTG = [];reward_3to6_DTG = [];deadline_3to6_DTG = [];p_3to6_DTG = [];
            deadline_3re_DTG = deadline_3re_DTG - slot;
            %%clould
            ALLOW3_computate_CTG = ALLOW0computate(targetES);
            ALLOW3_offload_CTG = ALLOW0offload(targetES, 6);
            TRAN_BIT3_OSC_clould = TRAN_BIT3_OSC(6);
            [task_3to6_CTG, task_3to3_CTG, task_3re_CTG]  =  clould2(ALLOW3_computate_CTG, ALLOW3_offload_CTG, TASK3_bit_all_CTG, TASK3_reward_all_CTG, TASK3_deadline_all_CTG,  TASK3_p_all_CTG, TRAN_BIT3_OSC_clould);
            bit_3to6_CTG = task_3to6_CTG{1};reward_3to6_CTG = task_3to6_CTG{2};deadline_3to6_CTG = task_3to6_CTG{3};p_3to6_CTG = task_3to6_CTG{4};
            bit_3to3_CTG = task_3to3_CTG{1};reward_3to3_CTG = task_3to3_CTG{2};deadline_3to3_CTG = task_3to3_CTG{3};p_3to3_CTG = task_3to3_CTG{4};
            bit_3re_CTG = task_3re_CTG{1};reward_3re_CTG = task_3re_CTG{2};deadline_3re_CTG = task_3re_CTG{3};p_3re_CTG = task_3re_CTG{4};
            bit_3to2_CTG = [];reward_3to2_CTG = [];deadline_3to2_CTG = [];p_3to2_CTG = [];
            bit_3to1_CTG = [];reward_3to1_CTG = [];deadline_3to1_CTG = [];p_3to1_CTG = [];
            bit_3to4_CTG = [];reward_3to4_CTG = [];deadline_3to4_CTG = [];p_3to4_CTG = [];
            bit_3to5_CTG = [];reward_3to5_CTG = [];deadline_3to5_CTG = [];p_3to5_CTG = [];
            deadline_3re_CTG = deadline_3re_CTG - slot;
            %%lo_offload
            ALLOW3_offload_ETG = ALLOW3_offload_OSC;
            if Queue_3B_task_num_ETG   <=  3  *  ALLOW0computate(targetES)
                ALLOW3_computate_ETG = ALLOW0computate(targetES);
            else
                if Queue_3B_task_num_ETG   <=  4  *  ALLOW0computate(targetES)
                    ALLOW3_computate_ETG = 7  *  ALLOW0computate(targetES) - Queue_3B_task_num_ETG;
                else
                    ALLOW3_computate_ETG = 0;
                end
            end
            ALLOW3_offload_ETG(targetES) = ALLOW3_computate_ETG;
            [cost_inf_ETG, volume_inf_ETG]  =  local_offload2(ALLOW3_offload_ETG, targetES, TASK3_number_all_ETG, TASK3_reward_all_ETG);
            [flow_front_3_ETG] = MCMC_origion(cost_inf_ETG, volume_inf_ETG);%front ES : MCMC flow get
            %% offload & compute queue
            flow_front_3_ES1_ETG = flow_front_3_ETG(:, 2 + TASK3_number_all_ETG);%ES3to1
            [bit_3to1_ETG, reward_3to1_ETG, deadline_3to1_ETG, p_3to1_ETG]  =  front_es(flow_front_3_ES1_ETG, TASK3_bit_all_ETG, TASK3_reward_all_ETG, TASK3_deadline_all_ETG,  TASK3_p_all_ETG, TASK3_number_all_ETG);
            
            flow_front_3_ES2_ETG = flow_front_3_ETG(:, 3 + TASK3_number_all_ETG);%ES3to2
            [bit_3to2_ETG, reward_3to2_ETG, deadline_3to2_ETG, p_3to2_ETG]  =  front_es(flow_front_3_ES2_ETG, TASK3_bit_all_ETG, TASK3_reward_all_ETG, TASK3_deadline_all_ETG,  TASK3_p_all_ETG, TASK3_number_all_ETG);
            
            flow_front_3_ES3_ETG = flow_front_3_ETG(:, 4 + TASK3_number_all_ETG);%ES3to3
            [bit_3to3_ETG, reward_3to3_ETG, deadline_3to3_ETG, p_3to3_ETG]  =  front_es(flow_front_3_ES3_ETG, TASK3_bit_all_ETG, TASK3_reward_all_ETG, TASK3_deadline_all_ETG,  TASK3_p_all_ETG, TASK3_number_all_ETG);
            
            flow_front_3_ES4_ETG = flow_front_3_ETG(:, 5 + TASK3_number_all_ETG);%ES3to4
            [bit_3to4_ETG, reward_3to4_ETG, deadline_3to4_ETG, p_3to4_ETG]  =  front_es(flow_front_3_ES4_ETG, TASK3_bit_all_ETG, TASK3_reward_all_ETG, TASK3_deadline_all_ETG,  TASK3_p_all_ETG, TASK3_number_all_ETG);
            
            flow_front_3_ES5_ETG = flow_front_3_ETG(:, 6 + TASK3_number_all_ETG);%ES3to5
            [bit_3to5_ETG, reward_3to5_ETG, deadline_3to5_ETG, p_3to5_ETG]  =  front_es(flow_front_3_ES5_ETG, TASK3_bit_all_ETG, TASK3_reward_all_ETG, TASK3_deadline_all_ETG,  TASK3_p_all_ETG, TASK3_number_all_ETG);
            
            flow_front_3_ES6_ETG = flow_front_3_ETG(:, 7 + TASK3_number_all_ETG);%ES3to6
            [bit_3to6_ETG, reward_3to6_ETG, deadline_3to6_ETG, p_3to6_ETG]  =  front_es(flow_front_3_ES6_ETG, TASK3_bit_all_ETG, TASK3_reward_all_ETG, TASK3_deadline_all_ETG,  TASK3_p_all_ETG, TASK3_number_all_ETG);
            
            flow_front_re_ES3_ETG = (flow_front_3_ETG(1, 2:1 + TASK3_number_all_ETG))';%ES1:remain taska
            [bit_3re_ETG, reward_3re_ETG, deadline_3re_ETG, p_3re_ETG]  =   front_es_re(flow_front_re_ES3_ETG, TASK3_bit_all_ETG, TASK3_reward_all_ETG, TASK3_deadline_all_ETG,  TASK3_p_all_ETG, TASK3_number_all_ETG);
            deadline_3re_ETG = deadline_3re_ETG - slot;
        end
        if targetES == 4
            Queue_4F_inf_OSC = Queue_F_OSC(targetES);
            Queue_4B_inf_OSC = Queue_B_OSC(targetES);
            ALLOW4_computate_OSC = ALLOW0computate(targetES);
            ALLOW4_offload_OSC = ALLOW0offload(targetES, :);
            ALLOW4_offload_OSC(targetES) = ALLOW4_computate_OSC;
            TRAN_BIT4_OSC = TRAN_BIT(4, :);
            [t_task_es4]  =  predict_task_t_time(k, slot, Eop, yz, MAXfrequency, Btran_OSC_allpp, Queue_B_OSCpp, Queue_N_OSCpp, TASK4_bit_all_OSC, TASK4_p_all_OSC, B_battery_OSC_ES_MIN, B_battery_OSC_ES_MAX);
            [cost_inf_OSC, volume_inf_OSC] = MO_way2(targetES, Queue_4F_inf_OSC, yz_F, Queue_4B_inf_OSC, TASK4_bit_all_OSC, TASK4_reward_all_OSC, TASK4_number_all_OSC, TASK4_deadline_all_OSC, U, V, price_clould, TRAN_BIT4_OSC, ALLOW4_offload_OSC, t_task_es4);
            [flow_front_4_OSC] = MCMC_origion(cost_inf_OSC, volume_inf_OSC);%front ES : MCMC flow get
            %% offload & compute queue
            flow_front_4_ES1_OSC = flow_front_4_OSC(:, 2 + TASK4_number_all_OSC);%ES4
            [bit_4to1_OSC, reward_4to1_OSC, deadline_4to1_OSC, p_4to1_OSC]  =  front_es(flow_front_4_ES1_OSC, TASK4_bit_all_OSC, TASK4_reward_all_OSC, TASK4_deadline_all_OSC,  TASK4_p_all_OSC, TASK4_number_all_OSC);
            
            flow_front_4_ES2_OSC = flow_front_4_OSC(:, 3 + TASK4_number_all_OSC);%ES4to2
            [bit_4to2_OSC, reward_4to2_OSC, deadline_4to2_OSC, p_4to2_OSC]  =  front_es(flow_front_4_ES2_OSC, TASK4_bit_all_OSC, TASK4_reward_all_OSC, TASK4_deadline_all_OSC,  TASK4_p_all_OSC, TASK4_number_all_OSC);
            
            flow_front_4_ES3_OSC = flow_front_4_OSC(:, 4 + TASK4_number_all_OSC);%ES4to3
            [bit_4to3_OSC, reward_4to3_OSC, deadline_4to3_OSC, p_4to3_OSC]  =  front_es(flow_front_4_ES3_OSC, TASK4_bit_all_OSC, TASK4_reward_all_OSC, TASK4_deadline_all_OSC,  TASK4_p_all_OSC, TASK4_number_all_OSC);
            
            flow_front_4_ES4_OSC = flow_front_4_OSC(:, 5 + TASK4_number_all_OSC);%ES4to4
            [bit_4to4_OSC, reward_4to4_OSC, deadline_4to4_OSC, p_4to4_OSC]  =  front_es(flow_front_4_ES4_OSC, TASK4_bit_all_OSC, TASK4_reward_all_OSC, TASK4_deadline_all_OSC,  TASK4_p_all_OSC, TASK4_number_all_OSC);
            
            flow_front_4_ES5_OSC = flow_front_4_OSC(:, 6 + TASK4_number_all_OSC);%ES4to5
            [bit_4to5_OSC, reward_4to5_OSC, deadline_4to5_OSC, p_4to5_OSC]  =  front_es(flow_front_4_ES5_OSC, TASK4_bit_all_OSC, TASK4_reward_all_OSC, TASK4_deadline_all_OSC,  TASK4_p_all_OSC, TASK4_number_all_OSC);
            
            flow_front_4_ES6_OSC = flow_front_4_OSC(:, 7 + TASK4_number_all_OSC);%ES4to6
            [bit_4to6_OSC, reward_4to6_OSC, deadline_4to6_OSC, p_4to6_OSC]  =  front_es(flow_front_4_ES6_OSC, TASK4_bit_all_OSC, TASK4_reward_all_OSC, TASK4_deadline_all_OSC,  TASK4_p_all_OSC, TASK4_number_all_OSC);
            
            flow_front_re_ES4_OSC = (flow_front_4_OSC(1, 2:1 + TASK4_number_all_OSC))';%ES1:remain taska
            [bit_4re_OSC, reward_4re_OSC, deadline_4re_OSC, p_4re_OSC]  =   front_es_re(flow_front_re_ES4_OSC, TASK4_bit_all_OSC, TASK4_reward_all_OSC, TASK4_deadline_all_OSC,  TASK4_p_all_OSC, TASK4_number_all_OSC);
            deadline_4re_OSC = deadline_4re_OSC - slot;
            %%DTG
            
            ALLOW4_computate_DTG = ALLOW0computate(targetES);
            [bit_4re_DTG, reward_4re_DTG, deadline_4re_DTG, p_4re_DTG, bit_4to4_DTG, reward_4to4_DTG, deadline_4to4_DTG, p_4to4_DTG]  =  loc2(ALLOW4_computate_DTG, TASK4_bit_all_DTG, TASK4_reward_all_DTG, TASK4_deadline_all_DTG,  TASK4_p_all_DTG);
            bit_4to2_DTG = [];reward_4to2_DTG = [];deadline_4to2_DTG = [];p_4to2_DTG = [];
            bit_4to3_DTG = [];reward_4to3_DTG = [];deadline_4to3_DTG = [];p_4to3_DTG = [];
            bit_4to1_DTG = [];reward_4to1_DTG = [];deadline_4to1_DTG = [];p_4to1_DTG = [];
            bit_4to5_DTG = [];reward_4to5_DTG = [];deadline_4to5_DTG = [];p_4to5_DTG = [];
            bit_4to6_DTG = [];reward_4to6_DTG = [];deadline_4to6_DTG = [];p_4to6_DTG = [];
            deadline_4re_DTG = deadline_4re_DTG - slot;
            %%clould
            ALLOW4_computate_CTG = ALLOW0computate(targetES);
            ALLOW4_offload_CTG = ALLOW0offload(targetES, 6);
            TRAN_BIT4_OSC_clould = TRAN_BIT4_OSC(6);
            [task_4to6_CTG, task_4to4_CTG, task_4re_CTG]  =  clould2(ALLOW4_computate_CTG, ALLOW4_offload_CTG, TASK4_bit_all_CTG, TASK4_reward_all_CTG, TASK4_deadline_all_CTG,  TASK4_p_all_CTG, TRAN_BIT4_OSC_clould);
            bit_4to6_CTG = task_4to6_CTG{1};reward_4to6_CTG = task_4to6_CTG{2};deadline_4to6_CTG = task_4to6_CTG{3};p_4to6_CTG = task_4to6_CTG{4};
            bit_4to4_CTG = task_4to4_CTG{1};reward_4to4_CTG = task_4to4_CTG{2};deadline_4to4_CTG = task_4to4_CTG{3};p_4to4_CTG = task_4to4_CTG{4};
            bit_4re_CTG = task_4re_CTG{1};reward_4re_CTG = task_4re_CTG{2};deadline_4re_CTG = task_4re_CTG{3};p_4re_CTG = task_4re_CTG{4};
            bit_4to2_CTG = [];reward_4to2_CTG = [];deadline_4to2_CTG = [];p_4to2_CTG = [];
            bit_4to3_CTG = [];reward_4to3_CTG = [];deadline_4to3_CTG = [];p_4to3_CTG = [];
            bit_4to1_CTG = [];reward_4to1_CTG = [];deadline_4to1_CTG = [];p_4to1_CTG = [];
            bit_4to5_CTG = [];reward_4to5_CTG = [];deadline_4to5_CTG = [];p_4to5_CTG = [];
            deadline_4re_CTG = deadline_4re_CTG - slot;
            %%lo_offload
            ALLOW4_offload_ETG = ALLOW4_offload_OSC;
            if Queue_4B_task_num_ETG <=  3  *  ALLOW0computate(targetES)
                ALLOW4_computate_ETG = ALLOW0computate(targetES);
            else
                if Queue_4B_task_num_ETG <=  4  *  ALLOW0computate(targetES)
                    ALLOW4_computate_ETG = 7  *  ALLOW0computate(targetES) - Queue_4B_task_num_ETG;
                else
                    ALLOW4_computate_ETG = 0;
                end
            end
            ALLOW4_offload_ETG(targetES) = ALLOW4_computate_ETG;
            [cost_inf_ETG, volume_inf_ETG]  =  local_offload2(ALLOW4_offload_ETG, targetES, TASK4_number_all_ETG, TASK4_reward_all_ETG);
            [flow_front_4_ETG] = MCMC_origion(cost_inf_ETG, volume_inf_ETG);%front ES : MCMC flow get
            %% offload & compute queue
            flow_front_4_ES1_ETG = flow_front_4_ETG(:, 2 + TASK4_number_all_ETG);%ES4
            [bit_4to1_ETG, reward_4to1_ETG, deadline_4to1_ETG, p_4to1_ETG]  =  front_es(flow_front_4_ES1_ETG, TASK4_bit_all_ETG, TASK4_reward_all_ETG, TASK4_deadline_all_ETG,  TASK4_p_all_ETG, TASK4_number_all_ETG);
            
            flow_front_4_ES2_ETG = flow_front_4_ETG(:, 3 + TASK4_number_all_ETG);%ES4to2
            [bit_4to2_ETG, reward_4to2_ETG, deadline_4to2_ETG, p_4to2_ETG]  =  front_es(flow_front_4_ES2_ETG, TASK4_bit_all_ETG, TASK4_reward_all_ETG, TASK4_deadline_all_ETG,  TASK4_p_all_ETG, TASK4_number_all_ETG);
            
            flow_front_4_ES3_ETG = flow_front_4_ETG(:, 4 + TASK4_number_all_ETG);%ES4to3
            [bit_4to3_ETG, reward_4to3_ETG, deadline_4to3_ETG, p_4to3_ETG]  =  front_es(flow_front_4_ES3_ETG, TASK4_bit_all_ETG, TASK4_reward_all_ETG, TASK4_deadline_all_ETG,  TASK4_p_all_ETG, TASK4_number_all_ETG);
            
            flow_front_4_ES4_ETG = flow_front_4_ETG(:, 5 + TASK4_number_all_ETG);%ES4to4
            [bit_4to4_ETG, reward_4to4_ETG, deadline_4to4_ETG, p_4to4_ETG]  =  front_es(flow_front_4_ES4_ETG, TASK4_bit_all_ETG, TASK4_reward_all_ETG, TASK4_deadline_all_ETG,  TASK4_p_all_ETG, TASK4_number_all_ETG);
            
            flow_front_4_ES5_ETG = flow_front_4_ETG(:, 6 + TASK4_number_all_ETG);%ES4to5
            [bit_4to5_ETG, reward_4to5_ETG, deadline_4to5_ETG, p_4to5_ETG]  =  front_es(flow_front_4_ES5_ETG, TASK4_bit_all_ETG, TASK4_reward_all_ETG, TASK4_deadline_all_ETG,  TASK4_p_all_ETG, TASK4_number_all_ETG);
            
            flow_front_4_ES6_ETG = flow_front_4_ETG(:, 7 + TASK4_number_all_ETG);%ES4to6
            [bit_4to6_ETG, reward_4to6_ETG, deadline_4to6_ETG, p_4to6_ETG]  =  front_es(flow_front_4_ES6_ETG, TASK4_bit_all_ETG, TASK4_reward_all_ETG, TASK4_deadline_all_ETG,  TASK4_p_all_ETG, TASK4_number_all_ETG);
            
            flow_front_re_ES4_ETG = (flow_front_4_ETG(1, 2:1 + TASK4_number_all_ETG))';%ES1:remain taska
            [bit_4re_ETG, reward_4re_ETG, deadline_4re_ETG, p_4re_ETG]  =   front_es_re(flow_front_re_ES4_ETG, TASK4_bit_all_ETG, TASK4_reward_all_ETG, TASK4_deadline_all_ETG,  TASK4_p_all_ETG, TASK4_number_all_ETG);
            deadline_4re_ETG = deadline_4re_ETG - slot;
        end
        if targetES == 5
            Queue_5F_inf_OSC = Queue_F_OSC(targetES);
            Queue_5B_inf_OSC = Queue_B_OSC(targetES);
            ALLOW5_computate_OSC = ALLOW0computate(targetES);
            ALLOW5_offload_OSC = ALLOW0offload(targetES, :);
            ALLOW5_offload_OSC(targetES) = ALLOW5_computate_OSC;
            TRAN_BIT5_OSC = TRAN_BIT(5, :);
            [t_task_es5]  =  predict_task_t_time(k, slot, Eop, yz, MAXfrequency, Btran_OSC_allpp, Queue_B_OSCpp, Queue_N_OSCpp, TASK5_bit_all_OSC, TASK5_p_all_OSC, B_battery_OSC_ES_MIN, B_battery_OSC_ES_MAX);
            [cost_inf_OSC, volume_inf_OSC] = MO_way2(targetES, Queue_5F_inf_OSC, yz_F, Queue_5B_inf_OSC, TASK5_bit_all_OSC, TASK5_reward_all_OSC, TASK5_number_all_OSC, TASK5_deadline_all_OSC, U, V, price_clould, TRAN_BIT5_OSC, ALLOW5_offload_OSC, t_task_es5);
            [flow_front_5_OSC] = MCMC_origion(cost_inf_OSC, volume_inf_OSC);%front ES : MCMC flow get
            %% offload & compute queue
            flow_front_5_ES1_OSC = flow_front_5_OSC(:, 2 + TASK5_number_all_OSC);%ES5to1
            [bit_5to1_OSC, reward_5to1_OSC, deadline_5to1_OSC, p_5to1_OSC]  =  front_es(flow_front_5_ES1_OSC, TASK5_bit_all_OSC, TASK5_reward_all_OSC, TASK5_deadline_all_OSC,  TASK5_p_all_OSC, TASK5_number_all_OSC);
            
            flow_front_5_ES2_OSC = flow_front_5_OSC(:, 3 + TASK5_number_all_OSC);%ES5to2
            [bit_5to2_OSC, reward_5to2_OSC, deadline_5to2_OSC, p_5to2_OSC]  =  front_es(flow_front_5_ES2_OSC, TASK5_bit_all_OSC, TASK5_reward_all_OSC, TASK5_deadline_all_OSC,  TASK5_p_all_OSC, TASK5_number_all_OSC);
            
            flow_front_5_ES3_OSC = flow_front_5_OSC(:, 4 + TASK5_number_all_OSC);%ES5to3
            [bit_5to3_OSC, reward_5to3_OSC, deadline_5to3_OSC, p_5to3_OSC]  =  front_es(flow_front_5_ES3_OSC, TASK5_bit_all_OSC, TASK5_reward_all_OSC, TASK5_deadline_all_OSC,  TASK5_p_all_OSC, TASK5_number_all_OSC);
            
            flow_front_5_ES4_OSC = flow_front_5_OSC(:, 5 + TASK5_number_all_OSC);%ES5to4
            [bit_5to4_OSC, reward_5to4_OSC, deadline_5to4_OSC, p_5to4_OSC]  =  front_es(flow_front_5_ES4_OSC, TASK5_bit_all_OSC, TASK5_reward_all_OSC, TASK5_deadline_all_OSC,  TASK5_p_all_OSC, TASK5_number_all_OSC);
            
            flow_front_5_ES5_OSC = flow_front_5_OSC(:, 6 + TASK5_number_all_OSC);%ES5to5
            [bit_5to5_OSC, reward_5to5_OSC, deadline_5to5_OSC, p_5to5_OSC]  =  front_es(flow_front_5_ES5_OSC, TASK5_bit_all_OSC, TASK5_reward_all_OSC, TASK5_deadline_all_OSC,  TASK5_p_all_OSC, TASK5_number_all_OSC);
            
            flow_front_5_ES6 = flow_front_5_OSC(:, 7 + TASK5_number_all_OSC);%ES5to6
            [bit_5to6_OSC, reward_5to6_OSC, deadline_5to6_OSC, p_5to6_OSC]  =  front_es(flow_front_5_ES6, TASK5_bit_all_OSC, TASK5_reward_all_OSC, TASK5_deadline_all_OSC,  TASK5_p_all_OSC, TASK5_number_all_OSC);
            
            flow_front_re_ES5_OSC = (flow_front_5_OSC(1, 2:1 + TASK5_number_all_OSC))';%ES1:remain taska
            [bit_5re_OSC, reward_5re_OSC, deadline_5re_OSC, p_5re_OSC]  =   front_es_re(flow_front_re_ES5_OSC, TASK5_bit_all_OSC, TASK5_reward_all_OSC, TASK5_deadline_all_OSC,  TASK5_p_all_OSC, TASK5_number_all_OSC);
            deadline_5re_OSC = deadline_5re_OSC - slot;
            %%DTG
            
            ALLOW5_computate_DTG = ALLOW0computate(targetES);
            [bit_5re_DTG, reward_5re_DTG, deadline_5re_DTG, p_5re_DTG, bit_5to5_DTG, reward_5to5_DTG, deadline_5to5_DTG, p_5to5_DTG]  =  loc2(ALLOW5_computate_DTG, TASK5_bit_all_DTG, TASK5_reward_all_DTG, TASK5_deadline_all_DTG,  TASK5_p_all_DTG);
            bit_5to2_DTG = [];reward_5to2_DTG = [];deadline_5to2_DTG = [];p_5to2_DTG = [];
            bit_5to3_DTG = [];reward_5to3_DTG = [];deadline_5to3_DTG = [];p_5to3_DTG = [];
            bit_5to4_DTG = [];reward_5to4_DTG = [];deadline_5to4_DTG = [];p_5to4_DTG = [];
            bit_5to1_DTG = [];reward_5to1_DTG = [];deadline_5to1_DTG = [];p_5to1_DTG = [];
            bit_5to6_DTG = [];reward_5to6_DTG = [];deadline_5to6_DTG = [];p_5to6_DTG = [];
            deadline_5re_DTG = deadline_5re_DTG - slot;
            %%clould
            ALLOW5_computate_CTG = ALLOW0computate(targetES);
            ALLOW5_offload_CTG = ALLOW0offload(targetES, 6);
            TRAN_BIT5_OSC_clould = TRAN_BIT5_OSC(6);
            [task_5to6_CTG, task_5to5_CTG, task_5re_CTG]  =  clould2(ALLOW5_computate_CTG, ALLOW5_offload_CTG, TASK5_bit_all_CTG, TASK5_reward_all_CTG, TASK5_deadline_all_CTG,  TASK5_p_all_CTG, TRAN_BIT5_OSC_clould);
            bit_5to6_CTG = task_5to6_CTG{1};reward_5to6_CTG = task_5to6_CTG{2};deadline_5to6_CTG = task_5to6_CTG{3};p_5to6_CTG = task_5to6_CTG{4};
            bit_5to5_CTG = task_5to5_CTG{1};reward_5to5_CTG = task_5to5_CTG{2};deadline_5to5_CTG = task_5to5_CTG{3};p_5to5_CTG = task_5to5_CTG{4};
            bit_5re_CTG = task_5re_CTG{1};reward_5re_CTG = task_5re_CTG{2};deadline_5re_CTG = task_5re_CTG{3};p_5re_CTG = task_5re_CTG{4};
            bit_5to2_CTG = [];reward_5to2_CTG = [];deadline_5to2_CTG = [];p_5to2_CTG = [];
            bit_5to3_CTG = [];reward_5to3_CTG = [];deadline_5to3_CTG = [];p_5to3_CTG = [];
            bit_5to4_CTG = [];reward_5to4_CTG = [];deadline_5to4_CTG = [];p_5to4_CTG = [];
            bit_5to1_CTG = [];reward_5to1_CTG = [];deadline_5to1_CTG = [];p_5to1_CTG = [];
            deadline_5re_CTG = deadline_5re_CTG - slot;
            %%lo_offload
            ALLOW5_offload_ETG = ALLOW5_offload_OSC;
            if Queue_5B_task_num_ETG   <=  3  *  ALLOW0computate(targetES)
                ALLOW5_computate_ETG = ALLOW0computate(targetES);
            else
                if Queue_5B_task_num_ETG   <=  4  *  ALLOW0computate(targetES)
                    ALLOW5_computate_ETG = 7  *  ALLOW0computate(targetES) - Queue_5B_task_num_ETG;
                else
                    ALLOW5_computate_ETG = 0;
                end
            end
            ALLOW5_offload_ETG(targetES) = ALLOW5_computate_ETG;
            [cost_inf_ETG, volume_inf_ETG]  =  local_offload2(ALLOW5_offload_ETG, targetES, TASK5_number_all_ETG, TASK5_reward_all_ETG);
            [flow_front_5_ETG] = MCMC_origion(cost_inf_ETG, volume_inf_ETG);%front ES : MCMC flow get
            %% offload & compute queue
            flow_front_5_ES1_ETG = flow_front_5_ETG(:, 2 + TASK5_number_all_ETG);%ES5to1
            [bit_5to1_ETG, reward_5to1_ETG, deadline_5to1_ETG, p_5to1_ETG]  =  front_es(flow_front_5_ES1_ETG, TASK5_bit_all_ETG, TASK5_reward_all_ETG, TASK5_deadline_all_ETG,  TASK5_p_all_ETG, TASK5_number_all_ETG);
            
            flow_front_5_ES2_ETG = flow_front_5_ETG(:, 3 + TASK5_number_all_ETG);%ES5to2
            [bit_5to2_ETG, reward_5to2_ETG, deadline_5to2_ETG, p_5to2_ETG]  =  front_es(flow_front_5_ES2_ETG, TASK5_bit_all_ETG, TASK5_reward_all_ETG, TASK5_deadline_all_ETG,  TASK5_p_all_ETG, TASK5_number_all_ETG);
            
            flow_front_5_ES3_ETG = flow_front_5_ETG(:, 4 + TASK5_number_all_ETG);%ES5to3
            [bit_5to3_ETG, reward_5to3_ETG, deadline_5to3_ETG, p_5to3_ETG]  =  front_es(flow_front_5_ES3_ETG, TASK5_bit_all_ETG, TASK5_reward_all_ETG, TASK5_deadline_all_ETG,  TASK5_p_all_ETG, TASK5_number_all_ETG);
            
            flow_front_5_ES4_ETG = flow_front_5_ETG(:, 5 + TASK5_number_all_ETG);%ES5to4
            [bit_5to4_ETG, reward_5to4_ETG, deadline_5to4_ETG, p_5to4_ETG]  =  front_es(flow_front_5_ES4_ETG, TASK5_bit_all_ETG, TASK5_reward_all_ETG, TASK5_deadline_all_ETG,  TASK5_p_all_ETG, TASK5_number_all_ETG);
            
            flow_front_5_ES5_ETG = flow_front_5_ETG(:, 6 + TASK5_number_all_ETG);%ES5to5
            [bit_5to5_ETG, reward_5to5_ETG, deadline_5to5_ETG, p_5to5_ETG]  =  front_es(flow_front_5_ES5_ETG, TASK5_bit_all_ETG, TASK5_reward_all_ETG, TASK5_deadline_all_ETG,  TASK5_p_all_ETG, TASK5_number_all_ETG);
            
            flow_front_5_ES6 = flow_front_5_ETG(:, 7 + TASK5_number_all_ETG);%ES5to6
            [bit_5to6_ETG, reward_5to6_ETG, deadline_5to6_ETG, p_5to6_ETG]  =  front_es(flow_front_5_ES6, TASK5_bit_all_ETG, TASK5_reward_all_ETG, TASK5_deadline_all_ETG,  TASK5_p_all_ETG, TASK5_number_all_ETG);
            
            flow_front_re_ES5_ETG = (flow_front_5_ETG(1, 2:1 + TASK5_number_all_ETG))';%ES1:remain taska
            [bit_5re_ETG, reward_5re_ETG, deadline_5re_ETG, p_5re_ETG]  =   front_es_re(flow_front_re_ES5_ETG, TASK5_bit_all_ETG, TASK5_reward_all_ETG, TASK5_deadline_all_ETG,  TASK5_p_all_ETG, TASK5_number_all_ETG);
            deadline_5re_ETG = deadline_5re_ETG - slot;
        end
        targetES = targetES + 1;
    end
    
    %% ;accumalate frequency
    B_battery_OSC_1ES = B_battery_OSC(1);
    B_battery_OSC_2ES = B_battery_OSC(2);
    B_battery_OSC_3ES = B_battery_OSC(3);
    B_battery_OSC_4ES = B_battery_OSC(4);
    B_battery_OSC_5ES = B_battery_OSC(5);
    
    Btran_OSC_ES1 = Btran_OSC(1);
    Btran_OSC_ES2 = Btran_OSC(2);
    Btran_OSC_ES3 = Btran_OSC(3);
    Btran_OSC_ES4 = Btran_OSC(4);
    Btran_OSC_ES5 = Btran_OSC(5);
    
    [result1, frequency_ES1_OSC]  =  frequency(k, slot, Eop, yz, MAX1frequency, Queue_B_OSC(1), Queue_1B_task_num_OSC, Queue_1B_task_p_OSC, Queue_1B_task_bit_OSC, B_battery_OSC_1ES, B_battery_OSC_ES_MIN(1), B_battery_OSC_ES_MAX(1), Btran_OSC_ES1);
    [result2, frequency_ES2_OSC]  =  frequency(k, slot, Eop, yz, MAX2frequency, Queue_B_OSC(2), Queue_2B_task_num_OSC, Queue_2B_task_p_OSC, Queue_2B_task_bit_OSC, B_battery_OSC_2ES, B_battery_OSC_ES_MIN(2), B_battery_OSC_ES_MAX(2), Btran_OSC_ES2);
    [result3, frequency_ES3_OSC]  =  frequency(k, slot, Eop, yz, MAX3frequency, Queue_B_OSC(3), Queue_3B_task_num_OSC, Queue_3B_task_p_OSC, Queue_3B_task_bit_OSC, B_battery_OSC_3ES, B_battery_OSC_ES_MIN(3), B_battery_OSC_ES_MAX(3), Btran_OSC_ES3);
    [result4, frequency_ES4_OSC]  =  frequency(k, slot, Eop, yz, MAX4frequency, Queue_B_OSC(4), Queue_4B_task_num_OSC, Queue_4B_task_p_OSC, Queue_4B_task_bit_OSC, B_battery_OSC_4ES, B_battery_OSC_ES_MIN(4), B_battery_OSC_ES_MAX(4), Btran_OSC_ES4);
    [result5, frequency_ES5_OSC]  =  frequency(k, slot, Eop, yz, MAX5frequency, Queue_B_OSC(5), Queue_5B_task_num_OSC, Queue_5B_task_p_OSC, Queue_5B_task_bit_OSC, B_battery_OSC_5ES, B_battery_OSC_ES_MIN(5), B_battery_OSC_ES_MAX(5), Btran_OSC_ES5);
    
    %%DTG
    [frequency_ES1_DTG]  =  loc_frequency(k, slot, B_battery_OSC_ES_MIN(1), Btran_DTG(1));
    [frequency_ES2_DTG]  =  loc_frequency(k, slot, B_battery_OSC_ES_MIN(2), Btran_DTG(2));
    [frequency_ES3_DTG]  =  loc_frequency(k, slot, B_battery_OSC_ES_MIN(3), Btran_DTG(3));
    [frequency_ES4_DTG]  =  loc_frequency(k, slot, B_battery_OSC_ES_MIN(4), Btran_DTG(4));
    [frequency_ES5_DTG]  =  loc_frequency(k, slot, B_battery_OSC_ES_MIN(5), Btran_DTG(5));
    
    %%clould
    [frequency_ES1_CTG]  =  loc_frequency(k, slot, B_battery_OSC_ES_MIN(1), Btran_CTG(1));
    [frequency_ES2_CTG]  =  loc_frequency(k, slot, B_battery_OSC_ES_MIN(2), Btran_CTG(2));
    [frequency_ES3_CTG]  =  loc_frequency(k, slot, B_battery_OSC_ES_MIN(3), Btran_CTG(3));
    [frequency_ES4_CTG]  =  loc_frequency(k, slot, B_battery_OSC_ES_MIN(4), Btran_CTG(4));
    [frequency_ES5_CTG]  =  loc_frequency(k, slot, B_battery_OSC_ES_MIN(5), Btran_CTG(5));
    %%clould offloa
    [frequency_ES1_ETG]  =  loc_frequency(k, slot, B_battery_OSC_ES_MIN(1), Btran_ETG(1));
    [frequency_ES2_ETG]  =  loc_frequency(k, slot, B_battery_OSC_ES_MIN(2), Btran_ETG(2));
    [frequency_ES3_ETG]  =  loc_frequency(k, slot, B_battery_OSC_ES_MIN(3), Btran_ETG(3));
    [frequency_ES4_ETG]  =  loc_frequency(k, slot, B_battery_OSC_ES_MIN(4), Btran_ETG(4));
    [frequency_ES5_ETG]  =  loc_frequency(k, slot, B_battery_OSC_ES_MIN(5), Btran_ETG(5));
    %% finish caculation
    %%OSC algrim
    Queue_1B_task_OSC = {Queue_1B_task_p_OSC, Queue_1B_task_reward_OSC, Queue_1B_task_deadline_OSC, Queue_1B_task_bit_OSC, Queue_1B_task_time_OSC};
    Queue_2B_task_OSC = {Queue_2B_task_p_OSC, Queue_2B_task_reward_OSC, Queue_2B_task_deadline_OSC, Queue_2B_task_bit_OSC, Queue_2B_task_time_OSC};
    Queue_3B_task_OSC = {Queue_3B_task_p_OSC, Queue_3B_task_reward_OSC, Queue_3B_task_deadline_OSC, Queue_3B_task_bit_OSC, Queue_3B_task_time_OSC};
    Queue_4B_task_OSC = {Queue_4B_task_p_OSC, Queue_4B_task_reward_OSC, Queue_4B_task_deadline_OSC, Queue_4B_task_bit_OSC, Queue_4B_task_time_OSC};
    Queue_5B_task_OSC = {Queue_5B_task_p_OSC, Queue_5B_task_reward_OSC, Queue_5B_task_deadline_OSC, Queue_5B_task_bit_OSC, Queue_5B_task_time_OSC};
    [result_1ES, Queue_1B_inf_OSC, Queue_1B_task_OSC, B_battery_OSC_1ES]  =  refresh_queue_B(slot, Queue_1B_task_OSC, frequency_ES1_OSC, Queue_1B_inf_OSC, Btran_OSC_ES1, k);
    [result_2ES, Queue_2B_inf_OSC, Queue_2B_task_OSC, B_battery_OSC_2ES]  =  refresh_queue_B(slot, Queue_2B_task_OSC, frequency_ES2_OSC, Queue_2B_inf_OSC, Btran_OSC_ES2, k);
    [result_3ES, Queue_3B_inf_OSC, Queue_3B_task_OSC, B_battery_OSC_3ES]  =  refresh_queue_B(slot, Queue_3B_task_OSC, frequency_ES3_OSC, Queue_3B_inf_OSC, Btran_OSC_ES3, k);
    [result_4ES, Queue_4B_inf_OSC, Queue_4B_task_OSC, B_battery_OSC_4ES]  =  refresh_queue_B(slot, Queue_4B_task_OSC, frequency_ES4_OSC, Queue_4B_inf_OSC, Btran_OSC_ES4, k);
    [result_5ES, Queue_5B_inf_OSC, Queue_5B_task_OSC, B_battery_OSC_5ES]  =  refresh_queue_B(slot, Queue_5B_task_OSC, frequency_ES5_OSC, Queue_5B_inf_OSC, Btran_OSC_ES5, k);
    
    B_battery_OSC(1) = B_battery_OSC_1ES;
    B_battery_OSC(2) = B_battery_OSC_2ES;
    B_battery_OSC(3) = B_battery_OSC_3ES;
    B_battery_OSC(4) = B_battery_OSC_4ES;
    B_battery_OSC(5) = B_battery_OSC_5ES;
    Queue_1B_task_time_OSC = Queue_1B_task_OSC{5};
    Queue_2B_task_time_OSC = Queue_2B_task_OSC{5};
    Queue_3B_task_time_OSC = Queue_3B_task_OSC{5};
    Queue_4B_task_time_OSC = Queue_4B_task_OSC{5};
    Queue_5B_task_time_OSC = Queue_5B_task_OSC{5};
    %%DTG algrim
    Btran_DTG_ES1 = Btran_DTG(1);
    Btran_DTG_ES2 = Btran_DTG(2);
    Btran_DTG_ES3 = Btran_DTG(3);
    Btran_DTG_ES4 = Btran_DTG(4);
    Btran_DTG_ES5 = Btran_DTG(5);
    Queue_1B_task_DTG = {Queue_1B_task_p_DTG, Queue_1B_task_reward_DTG, Queue_1B_task_deadline_DTG, Queue_1B_task_bit_DTG, Queue_1B_task_time_DTG};
    Queue_2B_task_DTG = {Queue_2B_task_p_DTG, Queue_2B_task_reward_DTG, Queue_2B_task_deadline_DTG, Queue_2B_task_bit_DTG, Queue_2B_task_time_DTG};
    Queue_3B_task_DTG = {Queue_3B_task_p_DTG, Queue_3B_task_reward_DTG, Queue_3B_task_deadline_DTG, Queue_3B_task_bit_DTG, Queue_3B_task_time_DTG};
    Queue_4B_task_DTG = {Queue_4B_task_p_DTG, Queue_4B_task_reward_DTG, Queue_4B_task_deadline_DTG, Queue_4B_task_bit_DTG, Queue_4B_task_time_DTG};
    Queue_5B_task_DTG = {Queue_5B_task_p_DTG, Queue_5B_task_reward_DTG, Queue_5B_task_deadline_DTG, Queue_5B_task_bit_DTG, Queue_5B_task_time_DTG};
    [result_1ES_DTG, Queue_1B_inf_DTG, Queue_1B_task_DTG, B_battery_DTG_1ES]  =  refresh_queue_B(slot, Queue_1B_task_DTG, frequency_ES1_DTG, Queue_B_DTG(1), Btran_DTG_ES1, k);
    [result_2ES_DTG, Queue_2B_inf_DTG, Queue_2B_task_DTG, B_battery_DTG_2ES]  =  refresh_queue_B(slot, Queue_2B_task_DTG, frequency_ES2_DTG, Queue_B_DTG(2), Btran_DTG_ES2, k);
    [result_3ES_DTG, Queue_3B_inf_DTG, Queue_3B_task_DTG, B_battery_DTG_3ES]  =  refresh_queue_B(slot, Queue_3B_task_DTG, frequency_ES3_DTG, Queue_B_DTG(3), Btran_DTG_ES3, k);
    [result_4ES_DTG, Queue_4B_inf_DTG, Queue_4B_task_DTG, B_battery_DTG_4ES]  =  refresh_queue_B(slot, Queue_4B_task_DTG, frequency_ES4_DTG, Queue_B_DTG(4), Btran_DTG_ES4, k);
    [result_5ES_DTG, Queue_5B_inf_DTG, Queue_5B_task_DTG, B_battery_DTG_5ES]  =  refresh_queue_B(slot, Queue_5B_task_DTG, frequency_ES5_DTG, Queue_B_DTG(5), Btran_DTG_ES5, k);
    B_battery_DTG(1) = B_battery_DTG_1ES;
    B_battery_DTG(2) = B_battery_DTG_2ES;
    B_battery_DTG(3) = B_battery_DTG_3ES;
    B_battery_DTG(4) = B_battery_DTG_4ES;
    B_battery_DTG(5) = B_battery_DTG_5ES;
    
    %%CTG algrim
    Btran_CTG_ES1 = Btran_CTG(1);
    Btran_CTG_ES2 = Btran_CTG(2);
    Btran_CTG_ES3 = Btran_CTG(3);
    Btran_CTG_ES4 = Btran_CTG(4);
    Btran_CTG_ES5 = Btran_CTG(5);
    Queue_1B_task_CTG = {Queue_1B_task_p_CTG, Queue_1B_task_reward_CTG, Queue_1B_task_deadline_CTG, Queue_1B_task_bit_CTG, Queue_1B_task_time_CTG};
    Queue_2B_task_CTG = {Queue_2B_task_p_CTG, Queue_2B_task_reward_CTG, Queue_2B_task_deadline_CTG, Queue_2B_task_bit_CTG, Queue_2B_task_time_CTG};
    Queue_3B_task_CTG = {Queue_3B_task_p_CTG, Queue_3B_task_reward_CTG, Queue_3B_task_deadline_CTG, Queue_3B_task_bit_CTG, Queue_3B_task_time_CTG};
    Queue_4B_task_CTG = {Queue_4B_task_p_CTG, Queue_4B_task_reward_CTG, Queue_4B_task_deadline_CTG, Queue_4B_task_bit_CTG, Queue_4B_task_time_CTG};
    Queue_5B_task_CTG = {Queue_5B_task_p_CTG, Queue_5B_task_reward_CTG, Queue_5B_task_deadline_CTG, Queue_5B_task_bit_CTG, Queue_5B_task_time_CTG};
    [result_1ES_CTG, Queue_1B_inf_CTG, Queue_1B_task_CTG, B_battery_CTG_1ES]  =  refresh_queue_B(slot, Queue_1B_task_CTG, frequency_ES1_CTG, Queue_B_CTG(1), Btran_CTG_ES1, k);
    [result_2ES_CTG, Queue_2B_inf_CTG, Queue_2B_task_CTG, B_battery_CTG_2ES]  =  refresh_queue_B(slot, Queue_2B_task_CTG, frequency_ES2_CTG, Queue_B_CTG(2), Btran_CTG_ES2, k);
    [result_3ES_CTG, Queue_3B_inf_CTG, Queue_3B_task_CTG, B_battery_CTG_3ES]  =  refresh_queue_B(slot, Queue_3B_task_CTG, frequency_ES3_CTG, Queue_B_CTG(3), Btran_CTG_ES3, k);
    [result_4ES_CTG, Queue_4B_inf_CTG, Queue_4B_task_CTG, B_battery_CTG_4ES]  =  refresh_queue_B(slot, Queue_4B_task_CTG, frequency_ES4_CTG, Queue_B_CTG(4), Btran_CTG_ES4, k);
    [result_5ES_CTG, Queue_5B_inf_CTG, Queue_5B_task_CTG, B_battery_CTG_5ES]  =  refresh_queue_B(slot, Queue_5B_task_CTG, frequency_ES5_CTG, Queue_B_CTG(5), Btran_CTG_ES5, k);
    B_battery_CTG(1) = B_battery_CTG_1ES;
    B_battery_CTG(2) = B_battery_CTG_2ES;
    B_battery_CTG(3) = B_battery_CTG_3ES;
    B_battery_CTG(4) = B_battery_CTG_4ES;
    B_battery_CTG(5) = B_battery_CTG_5ES;
    
    %%ETG algrim
    Btran_ETG_ES1 = Btran_ETG(1);
    Btran_ETG_ES2 = Btran_ETG(2);
    Btran_ETG_ES3 = Btran_ETG(3);
    Btran_ETG_ES4 = Btran_ETG(4);
    Btran_ETG_ES5 = Btran_ETG(5);
    Queue_1B_task_ETG = {Queue_1B_task_p_ETG, Queue_1B_task_reward_ETG, Queue_1B_task_deadline_ETG, Queue_1B_task_bit_ETG, Queue_1B_task_time_ETG};
    Queue_2B_task_ETG = {Queue_2B_task_p_ETG, Queue_2B_task_reward_ETG, Queue_2B_task_deadline_ETG, Queue_2B_task_bit_ETG, Queue_2B_task_time_ETG};
    Queue_3B_task_ETG = {Queue_3B_task_p_ETG, Queue_3B_task_reward_ETG, Queue_3B_task_deadline_ETG, Queue_3B_task_bit_ETG, Queue_3B_task_time_ETG};
    Queue_4B_task_ETG = {Queue_4B_task_p_ETG, Queue_4B_task_reward_ETG, Queue_4B_task_deadline_ETG, Queue_4B_task_bit_ETG, Queue_4B_task_time_ETG};
    Queue_5B_task_ETG = {Queue_5B_task_p_ETG, Queue_5B_task_reward_ETG, Queue_5B_task_deadline_ETG, Queue_5B_task_bit_ETG, Queue_5B_task_time_ETG};
    [result_1ES_ETG, Queue_1B_inf_ETG, Queue_1B_task_ETG, B_battery_ETG_1ES]  =  refresh_queue_B(slot, Queue_1B_task_ETG, frequency_ES1_ETG, Queue_B_ETG(1), Btran_ETG_ES1, k);
    [result_2ES_ETG, Queue_2B_inf_ETG, Queue_2B_task_ETG, B_battery_ETG_2ES]  =  refresh_queue_B(slot, Queue_2B_task_ETG, frequency_ES2_ETG, Queue_B_ETG(2), Btran_ETG_ES2, k);
    [result_3ES_ETG, Queue_3B_inf_ETG, Queue_3B_task_ETG, B_battery_ETG_3ES]  =  refresh_queue_B(slot, Queue_3B_task_ETG, frequency_ES3_ETG, Queue_B_ETG(3), Btran_ETG_ES3, k);
    [result_4ES_ETG, Queue_4B_inf_ETG, Queue_4B_task_ETG, B_battery_ETG_4ES]  =  refresh_queue_B(slot, Queue_4B_task_ETG, frequency_ES4_ETG, Queue_B_ETG(4), Btran_ETG_ES4, k);
    [result_5ES_ETG, Queue_5B_inf_ETG, Queue_5B_task_ETG, B_battery_ETG_5ES]  =  refresh_queue_B(slot, Queue_5B_task_ETG, frequency_ES5_ETG, Queue_B_ETG(5), Btran_ETG_ES5, k);
    B_battery_ETG(1) = B_battery_ETG_1ES;
    B_battery_ETG(2) = B_battery_ETG_2ES;
    B_battery_ETG(3) = B_battery_ETG_3ES;
    B_battery_ETG(4) = B_battery_ETG_4ES;
    B_battery_ETG(5) = B_battery_ETG_5ES;
    %% count aim matrix
    %%OSC
    reward_OSC = result_1ES{1} + result_2ES{1} + result_3ES{1} + result_4ES{1} + result_5ES{1} + sum(reward_1to6_OSC) + sum(reward_2to6_OSC) + sum(reward_3to6_OSC) + sum(reward_4to6_OSC) + sum(reward_5to6_OSC);
    number_OSC_clould = size(bit_1to6_OSC, 2) + size(bit_2to6_OSC, 2) + size(bit_3to6_OSC, 2) + size(bit_4to6_OSC, 2) + size(bit_5to6_OSC, 2);
    number_OSC = result_1ES{2} + result_2ES{2} + result_3ES{2} + result_4ES{2} + result_5ES{2} + number_OSC_clould;
    time_OSC_clould = sum(bit_1to6_OSC)  *  TRAN_BIT(1, 6) + sum(bit_2to6_OSC)  *  TRAN_BIT(2, 6) + sum(bit_3to6_OSC)  *  TRAN_BIT(3, 6) + sum(bit_4to6_OSC)  *  TRAN_BIT(4, 6) + sum(bit_5to6_OSC)  *  TRAN_BIT(5, 6);
    pay_OSC_clould = (sum(bit_1to6_OSC) + sum(bit_2to6_OSC) + sum(bit_3to6_OSC) + sum(bit_4to6_OSC) + sum(bit_5to6_OSC))  *  price_clould;
    time_OSC = result_1ES{3} + result_2ES{3} + result_3ES{3} + result_4ES{3} + result_5ES{3};
    
    %%DTG
    reward_DTG = result_1ES_DTG{1} + result_2ES_DTG{1} + result_3ES_DTG{1} + result_4ES_DTG{1} + result_5ES_DTG{1};
    number_DTG = result_1ES_DTG{2} + result_2ES_DTG{2} + result_3ES_DTG{2} + result_4ES_DTG{2} + result_5ES_DTG{2};
    time_DTG = result_1ES_DTG{3} + result_2ES_DTG{3} + result_3ES_DTG{3} + result_4ES_DTG{3} + result_5ES_DTG{3};
    
    %%clould
    reward_CTG = result_1ES_CTG{1} + result_2ES_CTG{1} + result_3ES_CTG{1} + result_4ES_CTG{1} + result_5ES_CTG{1} + sum(reward_1to6_CTG) + sum(reward_2to6_CTG) + sum(reward_3to6_CTG) + sum(reward_4to6_CTG) + sum(reward_5to6_CTG);
    number_CTG_clould = size(bit_1to6_CTG, 2) + size(bit_2to6_CTG, 2) + size(bit_3to6_CTG, 2) + size(bit_4to6_CTG, 2) + size(bit_5to6_CTG, 2);
    number_CTG = result_1ES_CTG{2} + result_2ES_CTG{2} + result_3ES_CTG{2} + result_4ES_CTG{2} + result_5ES_CTG{2} + number_CTG_clould;
    time_CTG_clould = sum(bit_1to6_CTG)  *  TRAN_BIT(1, 6) + sum(bit_2to6_CTG)  *  TRAN_BIT(2, 6) + sum(bit_3to6_CTG)  *  TRAN_BIT(3, 6) + sum(bit_4to6_CTG)  *  TRAN_BIT(4, 6) + sum(bit_5to6_CTG)  *  TRAN_BIT(5, 6);
    pay_CTG_clould = (sum(bit_1to6_CTG) + sum(bit_2to6_CTG) + sum(bit_3to6_CTG) + sum(bit_4to6_CTG) + sum(bit_5to6_CTG))  *  price_clould;
    time_CTG = result_1ES_CTG{3} + result_2ES_CTG{3} + result_3ES_CTG{3} + result_4ES_CTG{3} + result_5ES_CTG{3};
    
    %%clould offload
    reward_ETG = result_1ES_ETG{1} + result_2ES_ETG{1} + result_3ES_ETG{1} + result_4ES_ETG{1} + result_5ES_ETG{1} + sum(reward_1to6_ETG) + sum(reward_2to6_ETG) + sum(reward_3to6_ETG) + sum(reward_4to6_ETG) + sum(reward_5to6_ETG);
    number_ETG_clould = size(bit_1to6_ETG, 2) + size(bit_2to6_ETG, 2) + size(bit_3to6_ETG, 2) + size(bit_4to6_ETG, 2) + size(bit_5to6_ETG, 2);
    number_ETG = result_1ES_ETG{2} + result_2ES_ETG{2} + result_3ES_ETG{2} + result_4ES_ETG{2} + result_5ES_ETG{2} + number_ETG_clould;
    time_ETG_clould = sum(bit_1to6_ETG)  *  TRAN_BIT(1, 6) + sum(bit_2to6_ETG)  *  TRAN_BIT(2, 6) + sum(bit_3to6_ETG)  *  TRAN_BIT(3, 6) + sum(bit_4to6_ETG)  *  TRAN_BIT(4, 6) + sum(bit_5to6_ETG)  *  TRAN_BIT(5, 6);
    pay_ETG_clould = (sum(bit_1to6_ETG) + sum(bit_2to6_ETG) + sum(bit_3to6_ETG) + sum(bit_4to6_ETG) + sum(bit_5to6_ETG))  *  price_clould;
    time_ETG = result_1ES_ETG{3} + result_2ES_ETG{3} + result_3ES_ETG{3} + result_4ES_ETG{3} + result_5ES_ETG{3};
    
    B_battery_OSC_ALL(cnt) = B_battery_OSC(2);
    B_battery_DTG_ALL(cnt) = B_battery_DTG(2);
    B_battery_CTG_ALL(cnt) = B_battery_CTG(2);
    B_battery_ETG_ALL(cnt) = B_battery_ETG(2);
    
    Btran_OSC1_all(cnt) = Btran_OSC(1);
    Btran_OSC2_all(cnt) = Btran_OSC(2);
    Btran_OSC3_all(cnt) = Btran_OSC(3);
    Btran_OSC4_all(cnt) = Btran_OSC(4);
    Btran_OSC5_all(cnt) = Btran_OSC(5);
    Queue_B_OSC1(cnt) = Queue_B_OSC(1);
    Queue_B_OSC2(cnt) = Queue_B_OSC(2);
    Queue_B_OSC3(cnt) = Queue_B_OSC(3);
    Queue_B_OSC4(cnt) = Queue_B_OSC(4);
    Queue_B_OSC5(cnt) = Queue_B_OSC(5);
    Queue_N_OSC1(cnt) = Queue_N_OSC(1);
    Queue_N_OSC2(cnt) = Queue_N_OSC(2);
    Queue_N_OSC3(cnt) = Queue_N_OSC(3);
    Queue_N_OSC4(cnt) = Queue_N_OSC(4);
    Queue_N_OSC5(cnt) = Queue_N_OSC(5);
    if cnt >= 17
        REWARD_COST_ALL_OSC(cnt - 15) = REWARD_COST_ALL_OSC(cnt - 15 - 1) + reward_OSC - pay_OSC_clould - sum(Bbatterytime_OSC)  *  price_grid;
        REWARD_COST_ALL_DTG(cnt - 15) = REWARD_COST_ALL_DTG(cnt - 15 - 1) + reward_DTG - sum(Bbatterytime_DTG)  *  price_grid;
        REWARD_COST_ALL_CTG(cnt - 15) = REWARD_COST_ALL_CTG(cnt - 15 - 1) + reward_CTG - pay_CTG_clould - sum(Bbatterytime_CTG)  *  price_grid;
        REWARD_COST_ALL_ETG(cnt - 15) = REWARD_COST_ALL_ETG(cnt - 15 - 1) + reward_ETG - pay_ETG_clould - sum(Bbatterytime_ETG)  *  price_grid;
        
        Number_ALL_OSC(cnt - 15) = Number_ALL_OSC(cnt - 15) + number_OSC;
        Number_ALL_DTG(cnt - 15) = Number_ALL_DTG(cnt - 15) + number_DTG;
        Number_ALL_CTG(cnt - 15) = Number_ALL_CTG(cnt - 15) + number_CTG;
        Number_ALL_ETG(cnt - 15) = Number_ALL_ETG(cnt - 15) + number_ETG;
        
        Time_ALL_OSC(cnt - 15) = (1 + cnt)/2  *  slot/sum(Number_ALL_OSC);
        Time_ALL_DTG(cnt - 15) = (1 + cnt)/2  *  slot/sum(Number_ALL_DTG);
        Time_ALL_CTG(cnt - 15) = (1 + cnt)/2  *  slot/sum(Number_ALL_CTG);
        Time_ALL_ETG(cnt - 15) = (1 + cnt)/2  *  slot/sum(Number_ALL_ETG);
        
        
        TASK(cnt - 15) = TASK_inf;
        drop_number_OSC(cnt - 15) = mumber1_OSC + mumber2_OSC + mumber3_OSC + mumber4_OSC + mumber5_OSC;
        drop_number_DTG(cnt - 15) = mumber1_DTG + mumber2_DTG + mumber3_DTG + mumber4_DTG + mumber5_DTG;
        drop_number_CTG(cnt - 15) = mumber1_CTG + mumber2_CTG + mumber3_CTG + mumber4_CTG + mumber5_CTG;
        drop_number_ETG(cnt - 15) = mumber1_ETG + mumber2_ETG + mumber3_ETG + mumber4_ETG + mumber5_ETG;
        Drop_task_OSC_ALL(cnt - 15) = 1 - sum(Number_ALL_OSC)/sum(TASK);
        Drop_task_DTG_ALL(cnt - 15) = 1 - sum(Number_ALL_DTG)/sum(TASK);
        Drop_task_CTG_ALL(cnt - 15) = 1 - sum(Number_ALL_CTG)/sum(TASK);
        Drop_task_ETG_ALL(cnt - 15) = 1 - sum(Number_ALL_ETG)/sum(TASK);
    end
    %%
    T = T + 1;
    cnt  =  cnt  +  1;
    disp(T);
end
disp([num2str(REWARD_COST_ALL_OSC(51) - REWARD_COST_ALL_OSC(2)),...
    newline,num2str(REWARD_COST_ALL_DTG(51) - REWARD_COST_ALL_DTG(2)),...
    newline,num2str(REWARD_COST_ALL_CTG(51) - REWARD_COST_ALL_CTG(2)),...
    newline,num2str(REWARD_COST_ALL_ETG(51) - REWARD_COST_ALL_ETG(2)),newline]);

disp([num2str(Drop_task_OSC_ALL(cnt - 16)),...
    newline,num2str(Drop_task_DTG_ALL(cnt - 16)),...
    newline,num2str(Drop_task_CTG_ALL(cnt - 16)),...
    newline,num2str(Drop_task_ETG_ALL(cnt - 16)),newline]);

disp([num2str(Time_ALL_OSC(cnt - 16)),...
    newline,num2str(Time_ALL_DTG(cnt - 16)),...
    newline,num2str(Time_ALL_CTG(cnt - 16)),...
    newline,num2str(Time_ALL_ETG(cnt - 16))]);