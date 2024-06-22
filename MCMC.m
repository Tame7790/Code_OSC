function [A4,B4,power_now] = MCMC(A3,B3,C3,D3)
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
        for i=2:1+number_task%1 to task
            for j=1:n
                if p(i)>p(j)+a(j,i)
                    p(i)=p(j)+a(j,i);
                    s(i)=j;
                    pd=0;
                end
            end
        end
        
        for i=2+number_task:n-1%task to cloud & es
            for j=1
                if p(i)>p(j)+a(j,i)
                    p(i)=p(j)+a(j,i);
                    s(i)=j;
                    pd=0;
                end
            end
            for j=2:1+number_task
                from_es=0;
                from_es1=0;
                from_es2=0;
                from_es3=0;
                from_es4=0;
                from_es5=0;
                from_es6=0;
                if power_now(2)>=power_1(j,i)&&2<=j&&j<=1+number_task_ES1
                    from_es1=1;
                else
                    from_es1=0;
                    if power_now(3)>=power_1(j,i)&&1+number_task_ES1<j&&j<=1+number_task_ES2+number_task_ES1
                        from_es2=1;
                    else
                        from_es2=0;
                        if power_now(4)>=power_1(j,i)&&1+number_task_ES2+number_task_ES1<j&&j<=1+number_task_ES2+number_task_ES1+number_task_ES3
                            from_es3=1;
                        else
                            from_es3=0;
                            if power_now(5)>=power_1(j,i)&&1+number_task_ES2+number_task_ES1+number_task_ES3<j&&j<=1+number_task_ES2+number_task_ES1+number_task_ES3+number_task_ES4
                                from_es4=1;
                            else
                                from_es4=0;
                                if power_now(6)>=power_1(j,i)&&1+number_task_ES2+number_task_ES1+number_task_ES3+number_task_ES4<j&&j<=1+number_task_ES2+number_task_ES1+number_task_ES3+number_task_ES4+number_task_ES5
                                    from_es5=1;
                                else
                                    from_es5=0;
                                    if power_now(7)>=power_1(j,i)&&1+number_task_ES2+number_task_ES1+number_task_ES3+number_task_ES4+number_task_ES5<j&&j<=1+number_task
                                        from_es6=1;
                                    else
                                        from_es6=0;
                                    end
                                end
                            end
                        end
                    end
                end
                %disp('for---==-=-=-=');
                %disp([j, power_1(j,i), from_es1, from_es2, from_es3, from_es4, from_es5, from_es6]);
                %disp(1+number_task_ES1<j&&j<=1+number_task_ES2+number_task_ES1);
                from_es=(from_es1|from_es2|from_es3|from_es4|from_es5|from_es6);
                %                 disp(from_es);
                if p(i)>p(j)+a(j,i)&&power_now(i-1-number_task)>=power_2(j,i)&&from_es==1% i : j 2 i
                    p(i)=p(j)+a(j,i);
                    s(i)=j;
                    pd=0;
                end
            end
            
        end
        for j=2+number_task:n
            if p(i)>p(j)+a(j,i)
                p(i)=p(j)+a(j,i);
                s(i)=j;
                pd=0;
            end
        end
        
        
        for i=n
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
    end %that's not going to happen 主循环break
    
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
            if 2<=s(t)&&s(t)<=1+number_task&& 2+number_task<t&&t<=n-1
                power_now(t-1-number_task)=power_now(t-1-number_task)-power_2(s(t),t);
                if 2<=s(t)&&s(t)<=1+number_task_ES1
                    power_now(2)=power_now(2)-power_1(s(t),t);
                elseif 1+number_task_ES1<s(t)&&s(t)<=1+number_task_ES2+number_task_ES1
                    power_now(3)=power_now(3)-power_1(s(t),t);
                elseif 1+number_task_ES2+number_task_ES1<s(t)&&s(t)<=1+number_task_ES2+number_task_ES1+number_task_ES3
                    power_now(4)=power_now(4)-power_1(s(t),t);
                elseif 1+number_task_ES2+number_task_ES1+number_task_ES3<s(t)&&s(t)<=1+number_task_ES2+number_task_ES1+number_task_ES3+number_task_ES4
                    power_now(5)=power_now(5)-power_1(s(t),t);
                elseif 1+number_task_ES2+number_task_ES1+number_task_ES3+number_task_ES4<s(t)&&s(t)<=1+number_task_ES2+number_task_ES1+number_task_ES3+number_task_ES4+number_task_ES5
                    power_now(6)=power_now(6)-power_1(s(t),t);
                elseif 1+number_task_ES2+number_task_ES1+number_task_ES3+number_task_ES4+number_task_ES5<s(t)&&s(t)<=1+number_task
                    power_now(7)=power_now(7)-power_1(s(t),t);
                end
            end
        elseif aa(s(t),t)<0
            f(t,s(t))=f(t,s(t))-dvt; %backward arc
            if 2<=t&&t<=1+number_task&& 2+number_task<=s(t)&&s(t)<=n-1
                power_now(s(t)-1-number_task)=power_now(s(t)-1-number_task)+power_2(t,s(t));
                if 2<=t&&t<=1+number_task_ES1
                    power_now(2)=power_now(2)+power_1(t,s(t));
                elseif 1+number_task_ES1<t&&t<=1+number_task_ES2+number_task_ES1
                    power_now(3)=power_now(3)+power_1(t,s(t));
                elseif 1+number_task_ES2+number_task_ES1<t&&t<=1+number_task_ES2+number_task_ES1+number_task_ES3
                    power_now(4)=power_now(4)+power_1(t,s(t));
                elseif 1+number_task_ES2+number_task_ES1+number_task_ES3<t&&t<=1+number_task_ES2+number_task_ES1+number_task_ES3+number_task_ES4
                    power_now(5)=power_now(5)+power_1(t,s(t));
                elseif 1+number_task_ES2+number_task_ES1+number_task_ES3+number_task_ES4<t&&t<=1+number_task_ES2+number_task_ES1+number_task_ES3+number_task_ES4+number_task_ES5
                    power_now(6)=power_now(6)+power_1(t,s(t));
                elseif 1+number_task_ES2+number_task_ES1+number_task_ES3+number_task_ES4+number_task_ES5<t&&t<=1+number_task
                    power_now(7)=power_now(7)+power_1(t,s(t));
                end
            end
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




