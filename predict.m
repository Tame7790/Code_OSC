function [y_4] = predict(y1,y_1,y2,y_2,y3,y_3,y4,T)
%
buchang=1/(T+T*3*2)^(1/2);
loss1=abs(y1-y_1);
loss2=abs(y2-y_2);
loss3=abs(y3-y_3);
if y_1==y_2
    daoshu1=0;
else
    daoshu1=(loss1-loss2)/(y_1-y_2);
end
if y_3==y_2
    daoshu2=0;
else
    daoshu2=(loss2-loss3)/(y_2-y_3);
end
y_4=y4-buchang*(daoshu1+daoshu2)/2;

end


