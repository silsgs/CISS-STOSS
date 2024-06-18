###########################################################
## main file
###########################################################

function read_params(name_wd)
    ### reads variables (exp parameters) from file
    file0 = name_wd * "/definitions.jl"
    vars = Dict{String, Float64}()
    f0 = open(file0)
    
    for line in eachline(f0)
        if startswith(line,'#')
            continue;
        else
            cont = split(line, "#")[1]
            var, val = split(cont, "=")
            vars[strip(var)] = parse(Float64, val)
        end
    end
    return vars
end

function calculate_probabilities()
    
end

#
## program starts
#
# global path and reading params
path_wd = pwd()
vars = read_params(path_wd)
print(vars)

# setting data structures
tot_strands = Int.(vars["n_strands"]) * 2
tot_steps = Int.(vars["total_time"] / vars["time_step"]) 
alpha_init_pos = Int.(vars["alpha_starts"])
beta_init_pos = Int.(vars["beta_starts"])

#setting initial state
init_state_matrix = zeros(Int8, tot_strands, tot_steps) # rows, cols
dim = size(init_state_matrix) 
odd_nums = 1:2:100   # alpha channels
even_nums = 2:2:100  # beta channels

for i = 1:dim[1] # rows
    if isodd(i)  # means its alpha channel
        init_state_matrix[i,alpha_init_pos] = 1
    else         # means its beta channel
        init_state_matrix[i,beta_init_pos] = 1
    end
end

#
## main loop
#
# loop running over state matrix # first step
for i = dim[1]       # runs over rows
    for j = dim[2]   # runs over cols
        # what do we need to do first
        # calculate probability of change position

        # what do we need to do secondly

    end 
end
