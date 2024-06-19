###
### Initial definitions
###
# path_wd = "/Users/silviags/Work/repos/CISS-STOSS/"  # path of the working dir
# 3.6 Aa/turn ; 3 Aa -> 450pm -> 4.5 Angstroms
n_strands = 2         # minimum is 1
n_turns_step = 5      # min is 5, Davydov soliton
n_steps = 2           # total mol length will be calculated: (( Int.(vars["n_turns_step"]) * Int.(vars["n_steps"]) ) * 3.6 * (4.5/3)   # length in Angstrom)
total_time = 100      # ns 
time_step = 1         # can be chosen by user; ns/step
temp = 300            # kelvin, K
relaxation_time = 0.005 # 1/tau(s)
type_of_pulse = 0   # 0 -> ac; 1 -> dc 
voltage = 0.0         # voltage, V
freq_voltage = 0.0    # if ac voltage, set value different to 0
cycles = 4            # times to calculate
alpha_starts = 1.0    # alpha e- position to start
beta_starts = 1.0     # beta e- position to start
helix_twisting = 0    # 0 -> right-handed; 1 -> left-handed
magnetochiral_anisotropy = 2.0 # value units