function [y] = jisuan(t1,k,slot,Eop,yz,Queue_1B_task_num,Queue_1B_task_p,Queue_1B_task_bit,B_battery_MO_1ES,Queue_B_ES1)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
E=t1^3*k*slot;%energy
h=1;
C=0;
while h<=Queue_1B_task_num
    if t1*slot/Queue_1B_task_num/Queue_1B_task_p(h)<Queue_1B_task_bit(h)
        C=C+t1*slot/Queue_1B_task_num/Queue_1B_task_p(h);%queue bit
    else
        C=C+Queue_1B_task_bit(h);
    end
    h=h+1;
end
y=2*(Eop-B_battery_MO_1ES+yz)*E+E*E-2*Queue_B_ES1*C+C*C;
end

