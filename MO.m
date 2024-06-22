function [B8,POWER_1,POWER_2] = MO(targetES ,A0,B,TASK,number_123456)
%A8:COST B8:VOLUME
Atarget=A0{targetES};
TASKnumber=Atarget{1};
TASKdeadline=Atarget{2};
TASKbit=Atarget{3};
TASKp=Atarget{4};
MAXfrequency=Atarget{5};
MAXtranpower=Atarget{6};
TASK1number=number_123456{1};
TASK2number=number_123456{2};
TASK3number=number_123456{3};
TASK4number=number_123456{4};
TASK5number=number_123456{5};
TASK6number=number_123456{6};

Btran=B;
[m,n]=size(A0);
B8=ones(TASKnumber,3+6+TASK)*inf;
POWER_1=ones(TASKnumber,3+6+TASK)*inf;
POWER_2=ones(TASKnumber,3+6+TASK)*inf;
p_tran=zeros(1,TASKnumber);
Tbackhaul=0.002;
BO=10^7;%带宽
NOIZE=-10^(-6);%噪声干扰
Eop=1;
V=1;%ADJUST weights
%% exponential distribution with mean parameter MU 信道增益
distance_clould=[60,70,90,80,80,50];
distance_loss=[exprnd(1),exprnd(1),exprnd(1),exprnd(1),exprnd(1),exprnd(1)];
h_all=(-40)*distance_loss.*((1./distance_clould).^4);

% r=(BO*log2(1+P(p,q,h)*H(p,q)^2/NO));%offload time
% r=50;
k=0.5*10^(-22);

TASKCPUcycle=TASKbit.*TASKp;

p2=1;%taskp2
while p2<=TASKnumber
    
    h=h_all(targetES);
    
    %% ES LOCAL COST
    if TASKCPUcycle(p2)/MAXfrequency<=TASKdeadline(p2)
        TASKfrequency(p2)=TASKCPUcycle(p2)/TASKdeadline(p2);
        
        Plocal=k*TASKfrequency(p2)*TASKfrequency(p2)*TASKCPUcycle(p2);
        if Plocal<=Btran(targetES+1)
            B8(p2,1+TASK+1+targetES)=Plocal;
            POWER_2(p2,1+TASK+1+targetES)=Plocal;
            POWER_1(p2,1+TASK+1+targetES)=0;
        else
            B8(p2,1+TASK+1+targetES)=inf;
            POWER_1(p2,1+TASK+1+targetES)=inf;
            POWER_2(p2,1+TASK+1+targetES)=inf;
        end
    else
        B8(p2,1+TASK+1+targetES)=inf;
        POWER_1(p2,1+TASK+1+targetES)=inf;
        POWER_2(p2,1+TASK+1+targetES)=inf;
    end
    
    %% CLOULD COST
    p_tran(p2)=NOIZE/(h*(2^(TASKbit(p2)/(TASKdeadline(p2)-Tbackhaul)/BO)-1));
    if p_tran(p2)<=MAXtranpower&&p_tran(p2)*(TASKdeadline(p2)-Tbackhaul)<=Btran(targetES+1)&&TASKdeadline(p2)>Tbackhaul
        POWER_1(p2,1+TASK+1)=p_tran(p2)*(TASKdeadline(p2)-Tbackhaul);
        POWER_2(p2,1+TASK+1)=0;
        B8(p2,1+TASK+1)=POWER_1(p2,1+TASK+1)+0.0000002*TASKbit(p2);%%%%clould prize:
    else
        B8(p2,1+TASK+1)=inf;
        POWER_1(p2,1+TASK+1)=inf;
        POWER_2(p2,1+TASK+1)=inf;
    end
    
    %% offload targetES TO ES p3
    p3=1;
    while p3<=6
        if p3~=targetES
            A1target=A0{p3};%offload to ES p3
            MAX1frequency=A1target{5};
            a=0;
            
            %% exponential distribution with mean parameter MU 信道增益
            distance_ES=[0,45,60,inf,40,55;
                45,0,70,30,18,35;
                60,70,0,30,40,46;
                inf,30,30,0,42,25;
                40,18,40,42,0,39;
                55,35,46,25,39,0];
            distance_loss_ES=exprnd(1);
            distance_ES=distance_ES(targetES,p3);
            
            if distance_ES==inf
                B8(p2,1+TASK+1+p3)=inf;
                POWER_1(p2,1+TASK+1+p3)=inf;
                POWER_2(p2,1+TASK+1+p3)=inf;
            else
                h_all_ES=(-40)*distance_loss_ES*((1/distance_ES)^4);
                if sqrtm(Btran(p3+1) /(k*TASKCPUcycle(p2)))<=TASKCPUcycle(p2)/TASKdeadline(p2)||MAX1frequency<=TASKCPUcycle(p2)/TASKdeadline(p2)
                    B8(p2,1+TASK+1+p3)=inf;
                    POWER_1(p2,1+TASK+1+p3)=inf;
                    POWER_2(p2,1+TASK+1+p3)=inf;
                else
                    a=NOIZE/(h_all_ES*(2^(TASKbit(p2)/TASKdeadline(p2)/BO)-1));
                    if a>MAXtranpower||a*TASKdeadline(p2)>Btran(targetES+1)
                        B8(p2,1+TASK+1+p3)=inf;
                        POWER_1(p2,1+TASK+1+p3)=inf;
                        POWER_2(p2,1+TASK+1+p3)=inf;
                    else
                        t1 = 0:0.00001:TASKdeadline(p2);
                        t2 = 0:0.00001:TASKdeadline(p2);
                        t1_grid = meshgrid(t1);
                        t2_grid = transpose(meshgrid(t2));
                        %% 算法求出所有x、y下的函数值
                        % 假设算法y=t1^2+t2^2，求y最小值与位置
                        y = ones(size(t1_grid))*inf;
                        power1 = ones(size(t1_grid))*inf;
                        power2= ones(size(t1_grid))*inf;
                        [size1, size2] = size(t1_grid);
                        for i1 = 1:size1
                            for i2 = 1:size2
                                if t1_grid(i1, i2) + t2_grid(i1, i2) == TASKdeadline(p2)
                                    [y(i1, i2),power1(i1, i2),power2(i1, i2) ] =offload(t1(i2),t2(i1),Btran(targetES+1),Btran(p3+1),MAX1frequency,MAXtranpower,TASKCPUcycle(p2),TASKbit(p2),h_all_ES);
                                end
                            end
                        end
                        
                        % 最小值与位置
                        [min_value,min_y]=min(min(y));       %%得到的是整个矩阵最小值的值和纵坐标
                        [min_value,min_x]=min(y(:,min_y));   %%得到的是整个矩阵最小值min_value的值和横坐标
                        %y(max_y,max_x)                  %%检查是否与m一致
                        B8(p2,1+TASK+1+p3)=min_value;
                        POWER_1(p2,1+TASK+1+p3)=power1(min_x,min_y);
                        POWER_2(p2,1+TASK+1+p3)=power2(min_x,min_y);
                    end
                end
            end
        end
        p3=p3+1;
    end
    p2=p2+1;
end
    
    
    % A8 volume
    % B8 cost
end

