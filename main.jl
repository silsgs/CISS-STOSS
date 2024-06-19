###########################################################
## main file
###########################################################

function read_params(name_wd)
    ### reads variables (exp parameters) from file
    #file0 = name_wd * "/definitions.jl"   # for mac
    file0 = name_wd * "\\definitions.jl"   # for win
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

# setting data structures and variables
n_cycles = Int.(vars["cycles"])
tot_strands = Int.(vars["n_strands"]) * 2
tot_steps = Int.(vars["total_time"] / vars["time_step"]) 
mol_lenght = ( Int.(vars["n_turns_step"]) * Int.(vars["n_steps"]) ) * 3.6 * (4.5/3)   # length in Angstrom 
alpha_init_pos = Int.(vars["alpha_starts"])
beta_init_pos = Int.(vars["beta_starts"])
# 
twisting_dir = Int.(vars["helix_twisting"]) # 0 -> right-h; 1 -> left-h
e_charge = Int.(-1) 
alpha_spin = Int.(-1)
beta_spin = Int.(1)
# 
type_of_pulse = Int.(vars["type_of_pulse"])   # 0 -> ac; 1 -> dc
voltage_magnitude = vars["voltage"]         # magnitude of V pulse
voltage_freq = vars["freq_voltage"]         # if ac, frequency of V pulse

#print("  mol length  ")
#print(mol_lenght)

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
# loop over number of cycles
for run = 1:n_cycles

# loop running over state matrix # first step
for i = dim[1]          # runs over rows
    for j in odd_nums   # runs over alpha channels
        # what do we need to do first
        # calculate probability for alpha e-
        
    end

    for l in even_nums  # runs over beta channels
        # calculate probability for beta e- 

    end

end
end
