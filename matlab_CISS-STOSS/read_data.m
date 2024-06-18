
function [N_spins, Temperature, save, dimension_x, dimension_y, lithiums_per_row, rho_lit_factor, starting_mode, total_time, constant_or_changeable_voltage, relaxation_mag, constant_voltage, maximum_voltage, cycles] = read_data ()

    filename = 'user_configurations.xlsx';
    data_vector = readtable(filename);
    data = table2array (data_vector(:,2));
    disp(data)
    data = data(~isnan(data));
    
    %-------------------------------------
    % GENERAL CONFIGURATIONS:
    %-------------------------------------
    lithiums_fraction = data (1);   
    Temperature = data (2);                                           
    save = data (3);                                                  
    dimension_y = data (4);                                           
    dimension_x = data (5);
    %-----------------------------------------------------------------
    N_spins = lithiums_fraction * dimension_y * dimension_x / 100;
    lithiums_per_row = round(N_spins/dimension_y);
    %-----------------------------------------------------------------
    rho_lit_factor = (data (6)) /100;
    starting_mode = data (7)/100;                                    
    total_time = data (8);                                       
    constant_or_changeable_voltage = data (9);   
    relaxation_mag = data (10); 
    constant_voltage = data (11);                                
    maximum_voltage = data (12);                                    
    cycles = data (13);      
       
end