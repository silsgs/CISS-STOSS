function [lithiums_occupancy_matrix, lithiums_density_per_step, index_array_density] = iteration_process (electric_field, lithiums_occupancy_matrix, total_steps, right_probability, left_probability, lithiums_per_row, dimension_x, dimension_y, lithiums_density_per_step, vector_fractions_rho, index_array_density)
    
    for z = 1:total_steps
        
            random_n_right = zeros ([dimension_y, lithiums_per_row]);
            random_n_left = rand ([dimension_y, lithiums_per_row]);

 

            for i = 1:dimension_y
                
                for j = 1:lithiums_per_row

                    if (electric_field (z) < 0)
                        
                        right_probability (z) = left_probability (z);

                        left_probability (z) = right_probability (z);

                    end

                    
                    if (j == 1)
                        
                        right =  lithiums_occupancy_matrix (i, j+1) - lithiums_occupancy_matrix (i, j);  
                        if (random_n_right (i,j) <= right_probability (z) && (right > 1))
                            lithiums_occupancy_matrix (i,j) = lithiums_occupancy_matrix (i,j) + 1;
                        elseif (random_n_left (i,j) <= left_probability (z) && (lithiums_occupancy_matrix (i, j) > 1))
                            lithiums_occupancy_matrix (i,j) = lithiums_occupancy_matrix (i,j) -1;
                        end
        
                    elseif (j == lithiums_per_row)
                        
                        left =  lithiums_occupancy_matrix (i, j) - lithiums_occupancy_matrix (i, j-1);
                        if (random_n_left (i,j) <= left_probability (z) && (left > 1))
                            lithiums_occupancy_matrix (i,j) = lithiums_occupancy_matrix (i,j) -1;
                        elseif (random_n_right (i,j) <= right_probability (z) && (lithiums_occupancy_matrix (i, j) < dimension_x))
                            lithiums_occupancy_matrix (i,j) = lithiums_occupancy_matrix (i,j) + 1;
                        end
        
                    else
                               
                        if (random_n_right (i,j) <= right_probability (z) && (lithiums_occupancy_matrix (i, j+1) - lithiums_occupancy_matrix (i, j)) > 1)
                                lithiums_occupancy_matrix (i,j) = lithiums_occupancy_matrix (i,j) + 1;
                        elseif (random_n_left (i,j) <= left_probability (z) && (lithiums_occupancy_matrix (i,j) - lithiums_occupancy_matrix (i, j-1)) > 1)
                                lithiums_occupancy_matrix (i,j) = lithiums_occupancy_matrix (i,j) -1;
                        end
                    end
        
                end
               
            end
        

        [lithiums_density_per_step, index_array_density] = lithiums_density (lithiums_occupancy_matrix, lithiums_density_per_step, vector_fractions_rho, z, index_array_density);
        
    end
  
end