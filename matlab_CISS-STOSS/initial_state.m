function [lithiums_occupancy_matrix] = initial_state (lithiums_occupancy_matrix, dimension_y, lithiums_per_row, dimension_x, starting_mode)

    
    for i = 1:dimension_y
        for j = 1:lithiums_per_row
            if (j == 1)
                lithiums_occupancy_matrix(i,j) = randi([1, dimension_x * starting_mode]);
            else 
                random_number = randi([1, dimension_x * starting_mode]);
                while (ismember(random_number, lithiums_occupancy_matrix(i, :)) == 1)
                    random_number = randi([1, dimension_x * starting_mode]);
                end
                lithiums_occupancy_matrix(i,j) = random_number; 
            end
    
        end
        lithiums_occupancy_matrix (i, :) = sort (lithiums_occupancy_matrix(i, :));
    end

end
