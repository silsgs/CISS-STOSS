function [electric_field, right_probability, left_probability, P_ij, E] = applied_electric_field (time_steps, constant_voltage, maximum_voltage, cycles, constant_or_changeable_voltage, Temperature, total_probability)
    
    %--------------------------------------------------------------------    
    %   Creating vectors:
    %--------------------------------------------------------------------
       
    electric_field = single (zeros (1, time_steps));

    right_probability = single (zeros (1, time_steps)); 
    left_probability = single (zeros (1, time_steps));                     
    e_charge = -1; % e_charge = -1
    salto_entre_copas = 5; % copas : Angstrom ; ciss : Angstrom
    mol_length = 20; % ciss - mol_length = 20 Angstrom
    magnetoch_ani = 0 
    electron_spin = 1

    if (constant_or_changeable_voltage == 0)   % DC
       
        % Calculating the energy gap between a hole and the other one (eV):
        E = e_charge * constant_voltage * salto_entre_copas / mol_length + ( (magnetoch_ani * constant_voltage) * electron_spin ) % add magnetochiral anisotropy effect --> magnetoch_ani : XX * electron_spin : alpha = +1; beta = -1

        % Calculating the Bolztmann distribution:       
        P_ij = 1/(exp(E * 11604.525 / Temperature)); % ratio excited states / ground states population [0-1] 

        % Calculating single probabilities:
        %[xx, yy] =  solve_single_p (total_probability, P_ij);
        %right_probability = xx + right_probability;
        %left_probability = yy + left_probability;

        downwards_p = total_probability / (1 + P_ij)   % double check sign
        upwards_p = (P_ij * total_probability) / (1 + P_ij)   # ratio prob

        electric_field = electric_field + constant_voltage; % duda

    else
        
        electric_field = single (zeros (1, time_steps));
        E = single (zeros (1, time_steps));
        P_ij = single (zeros (1, time_steps));
        
        for i = 1:time_steps

            electric_field(i) = maximum_voltage * cos (((pi/2))+ (i * cycles * 2 * (pi) / time_steps));
            
            % Calculating the energy gap between a hole and the other one (eV):
            E = e_charge * electric_field(i) * salto_entre_copas / mol_length + ( (magnetoch_ani * electric_field(i)) * electron_spin ) % add magnetochiral anisotropy effect --> magnetoch_ani : XX * electron_spin : alpha = +1; beta = -1
    
            % Calculating the Bolztmann distribution:       
            P_ij = 1/(exp(E * 11604.525 / Temperature)); % ratio excited states / ground states population [0-1] 
    
            % Calculating single probabilities:
            %[xx, yy] =  solve_single_p (total_probability, P_ij);
            %right_probability = xx + right_probability;
            %left_probability = yy + left_probability;
    
            downwards_p = total_probability / (1 + P_ij)   % double check sign
            upwards_p = (P_ij * total_probability) / (1 + P_ij)   

        end
    end

end

