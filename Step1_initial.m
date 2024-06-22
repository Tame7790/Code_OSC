clear;
clc;
Q=0;

yz=50;
yz_F=9000;
Eop=10;
U=100;
V=1;
slot=0.001;
k=10^(-23);%energy-frequency
TRAN_BIT=10^(-7)*[0,   2,  3,   4,   5,    7;
          2,  0, 2.5, 3.4,   4,  9;
          3,2.5,   0,   4, 5.1,  5;
          4,3.4,   4,   0, 2.3,  6;
          5,  4, 5.1, 2.3,   0,  7;
          6,5.4, 1.2, 2.4,3.1, 0;];%chuanshu time/bit

price1=0.5;
price_clould=0.01;
d_clould=0.002;
price_grid=0.05;

B_battery=[54,60,33,44,65];             

ES = 5;
Bbattery=35*ones(1,ES);
MAX1frequency=1.5*10^9;
MAX1tranpower=100;
MAX2frequency=10^10;
MAX2tranpower=100;
MAX3frequency=1.5*10^9;
MAX3tranpower=100;
MAX4frequency=10^9;
MAX4tranpower=100;
MAX5frequency=1.7*10^9;
MAX5tranpower=100;
MAX6frequency=2*10^9;
MAX6tranpower=100;
MAXfrequency=[MAX1frequency,MAX2frequency,MAX3frequency,MAX4frequency,MAX5frequency];

B_battery_DTG_ES_MIN=10;
B_battery_CTG_ES_MIN=10;
B_battery_ETG_ES_MIN=10;

B_battery_DTG_ES_MAX=300;
B_battery_CTG_ES_MAX=300;
B_battery_ETG_ES_MAX=300;

T_ALL = 65;
B_battery_OSC_ES_MIN=[10,12,14,16,14,12];
B_battery_OSC_ES_MAX=[30,30,30,30,30];


%%
REWARD_COST_ALL_OSC=zeros(1,T_ALL+1);
REWARD_COST_ALL_DTG=zeros(1,T_ALL+1);
REWARD_COST_ALL_CTG=zeros(1,T_ALL+1);
REWARD_COST_ALL_ETG=zeros(1,T_ALL+1);

Number_ALL_DTG=zeros(1,T_ALL+1);
Number_ALL_CTG=zeros(1,T_ALL+1);
Number_ALL_ETG=zeros(1,T_ALL+1);

Time_ALL_DTG=zeros(1,T_ALL+1);
Time_ALL_CTG=zeros(1,T_ALL+1);
Time_ALL_ETG=zeros(1,T_ALL+1);

B_battery_DTG_ALL=zeros(1,T_ALL+1);
B_battery_CTG_ALL=zeros(1,T_ALL+1);
B_battery_ETG_ALL=zeros(1,T_ALL+1);

Drop_task_OSC_ALL=zeros(1,T_ALL+1);
Drop_task_DTG_ALL=zeros(1,T_ALL+1);
Drop_task_CTG_ALL=zeros(1,T_ALL+1);
Drop_task_ETG_ALL=zeros(1,T_ALL+1);

cost_battery_OSC=zeros(1,T_ALL+1);

B_battery_OSC_ALL=zeros(1,T_ALL+1);
B_battery_OSC_ALL=zeros(1,T_ALL+1);
B_battery_1_ALL=zeros(1,T_ALL+1);
B_battery_CLOULD_ALL=zeros(1,T_ALL+1);
B_battery_CL_LO_ALL=zeros(1,T_ALL+1);

Drop_task_OSC_ALL=zeros(1,T_ALL+1);
Drop_task_1_ALL=zeros(1,T_ALL+1);
Drop_task_CLOULD_ALL=zeros(1,T_ALL+1);
Drop_task_CL_LO_ALL=zeros(1,T_ALL+1);

Btran_OSC1_all=zeros(1,T_ALL+1);
Btran_OSC2_all=zeros(1,T_ALL+1);
Btran_OSC3_all=zeros(1,T_ALL+1);
Btran_OSC4_all=zeros(1,T_ALL+1);
Btran_OSC5_all=zeros(1,T_ALL+1);

Queue_B_OSC1=zeros(1,T_ALL+1);
Queue_B_OSC2=zeros(1,T_ALL+1);
Queue_B_OSC3=zeros(1,T_ALL+1);
Queue_B_OSC4=zeros(1,T_ALL+1);
Queue_B_OSC5=zeros(1,T_ALL+1);

Queue_N_OSC1=zeros(1,T_ALL+1);
Queue_N_OSC2=zeros(1,T_ALL+1);
Queue_N_OSC3=zeros(1,T_ALL+1);
Queue_N_OSC4=zeros(1,T_ALL+1);
Queue_N_OSC5=zeros(1,T_ALL+1);

Number_ALL_OSC=zeros(1,T_ALL+1);
TASK=zeros(1,T_ALL+1);

Time_ALL_OSC=zeros(1,T_ALL+1);
TASK1_bit_all=0;
TASK1bit_in=0;
TASK1_deadline_all=0;
TASK1_reward_in=0;
TASK1_p_all=0;
TASK1_p_in=0;
TASK1_reward_all=0;


GEtime_OSC=zeros(1,ES);
Bbatterytime_OSC=zeros(1,ES);
GEtime_OSC=zeros(1,ES);
Bbatterytime_OSC=zeros(1,ES);
GEtime_1=zeros(1,ES);
Bbatterytime_1=zeros(1,ES);
GEtime_CLOULD=zeros(1,ES);
Bbatterytime_CLOULD=zeros(1,ES);
GEtime_CL_LO=zeros(1,ES);
Bbatterytime_CL_LO=zeros(1,ES);         
B_battery_OSC=B_battery;
B_battery_OSC=B_battery;
B_battery_1=B_battery;
B_battery_CLOULD=B_battery;
B_battery_CL_LO=B_battery;
B_battery_DTG=B_battery;
B_battery_CTG=B_battery;
B_battery_ETG=B_battery;
bit_1re=[];
reward_1re=[];
deadline_1re=[];
p_1re=[];
bit_2re=[];
reward_2re=[];
deadline_2re=[];
p_2re=[];
bit_3re=[];
reward_3re=[];
deadline_3re=[];
p_3re=[];
bit_4re=[];
reward_4re=[];
deadline_4re=[];
p_4re=[];
bit_5re=[];
reward_5re=[];
deadline_5re=[];
p_5re=[];
bit_6re=[];
reward_6re=[];
deadline_6re=[];
p_6re=[];
        
    
%TASK t时刻任务总数-
T = 1;
cnt = 2;