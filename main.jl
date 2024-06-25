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

function calculate_energy_step(e_charge, voltage, n_steps, magnetochiral_ani, electron_spin)
    # calculating E of each step
    E = (e_charge * voltage / n_steps) + ((magnetochiral_ani * voltage) * electron_spin) 
    return E
end

function calculate_Boltzmann(E, k, T) 
    # probability of change in every step
    P_ij = 1/(exp(E*k/T))   # ratio excited states / ground states population [0-1] 
    return P_ij
end

function single_probability(total_probability, P_ij)
    yy = (total_probability/(1 + P_ij))
    xx = P_ij * yy
    return yy, xx
end



#
## program starts here
#
# modules call, global path and reading input params
using Plots
path_wd = pwd()
vars = read_params(path_wd)
print(vars)

###########################################################
# setting data structures and variables
n_cycles = Int.(vars["cycles"])
tot_strands = Int.(vars["n_strands"]) * 2
tot_steps = Int.(vars["total_time"] / vars["time_step"]) 
mol_lenght = ( Int.(vars["n_turns_step"]) * Int.(vars["n_steps"]) ) * 3.6 * (4.5/3)   # length in Angstrom 
alpha_init_pos = Int.(vars["alpha_starts"])
beta_init_pos = Int.(vars["beta_starts"])
# 
twisting_dir = Int.(vars["helix_twisting"])   # 0 -> right-h; 1 -> left-h
e_charge = Int.(-1) 
alpha_spin = Int.(-1)
beta_spin = Int.(1)
# 
type_of_pulse = Int.(vars["type_of_pulse"])   # 0 -> ac; 1 -> dc
voltage_magnitude = vars["voltage"]           # magnitude of V pulse
voltage_freq = vars["freq_voltage"]           # if ac, frequency of V pulse
# 
T =  vars["temp"]   # temperature, T(K)
k = 11604.525       # where does it come from? 8.617333262*10^-5 ev/K
magnetochiral_ani = Int.(vars["magnetochiral_anisotropy"]) 
#
total_probability = 0.00995 # taylor expansion, exp decreciente
###########################################################

# pending tasks 
# crear lista historia upwards, downwards
# AC // DC voltages loop
# definition of magnetochiral_ani
# where to apply Davydov polaron inertia

# generating voltage pulse
pulse_Vs = []
if type_of_pulse < 1  # ac pulse
    for i = 1:tot_steps
    Vi = voltage_magnitude*cos((pi/2)+(i*voltage_freq*2*pi)/tot_steps)
    append!(pulse_Vs, Vi)
    end
else                  # dc pulse
    pulse_Vs = repeat([voltage_magnitude], outer=tot_steps) 
end

# check
print(length(pulse_Vs))
x = range(0, vars["total_time"], length=tot_steps)
plot(x, pulse_Vs)

#setting initial state
init_state_matrix = zeros(Int8, tot_strands, tot_steps) # rows, cols
dim = size(init_state_matrix) 
odd_nums = 1:2:100   # row indexes alpha channels
even_nums = 2:2:100  # row indexes beta channels

for i = 1:dim[1] # rows
    if isodd(i)  # means its alpha channel
        init_state_matrix[i,alpha_init_pos] = 1
    else         # means its beta channel
        init_state_matrix[i,beta_init_pos] = 1
    end
end

#
##
### main loop
##
#
# loop over number of cycles
global_trajectory = Dict{String, Vector}()   # "n_cycle + (up/down)wards_move": list
for n_run = 1:n_cycles

upwards_move = []
downwards_move = []

# loop running over state matrix # first step
for i = dim[1]          # runs over total steps (cols)
    for i in odd_nums   # runs over alpha channels (rows)
        # what do we need to do first
        # calculate probability for alpha e-
    end
    
    for i in even_nums  # runs over beta channels (rows)
        # calculate probability for beta e- 
    end
end


# filling global trajectory dict
global_trajectory[string(n_run)*"_upwards"] = upwards_move
global_trajectory[string(n_run)*"_downwards"] = downwards_move

end