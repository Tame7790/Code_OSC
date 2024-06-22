function [cost_inf_MO,volume_inf_MO] = local_offload2(ALLOW1_offload,targetES,TASK1_number_all,TASK1_reward_all_lo_of)
%input ;output MCMC cost & volume
    i=1;
    cost_inf_MO=zeros(8+TASK1_number_all)*inf;
    volume_inf_MO=zeros(8+TASK1_number_all);
    while i<=8+TASK1_number_all
        j=1;
        while j<=8+TASK1_number_all
            if i==1 && 2<=j && j<=1+TASK1_number_all%source to task
                cost_inf_MO(i,j)=0;
                volume_inf_MO(i,j)=1;
            end
            if 2+TASK1_number_all<=i && i<=7+TASK1_number_all && j==8+TASK1_number_all%ES to sink
                cost_inf_MO(i,j)=0;
                volume_inf_MO(i,j)=ALLOW1_offload(i-1-TASK1_number_all);
            end
            if 2<=i && i<=1+TASK1_number_all && 2+TASK1_number_all<=j && j<=6+TASK1_number_all
                cost_inf_MO(i,j)=-1.5*TASK1_reward_all_lo_of(i-1);
                if ALLOW1_offload(j-1-TASK1_number_all)~=0
                   volume_inf_MO(i,j)=1;
                end
            end
            if 2<=i && i<=1+TASK1_number_all && j==7+TASK1_number_all%clould
                cost_inf_MO(i,j)=1;
                volume_inf_MO(i,j)=0;
            end
            if 2<=i && i<=1+TASK1_number_all && j==1+TASK1_number_all+targetES%task to target ES
                cost_inf_MO(i,j)=-TASK1_reward_all_lo_of(i-1);
                volume_inf_MO(i,j)=1;
            end
            j=j+1;
        end
        i=i+1;
    end
end

