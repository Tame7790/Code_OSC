function [cost_inf_MO,volume_inf_MO] = MO_way2(targetES,Queue_F,yz_F,Queue_B,TASK1_bit_all,TASK1_reward_all,TASK1_number_all,TASK1_deadline_all_mo,U,V,price_clould,TRAN_BIT,ALLOW1_offload,t_task_es1)
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
                cost_inf_MO(i,j)=-4*(Queue_F-yz_F)*TASK1_bit_all(i-1)/3+U*V*1000*TRAN_BIT(j-TASK1_number_all-1)*TASK1_bit_all(i-1);
                if ALLOW1_offload(j-1-TASK1_number_all)~=0 && t_task_es1(i-1,j-TASK1_number_all-1)+0.001+TRAN_BIT(j-TASK1_number_all-1)*TASK1_bit_all(i-1)<=TASK1_deadline_all_mo(i-1)
                   volume_inf_MO(i,j)=1;
                end
            end
            if 2<=i && i<=1+TASK1_number_all && j==7+TASK1_number_all%clould
                cost_inf_MO(i,j)=price_clould*TASK1_bit_all(i-1)-2*(Queue_F-yz_F)*TASK1_bit_all(i-1)/3+U*V*1000*TRAN_BIT(6)*TASK1_bit_all(i-1);
                if ALLOW1_offload(j-1-TASK1_number_all)~=0 && TASK1_deadline_all_mo(i-1)>TRAN_BIT(6)*TASK1_bit_all(i-1)
                   volume_inf_MO(i,j)=1;
                end
            end
            if 2<=i && i<=1+TASK1_number_all && j==1+TASK1_number_all+targetES%task to target ES
                cost_inf_MO(i,j)=2*(Queue_B-5000-Queue_F+yz_F)*TASK1_bit_all(i-1)/3+2*(TASK1_number_all-20)/3-U*TASK1_reward_all(i-1)+U*V*1000000*t_task_es1(i-1,j-TASK1_number_all-1);
                volume_inf_MO(i,j)=1;
            end
            j=j+1;
        end
        i=i+1;
    end
end

