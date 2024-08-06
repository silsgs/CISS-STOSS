###
### Initial definitions
###
# path_wd = "/Users/silviags/Work/repos/CISS-STOSS/"  # path of the working dir
# 3.6 Aa/turn ; 3 Aa -> 450pm -> 4.5 Angstroms
# alpha spin -> -1 ; beta spin -> 1
n_strands = 2         # minimum is 1
n_turns_step = 5      # min is 5, Davydov soliton
n_steps = 2           # total mol length will be calculated: (( Int.(vars["n_turns_step"]) * Int.(vars["n_steps"]) ) * 3.6 * (4.5/3)   # length in Angstrom)
temp = 300            # kelvin, K
relaxation_time = 0.005 # tau(s)
type_of_pulse = 0     # 0 -> ac; 1 -> dc 
voltage = 3.0         # voltage, V
voltage_freq = 3.7    # if ac voltage, set value different to 0; Hz (radians/s)
cycles = 4            # times to calculate ; ac cycles
alpha_starts = 1.0    # alpha e- position to start
beta_starts = 1.0     # beta e- position to start
helix_twisting = -1    # -1 -> right-handed; 1 -> left-handed
magnetochiral_anisotropy = 2.0 # value units

# old vars
#total_time = 100      # ns -- it going to be hardcoded depending on tau
#time_step = 1         # can be chosen by user; time_step/ns ## tau/50
