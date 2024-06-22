function [f,power_now] = CLOULD_ONLY(A3,B3,C3,D3)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
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
f=zeros(3+6+number_task);

task_n=1;
while task_n<=number_task
    if task_n<=number_task_ES1 && power_1(task_n+1,2+number_task)<=power_now(2)
        f(task_n+1,2+number_task)=1;
        f(1,task_n+1)=1;
        power_now(2)=power_now(2)-power_1(task_n+1,2+number_task);
    end
    if task_n<=number_task_ES1+number_task_ES2 && power_1(task_n+1,2+number_task)<=power_now(3)
        f(task_n+1,2+number_task)=1;
        f(1,task_n+1)=1;
        power_now(3)=power_now(3)-power_1(task_n+1,2+number_task);
    end
    if task_n<=number_task_ES1+number_task_ES2+number_task_ES3 && power_1(task_n+1,2+number_task)<=power_now(4)
        f(task_n+1,2+number_task)=1;
        f(1,task_n+1)=1;
        power_now(4)=power_now(4)-power_1(task_n+1,2+number_task);
    end
    if task_n<=number_task_ES1+number_task_ES2+number_task_ES3+number_task_ES4 && power_1(task_n+1,2+number_task)<=power_now(5)
        f(task_n+1,2+number_task)=1;
        f(1,task_n+1)=1;
        power_now(5)=power_now(5)-power_1(task_n+1,2+number_task);
    end
    if task_n<=number_task_ES1+number_task_ES2+number_task_ES3+number_task_ES4+number_task_ES5 && power_1(task_n+1,2+number_task)<=power_now(6)
        f(task_n+1,2+number_task)=1;
        f(1,task_n+1)=1;
        power_now(6)=power_now(6)-power_1(task_n+1,2+number_task);
    end
    if task_n<=number_task_ES1+number_task_ES2+number_task_ES3+number_task_ES4+number_task_ES5+number_task_ES6 && power_1(task_n+1,2+number_task)<=power_now(7)
        f(task_n+1,2+number_task)=1;
        f(1,task_n+1)=1;
        power_now(7)=power_now(7)-power_1(task_n+1,2+number_task);
    end
    task_n=task_n+1;
end
end

