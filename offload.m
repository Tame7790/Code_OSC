function [a9,p1,p2] =offload(t1,t2,Btran_target,Btran_to,MAX1frequency,MAXtranpower,TASKCPUcycle,TASKbit,h_all_ES)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
%%MAX0frequency:目标ES最高可提供的计算频率,r本地最高传输速率
k=0.5*10^(-22);
BO=10^7;%带宽
NO=-10^(-6);%噪声干扰
h=h_all_ES;

p_tran=NO/h*(2^(TASKbit/t1/BO)-1);

if p_tran<=MAXtranpower&&p_tran*t1<=Btran_target&&t1~=0
    p1=p_tran*t1;
else
    p1=inf;
end

if TASKCPUcycle/MAX1frequency<=t2&&t2~=0
    TASKfrequency=TASKCPUcycle/t2;
    Plocal=k*TASKfrequency*TASKfrequency*TASKCPUcycle;
    if Plocal<=Btran_to
        p2=Plocal;
    else
        p2=inf;
    end
else
    p2=inf;
end


a9 = p1+p2;
end

