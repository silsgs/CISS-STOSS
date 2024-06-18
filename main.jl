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

function calculate_prbabilities()
    
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

init_matrix = zeros(Int8, tot_strands, tot_steps) # cols, rows

for i in init_matrix[:,1] # runs over rows
    for j in init_matrix_dim[:,1] # runs over cols

    end 
end
