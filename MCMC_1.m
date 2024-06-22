function [A4,B4,power_now] = MCMC_1(A3,B3,C3,D3)
%C3:power_1,power_2,power_now
%  D3:number of tasks:1,2,3,4,5,6

V =A3; %volume
C =B3; %cost
power_1=C3{1};
power_2=C3{2};
power_now=C3{3};
number_task=D3{7};
number_task_ES1=D3{1};
number_task_ES2=D3{2};
number_task_ES3=D3{3};
number_task_ES4=D3{4};
number_task_ES5=D3{5};
number_task_ES6=D3{6};
n=size(V,2);%返回V的列数

%%定义初值
wf=0;wf0=Inf; %wf:max flow, wf0:predetermined max flow
f = zeros(n,n); %initial flowpower_now(j-1-number_task)>=p
while 1
    %% weighted network构建cost残差网络
    a = inf*(ones(n,n)-eye(n,n)); %directed weighted graph
    aa= inf*(ones(n,n)-eye(n,n));
    for i=1:n
        for j=1:n
            if V(i,j)>0&&f(i,j)==0
                a(i,j)=C(i,j);
                aa(i,j)=1;
            elseif V(i,j)>0&&f(i,j)==V(i,j)
                a(j,i)=-C(i,j);
                aa(j,i)=-1;
            elseif V(i,j)>0
                a(i,j)=C(i,j); aa(i,j)=1;
                a(j,i)=-C(i,j); aa(j,i)=-1;
            end
        end
    end
    
   %% find the shortest path using Bellman Ford
    p = inf * ones(1,n); %initial visited vector
    p(1) = 0;
    s = 1:n;
    s(1) = 0;
    for k=1:n
        pd=1; %按照顺序find the shortest path from vs to vt
        for i=2:n
            for j=1:n
                if p(i)>p(j)+a(j,i)
                    p(i)=p(j)+a(j,i);
                    s(i)=j;
                    pd=0;
                end
            end
        end
        if pd
            break;
        end
    end
    if p(n)==Inf
        disp('completed');
        break;
    end %that's not going to happen
    
    %% adjustment
    k=n;dvt=Inf;t=n; %dvt:the amount of adjustment
    while 1 %calculate残差网络后flow调整
        if aa(s(t),t)>0
            dvtt=V(s(t),t)-f(s(t),t); %forward arc
        elseif aa(s(t),t)<0
            dvtt=f(t,s(t)); %backward arc
        end
        if dvt>dvtt%find the smallest flow of the zengguang path
            dvt=dvtt;
        end
        if s(t)==1
            break;
        end %when the label of t is vs, end
        t=s(t);
    end
    pd=0;
    if wf+dvt>=wf0 %the max flow greater than or equal to the predetermined flow
        dvt=wf0-wf;
        pd=1;
    end
    t=n;
    while 1 %adjust
        if aa(s(t),t)>0
            f(s(t),t)=f(s(t),t)+dvt; %forward arc
        elseif aa(s(t),t)<0
            f(t,s(t))=f(t,s(t))-dvt; %backward arc
        end
        if s(t)==1
            break;
        end %when the label of t is vs, end
        t=s(t);
    end
    if pd
        break;
    end %if max value reach the predetermined flow
end
power_1(power_1 == inf)=0;
power_2(power_2 == inf)=0;

power_now_inf=[inf 0 0 0 0 0 0];
num_es=1;
while 1<=num_es && num_es<=6
    if num_es==1
        power_now_inf(2)=power_now(2)-sum(f(:,3+number_task).*power_2(:,3+number_task));
        power_now_inf(2)=power_now(2)-sum(sum(f(2:1+number_task_ES1,2+number_task:8+number_task).*power_1(2:1+number_task_ES1,2+number_task:8+number_task)));
    end
    if num_es==2
        power_now_inf(3)=power_now(3)-sum(f(:,4+number_task).*power_2(:,4+number_task));
        power_now_inf(3)=power_now(3)-sum(sum(f(2+number_task_ES1:1+number_task_ES1+number_task_ES2,2+number_task:8+number_task).*power_1(2+number_task_ES1:1+number_task_ES1+number_task_ES2,2+number_task:8+number_task)));
    end
    if num_es==3
        power_now_inf(4)=power_now(4)-sum(f(:,5+number_task).*power_2(:,5+number_task));
        power_now_inf(4)=power_now(4)-sum(sum(f(2+number_task_ES1+number_task_ES2:1+number_task_ES1+number_task_ES2+number_task_ES3,2+number_task:8+number_task).*power_1(2+number_task_ES1+number_task_ES2:1+number_task_ES1+number_task_ES2+number_task_ES3,2+number_task:8+number_task)));
    end
    if num_es==4
        power_now_inf(5)=power_now(5)-sum(f(:,6+number_task).*power_2(:,6+number_task));
        power_now_inf(5)=power_now(5)-sum(sum(f(2+number_task_ES1+number_task_ES2+number_task_ES3:1+number_task_ES1+number_task_ES2+number_task_ES3+number_task_ES4,2+number_task:8+number_task).*power_1(2+number_task_ES1+number_task_ES2+number_task_ES3:1+number_task_ES1+number_task_ES2+number_task_ES3+number_task_ES4,2+number_task:8+number_task)));
    end
    if num_es==5
        power_now_inf(6)=power_now(6)-sum(f(:,7+number_task).*power_2(:,7+number_task));
        power_now_inf(6)=power_now(6)-sum(sum(f(2+number_task_ES1+number_task_ES2+number_task_ES3+number_task_ES4:1+number_task_ES1+number_task_ES2+number_task_ES3+number_task_ES4+number_task_ES5,2+number_task:8+number_task).*power_1(2+number_task_ES1+number_task_ES2+number_task_ES3+number_task_ES4:1+number_task_ES1+number_task_ES2+number_task_ES3+number_task_ES4+number_task_ES5,2+number_task:8+number_task)));
    end
    if num_es==6
        power_now_inf(7)=power_now(7)-sum(f(:,8+number_task).*power_2(:,8+number_task));
        power_now_inf(7)=power_now(7)-sum(sum(f(2+number_task_ES1+number_task_ES2+number_task_ES3+number_task_ES4+number_task_ES5:1+number_task_ES1+number_task_ES2+number_task_ES3+number_task_ES4+number_task_ES5+number_task_ES6,2+number_task:8+number_task).*power_1(2+number_task_ES1+number_task_ES2+number_task_ES3+number_task_ES4+number_task_ES5:1+number_task_ES1+number_task_ES2+number_task_ES3+number_task_ES4+number_task_ES5+number_task_ES6,2+number_task:8+number_task)));
    end
    num_es=num_es+1;
end
while power_now_inf(2)<=0||power_now_inf(3)<=0||power_now_inf(4)<=0||power_now_inf(5)<=0||power_now_inf(6)<=0||power_now_inf(7)<=0
    reward_mcmc=f(1,2:1+number_task).*C(1,2:1+number_task);
    reward_max=max(reward_mcmc(reward_mcmc<0));
    [x y]=find(reward_mcmc==reward_max);
    f(1+y,:)=zeros(1,n);
    f(1,1+y)=0;
    num_es=1;
    while 1<=num_es<=6
        if num_es==1
            power_now_inf(2)=power_now(2)-sum(f(:,3+number_task).*power_2(:,3+number_task));
            power_now_inf(2)=power_now(2)-sum(sum(f(2:1+number_task_ES1,2+number_task:8+number_task).*power_1(2:1+number_task_ES1,2+number_task:8+number_task)));
        end
        if num_es==2
            power_now_inf(3)=power_now(3)-sum(f(:,4+number_task).*power_2(:,4+number_task));
            power_now_inf(3)=power_now(3)-sum(sum(f(2+number_task_ES1:1+number_task_ES1+number_task_ES2,2+number_task:8+number_task).*power_1(2+number_task_ES1:1+number_task_ES1+number_task_ES2,2+number_task:8+number_task)));
        end
        if num_es==3
            power_now_inf(4)=power_now(4)-sum(f(:,5+number_task).*power_2(:,5+number_task));
            power_now_inf(4)=power_now(4)-sum(sum(f(2+number_task_ES1+number_task_ES2:1+number_task_ES1+number_task_ES2+number_task_ES3,2+number_task:8+number_task).*power_1(2+number_task_ES1+number_task_ES2:1+number_task_ES1+number_task_ES2+number_task_ES3,2+number_task:8+number_task)));
        end
        if num_es==4
            power_now_inf(5)=power_now(5)-sum(f(:,6+number_task).*power_2(:,6+number_task));
            power_now_inf(5)=power_now(5)-sum(sum(f(2+number_task_ES1+number_task_ES2+number_task_ES3:1+number_task_ES1+number_task_ES2+number_task_ES3+number_task_ES4,2+number_task:8+number_task).*power_1(2+number_task_ES1+number_task_ES2+number_task_ES3:1+number_task_ES1+number_task_ES2+number_task_ES3+number_task_ES4,2+number_task:8+number_task)));
        end
        if num_es==5
            power_now_inf(6)=power_now(6)-sum(f(:,7+number_task).*power_2(:,7+number_task));
            power_now_inf(6)=power_now(6)-sum(sum(f(2+number_task_ES1+number_task_ES2+number_task_ES3+number_task_ES4:1+number_task_ES1+number_task_ES2+number_task_ES3+number_task_ES4+number_task_ES5,2+number_task:8+number_task).*power_1(2+number_task_ES1+number_task_ES2+number_task_ES3+number_task_ES4:1+number_task_ES1+number_task_ES2+number_task_ES3+number_task_ES4+number_task_ES5,2+number_task:8+number_task)));
        end
        if num_es==6
            power_now_inf(7)=power_now(7)-sum(f(:,8+number_task).*power_2(:,8+number_task));
            power_now_inf(7)=power_now(7)-sum(sum(f(2+number_task_ES1+number_task_ES2+number_task_ES3+number_task_ES4+number_task_ES5:1+number_task_ES1+number_task_ES2+number_task_ES3+number_task_ES4+number_task_ES5+number_task_ES6,2+number_task:8+number_task).*power_1(2+number_task_ES1+number_task_ES2+number_task_ES3+number_task_ES4+number_task_ES5:1+number_task_ES1+number_task_ES2+number_task_ES3+number_task_ES4+number_task_ES5+number_task_ES6,2+number_task:8+number_task)));
        end
        num_es=num_es+1;
    end
end
power_now(1,2:7)=power_now_inf(1,2:7);
%%
wf = sum(f(1,:));
zwf = sum(sum(C.*f)); %calculate the minimum cost

A4=f; %flow matrix
B4={wf,zwf }; %the maximum flow value+the minimum flow value
% f %flow matrix
% wf %the maximum flow value
% zwf %the minimum flow value
%%1.构建残差网络；2.寻找cost最小路径；3.调整流量f和剩余容量c；

end