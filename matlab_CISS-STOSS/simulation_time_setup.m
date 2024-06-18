function [step_length, total_probability, total_steps, time_vector] = simulation_time_setup (relaxation_time, total_time)

    %--------------------------------------------------------------------------
    % Relaxation time (s):
    %--------------------------------------------------------------------------

    % Following relaxation mechanisms: Orbach:

    %tau_mag = ((exp(-Ueff/T))/tau_0)^-1;
    
    %--------------------------------------------------------------------------
    % Steps from the total time:
    %--------------------------------------------------------------------------
    
    total_probability = 0.00995; %%expansion de taylor, expansion de la exp decreciente
    step_length = relaxation_time/100;
    total_steps = (total_time/relaxation_time)*100;
    time_vector = (0:step_length:total_time);

end