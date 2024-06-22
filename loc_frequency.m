function [frequency_min] = loc_frequency(k,slot,B_battery_MO_ES_MIN,Btran_MO_ES1)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if B_battery_MO_ES_MIN<=Btran_MO_ES1
    energy_min=B_battery_MO_ES_MIN;
else 
    energy_min=Btran_MO_ES1;
end
frequency_min=(energy_min/k/slot)^(1/3);
end

