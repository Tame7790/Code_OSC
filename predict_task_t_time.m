function [t_task_es] = predict_task_t_time(k,slot,Eop,yz,MAXfrequency,Btran_MO_allpp,Queue_B_mopp,Queue_N_mopp,TASK_bit_all_mo,TASK_p_all_mo,B_battery_MO_ES_MIN,B_battery_MO_ES_MAX)
MAX1frequency=MAXfrequency(1);
MAX2frequency=MAXfrequency(2);
MAX3frequency=MAXfrequency(3);
MAX4frequency=MAXfrequency(4);
MAX5frequency=MAXfrequency(5);
Btran_MO1_allpp=Btran_MO_allpp{1};
Btran_MO2_allpp=Btran_MO_allpp{2};
Btran_MO3_allpp=Btran_MO_allpp{3};
Btran_MO4_allpp=Btran_MO_allpp{4};
Btran_MO5_allpp=Btran_MO_allpp{5};
Queue_B_mo1pp=Queue_B_mopp{1};
Queue_B_mo2pp=Queue_B_mopp{2};
Queue_B_mo3pp=Queue_B_mopp{3};
Queue_B_mo4pp=Queue_B_mopp{4};
Queue_B_mo5pp=Queue_B_mopp{5};
Queue_N_mo1pp=Queue_N_mopp{1};
Queue_N_mo2pp=Queue_N_mopp{2};
Queue_N_mo3pp=Queue_N_mopp{3};
Queue_N_mo4pp=Queue_N_mopp{4};
Queue_N_mo5pp=Queue_N_mopp{5};
B_battery_MO_ES1_MIN=B_battery_MO_ES_MIN(1);
B_battery_MO_ES2_MIN=B_battery_MO_ES_MIN(2);
B_battery_MO_ES3_MIN=B_battery_MO_ES_MIN(3);
B_battery_MO_ES4_MIN=B_battery_MO_ES_MIN(4);
B_battery_MO_ES5_MIN=B_battery_MO_ES_MIN(5);
B_battery_MO_ES1_MAX=B_battery_MO_ES_MAX(1);
B_battery_MO_ES2_MAX=B_battery_MO_ES_MAX(2);
B_battery_MO_ES3_MAX=B_battery_MO_ES_MAX(3);
B_battery_MO_ES4_MAX=B_battery_MO_ES_MAX(4);
B_battery_MO_ES5_MAX=B_battery_MO_ES_MAX(5);
number=size(TASK_bit_all_mo,2);
min_p=min(min(TASK_p_all_mo));
max_bit=max(max(TASK_bit_all_mo));
t_task_es=zeros(number,5);
a=1;
tt=1;
f=zeros(10,5);
while tt<=10
%     if Queue_N_mo1pp(tt)==0
%         Queue_B_task_p_mo1=min_p;
%         Queue_B_task_bit_mo1=max_bit;
%     else
%         Queue_B_task_p_mo1=min_p*ones(1,Queue_N_mo1pp(tt));
%         Queue_B_task_bit_mo1=max_bit*ones(1,Queue_N_mo1pp(tt));
%     end
%     [~,frequency_ES1_mo] = frequency(k,slot,Eop,yz,MAX1frequency,Queue_B_mo1pp(tt),Queue_N_mo1pp(tt),Queue_B_task_p_mo1,Queue_B_task_bit_mo1,Btran_MO1_allpp(tt),B_battery_MO_ES1_MIN,B_battery_MO_ES1_MAX,Btran_MO1_allpp(tt));
%     
%     if Queue_N_mo2pp(tt)==0
%         Queue_B_task_p_mo2=min_p;
%         Queue_B_task_bit_mo2=max_bit;
%     else
%         Queue_B_task_p_mo2=min_p*ones(1,Queue_N_mo2pp(tt));
%         Queue_B_task_bit_mo2=max_bit*ones(1,Queue_N_mo2pp(tt));
%     end
%     [~,frequency_ES2_mo] = frequency(k,slot,Eop,yz,MAX2frequency,Queue_B_mo2pp(tt),Queue_N_mo2pp(tt),Queue_B_task_p_mo2,Queue_B_task_bit_mo2,Btran_MO2_allpp(tt),B_battery_MO_ES2_MIN,B_battery_MO_ES2_MAX,Btran_MO2_allpp(tt));
%     
%     if Queue_N_mo3pp(tt)==0
%         Queue_B_task_p_mo3=min_p;
%         Queue_B_task_bit_mo3=max_bit;
%     else
%         Queue_B_task_p_mo3=min_p*ones(1,Queue_N_mo3pp(tt));
%         Queue_B_task_bit_mo3=max_bit*ones(1,Queue_N_mo3pp(tt));
%     end
%     [~,frequency_ES3_mo] = frequency(k,slot,Eop,yz,MAX3frequency,Queue_B_mo3pp(tt),Queue_N_mo3pp(tt),Queue_B_task_p_mo3,Queue_B_task_bit_mo3,Btran_MO3_allpp(tt),B_battery_MO_ES3_MIN,B_battery_MO_ES3_MAX,Btran_MO3_allpp(tt));
%     
%     if Queue_N_mo4pp(tt)==0
%         Queue_B_task_p_mo4=min_p;
%         Queue_B_task_bit_mo4=max_bit;
%     else
%         Queue_B_task_p_mo4=min_p*ones(1,Queue_N_mo4pp(tt));
%         Queue_B_task_bit_mo4=max_bit*ones(1,Queue_N_mo4pp(tt));
%     end
%     [~,frequency_ES4_mo] = frequency(k,slot,Eop,yz,MAX4frequency,Queue_B_mo4pp(tt),Queue_N_mo4pp(tt),Queue_B_task_p_mo4,Queue_B_task_bit_mo4,Btran_MO4_allpp(tt),B_battery_MO_ES4_MIN,B_battery_MO_ES4_MAX,Btran_MO4_allpp(tt));
%     
%     if Queue_N_mo5pp(tt)==0
%         Queue_B_task_p_mo5=min_p;
%         Queue_B_task_bit_mo5=max_bit;
%     else
%         Queue_B_task_p_mo5=min_p*ones(1,Queue_N_mo5pp(tt));
%         Queue_B_task_bit_mo5=max_bit*ones(1,Queue_N_mo5pp(tt));
%     end
%     [~,frequency_ES5_mo] = frequency(k,slot,Eop,yz,MAX5frequency,Queue_B_mo5pp(tt),Queue_N_mo5pp(tt),Queue_B_task_p_mo5,Queue_B_task_bit_mo5,Btran_MO5_allpp(tt),B_battery_MO_ES5_MIN,B_battery_MO_ES5_MAX,Btran_MO5_allpp(tt));
%     
    if Btran_MO1_allpp(tt)<=B_battery_MO_ES1_MIN
        frequency_ES1_mo=(Btran_MO1_allpp(tt)/k/slot)^(1/3);
    else
        frequency_ES1_mo=(B_battery_MO_ES1_MIN/k/slot)^(1/3);
    end
    if Btran_MO2_allpp(tt)<=B_battery_MO_ES2_MIN
        frequency_ES2_mo=(Btran_MO2_allpp(tt)/k/slot)^(1/3);
    else
        frequency_ES2_mo=(B_battery_MO_ES2_MIN/k/slot)^(1/3);
    end
    if Btran_MO3_allpp(tt)<=B_battery_MO_ES3_MIN
        frequency_ES3_mo=(Btran_MO3_allpp(tt)/k/slot)^(1/3);
    else
        frequency_ES3_mo=(B_battery_MO_ES3_MIN/k/slot)^(1/3);
    end
    if Btran_MO4_allpp(tt)<=B_battery_MO_ES4_MIN
        frequency_ES4_mo=(Btran_MO4_allpp(tt)/k/slot)^(1/3);
    else
        frequency_ES4_mo=(B_battery_MO_ES4_MIN/k/slot)^(1/3);
    end
    if Btran_MO5_allpp(tt)<=B_battery_MO_ES5_MIN
        frequency_ES5_mo=(Btran_MO5_allpp(tt)/k/slot)^(1/3);
    else
        frequency_ES5_mo=(B_battery_MO_ES5_MIN/k/slot)^(1/3);
    end
    f(tt,1)=frequency_ES1_mo;
    f(tt,2)=frequency_ES2_mo;
    f(tt,3)=frequency_ES3_mo;
    f(tt,4)=frequency_ES4_mo;
    f(tt,5)=frequency_ES5_mo;
    tt=tt+1;
end
while a<=number
    t=1;
    a_bit1=TASK_bit_all_mo(a);
    a_bit2=TASK_bit_all_mo(a);
    a_bit3=TASK_bit_all_mo(a);
    a_bit4=TASK_bit_all_mo(a);
    a_bit5=TASK_bit_all_mo(a);
    while t<=10
        
        if a_bit1>0
            if a_bit1*TASK_p_all_mo(a)-f(t,1)*slot>0
                t_task_es(a,1)=t_task_es(a,1)+slot;
                a_bit1=a_bit1-f(t,1)*slot/TASK_p_all_mo(a);
            else
                t_task_es(a,1)=t_task_es(a,1)+a_bit1*TASK_p_all_mo(a)/f(t,1);
                a_bit1=0;
            end
        end
        
        
        if a_bit2>0
            if a_bit2*TASK_p_all_mo(a)-f(t,2)*slot>0
                t_task_es(a,2)=t_task_es(a,2)+slot;
                a_bit2=a_bit2-f(t,2)*slot/TASK_p_all_mo(a);
            else
                t_task_es(a,2)=t_task_es(a,2)+a_bit2*TASK_p_all_mo(a)/f(t,2);
                a_bit2=0;
            end
        end
        
        
        if a_bit3>0
            if a_bit3*TASK_p_all_mo(a)-f(t,3)*slot>0
                t_task_es(a,3)=t_task_es(a,3)+slot;
                a_bit3=a_bit3-f(t,3)*slot/TASK_p_all_mo(a);
            else
                t_task_es(a,3)=t_task_es(a,3)+a_bit3*TASK_p_all_mo(a)/f(t,3);
                a_bit3=0;
            end
        end
        
        
        if a_bit4>0
            if a_bit4*TASK_p_all_mo(a)-f(t,4)*slot>0
                t_task_es(a,4)=t_task_es(a,4)+slot;
                a_bit4=a_bit4-f(t,4)*slot/TASK_p_all_mo(a);
            else
                t_task_es(a,4)=t_task_es(a,4)+a_bit4*TASK_p_all_mo(a)/f(t,4);
                a_bit4=0;
            end
        end
        
        
        if a_bit5>0
            if a_bit5*TASK_p_all_mo(a)-f(t,5)*slot>0
                t_task_es(a,5)=t_task_es(a,5)+slot;
                a_bit5=a_bit5-f(t,5)*slot/TASK_p_all_mo(a);
            else
                t_task_es(a,5)=t_task_es(a,5)+a_bit5*TASK_p_all_mo(a)/f(t,5);
                a_bit5=0;
            end
        end
        
        t=t+1;
    end
    
    
    a=a+1;
end
end

