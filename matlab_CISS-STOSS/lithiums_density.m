    
function [lithiums_density_per_step, index_array_density] = lithiums_density (lithiums_occupancy_matrix, lithiums_density_per_step, vector_fractions_rho, step_number, index_array_density)

    rho = unique(lithiums_occupancy_matrix);
    frequency = [rho, histc(lithiums_occupancy_matrix(:),rho)];
        
    for i = 2:length(vector_fractions_rho)
         
         min_value = vector_fractions_rho(i-1)-1;
         max_value = vector_fractions_rho(i);
    
         r = frequency(frequency (:, 1)> min_value & frequency (:, 1)< max_value, :);

         if (step_number == 0)
            lithiums_density_per_step (1, i-1) = sum(r (:, 2));
         else 
            lithiums_density_per_step (step_number+1, i-1) = sum(r (:, 2));
         end
    end 
    
    if (ismember(step_number, index_array_density(:,1)))
         index = find(index_array_density(:,1) == step_number);
         total_lithiums_per_time_step = sum(lithiums_density_per_step (step_number+1, :));
         index_array_density (index,2:end-1) =  lithiums_density_per_step (step_number+1, :);
         index_array_density (index, end) = total_lithiums_per_time_step;
    end
