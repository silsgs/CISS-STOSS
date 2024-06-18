%{
*****************************************
       FIRST VERSION OF THE PROGRAM
*****************************************
%}

addpath('C:\Users\Principal\Documents\CISS-STOSS');     % make sure for other systems
%addpath('C:\Users\Principal\Documents\COPAS-STOSS');
clear 
clc

%------------------
%   Timer:
%------------------
tic

%---------------------------------------------------
%   Reading experimental conditions from EXCEL file
%---------------------------------------------------
%[N_lithiums, Temperature, save, dimension_x, dimension_y, lithiums_per_row, rho_lit_factor, starting_mode, total_time, constant_or_changeable_voltage, relaxation_time, constant_voltage, maximum_voltage, cycles] = read_data ();
[N_spins, Temperature, save, dimension_x, dimension_y, lithiums_per_row, rho_lit_factor, starting_mode, total_time, constant_or_changeable_voltage, relaxation_time, constant_voltage, maximum_voltage, cycles] = read_data ();


%------------------------------------
%   Reading experimental conditions 
%------------------------------------
[step_length, total_probability, total_steps, time_vector] = simulation_time_setup (relaxation_time, total_time);

%--------------------------------
%   Arrays for saving results
%--------------------------------                                                 

%
% total probability can either
% a) be defined by us (in the input) and then from Taylor expansion 
% + the Arrhenius equation (Ueff, tau0, both in the input) we
% calculate the length of the time step; then from the total time 
% (also defined in the input) we obtain the total number of steps; 
% in this case we need a warning if the total number of steps is going to be too high
% or 
% b) calculated from Taylor because in the input we define the length of
% the time step; in this case we need a warning if the probability is too
% large
%
% total time could be defined in the input
%
% frequency should be defined in the input, for ac voltage
%

number_rows_matrix_density = (0:total_steps/10:total_steps)';
number_percents_for_density_analysis = 1/rho_lit_factor;

if (number_percents_for_density_analysis/round(number_percents_for_density_analysis)==1)
    index_array_density = single (zeros (length(number_rows_matrix_density), (round(1/rho_lit_factor))+2));
    vector_fractions_rho = 1:(rho_lit_factor * dimension_x):dimension_x+1;
    percents_names_for_results_symmary = rho_lit_factor*100 : rho_lit_factor*100 : 100;
else
    index_array_density = single (zeros (length(number_rows_matrix_density), (round(1/rho_lit_factor))+3));
    vector_fractions_rho = [1:(rho_lit_factor * dimension_x):dimension_x+1, dimension_x+1];
    percents_names_for_results_symmary = rho_lit_factor*100 : rho_lit_factor*100 : 100;
    percents_names_for_results_symmary = [percents_names_for_results_symmary, 100 - percents_names_for_results_symmary(end)];
end

index_array_density (:, 1) = number_rows_matrix_density;
                      
lithiums_density_per_step = single (zeros (total_steps + 1, length(vector_fractions_rho)-1));
lithiums_occupancy_matrix = single (zeros (dimension_y, lithiums_per_row));

%-------------------------------------
% Initial state:
%-------------------------------------
lithiums_occupancy_matrix = initial_state (lithiums_occupancy_matrix, dimension_y, lithiums_per_row, dimension_x, starting_mode);

[lithiums_density_per_step, index_array_density] = lithiums_density (lithiums_occupancy_matrix, lithiums_density_per_step, vector_fractions_rho, 0, index_array_density);

%-------------------------------------------------                
%   Iteration over the Matrix
%-------------------------------------------------
[electric_field, right_probability, left_probability, P_ij, E] = applied_electric_field (total_steps, constant_voltage, maximum_voltage, cycles, constant_or_changeable_voltage, Temperature, total_probability);

[lithiums_occupancy_matrix, lithiums_density_per_step, index_array_density] = iteration_process (electric_field, lithiums_occupancy_matrix, total_steps, right_probability, left_probability, lithiums_per_row, dimension_x, dimension_y, lithiums_density_per_step, vector_fractions_rho, index_array_density);

%-------------------------------------------------                
%   Displaying results
%-------------------------------------------------
disp ('Density:')

varNames = ["Time (secs)", string(percents_names_for_results_symmary) + '%', "Total Lithiums"];
index_array_density (:, 1) = index_array_density (:, 1) * step_length;
results_summary = array2table (index_array_density, 'VariableNames',varNames)

final = toc;
disp ('-------------------------------------------------')
disp ('Information about the simulation')
disp ('-------------------------------------------------')
disp ('Time, secs:')
disp (final)

delete('data_prueba.xlsx');
filename = 'data_prueba.xlsx';
writetable(results_summary,filename,'Sheet',1)

    




