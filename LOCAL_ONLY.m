function [A4,B4,power_now] = LOCAL_ONLY(A3,B3,C3,D3)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
%C3:power_1,power_2,power_now
%  D3:number of tasks:1,2,3,4,5,6

ALLOW0computate=A3; %volume
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

reward=zeros(1,number_task);
f=zeros(1,number_task);

task=1;
while task<=number_task
    reward(task)=-C(1,1+task);
    task=1+task;
end
B4=reward;

% while 1
%     task_max=max(max(reward));
%     [x y]=find(reward==max(max(reward)));
y=1;%
while y<=number_task %
    if y>=1 && y<=number_task_ES1
        if ALLOW0computate(1)>=1 && power_now(2)>=power_2(y+1,3+number_task)
            f(y)=1;
            ALLOW0computate(1)=ALLOW0computate(1)-1;
            power_now(2)=power_now(2)-power_2(y+1,3+number_task);
            reward(y)=0;
            
        else
            reward(y)=0;
        end
    end
    
    if y>=number_task_ES1+1 && y<=number_task_ES1+number_task_ES2
        if power_now(3)>=power_2(y+1,4+number_task) && ALLOW0computate(2)>=1
            f(y)=1;
            ALLOW0computate(2)=ALLOW0computate(2)-1;
            power_now(3)=power_now(3)-power_2(y+1,4+number_task);
            reward(y)=0;
        else
            reward(y)=0;
        end
    end
    
    if y>=number_task_ES1+number_task_ES2+1 && y<=number_task_ES1+number_task_ES2+number_task_ES3
        if power_now(4)>=power_2(y+1,5+number_task) && ALLOW0computate(3)>=1
            f(y)=1;
            ALLOW0computate(3)=ALLOW0computate(3)-1;
            power_now(4)=power_now(4)-power_2(y+1,5+number_task);
            reward(y)=0;
        else
            reward(y)=0;
        end
    end
    
    if y>=number_task_ES1+number_task_ES2+number_task_ES3+1 && y<=number_task_ES1+number_task_ES2+number_task_ES3+number_task_ES4
        if power_now(5)>=power_2(y+1,6+number_task) && ALLOW0computate(4)>=1
            f(y)=1;
            ALLOW0computate(4)=ALLOW0computate(4)-1;
            power_now(5)=power_now(5)-power_2(y+1,6+number_task);
            reward(y)=0;
        else
            reward(y)=0;
        end
    end
    
    if y>=number_task_ES1+number_task_ES2+number_task_ES3+number_task_ES4+1 && y<=number_task_ES1+number_task_ES2+number_task_ES3+number_task_ES4+number_task_ES5
        if power_now(6)>=power_2(y+1,7+number_task) && ALLOW0computate(5)>=1
            f(y)=1;
            ALLOW0computate(5)=ALLOW0computate(5)-1;
            power_now(6)=power_now(6)-power_2(y+1,7+number_task);
            reward(y)=0;
        else
            reward(y)=0;
        end
    end
    
    if y>=number_task_ES1+number_task_ES2+number_task_ES3+number_task_ES4+number_task_ES5+1 && y<=number_task_ES1+number_task_ES2+number_task_ES3+number_task_ES4+number_task_ES5+number_task_ES6
        if power_now(7)>=power_2(y+1,8+number_task) && ALLOW0computate(6)>=1
            f(y)=1;
            ALLOW0computate(6)=ALLOW0computate(6)-1;
            power_now(7)=power_now(7)-power_2(y+1,8+number_task);
            reward(y)=0;
        else
            reward(y)=0;
        end
    end
    if sum(reward)==0
        break;
    end
    y=y+1;
end

A4=f;
end







