# -*- coding: utf-8 -*-
"""
Created on Mon Apr 15 12:36:34 2024

@author: Principal
"""

import numpy as np
import matplotlib.pyplot as plt
import pandas as pd



#--------------------------------
#Configurations of the graphs
#--------------------------------

font = {'family' : "Times New Roman",
       'weight' : 'normal',
       'size'   : 40  }  
plt.rc('font', **font)
plt.rc('legend', fontsize = 40) # using a size in points
plt.rcParams['lines.linewidth'] = 12
plt.rcParams['lines.markersize'] = 15

#--------------------------------
#Reading the file from matlab
#--------------------------------
data = pd.read_excel(r'data_prueba.xlsx', engine='openpyxl')
percents = data.columns[1:-1]

data = np.array(data)
iteration = data [:,0]
iteration_names = iteration.astype(str)
data = data [:,1:-1]


#--------------------------------

if len(data[1,:]) <= 5:
    plt.rcParams["figure.figsize"] = [8, 45]
elif len(data[1,:]) <= 10:
    plt.rcParams["figure.figsize"] = [12, 45]
else:
    plt.rcParams["figure.figsize"] = [35, 45]
plt.rcParams["figure.autolayout"] = True
#--------------------------------

#-----------------------------------
#Preparing the names of each axis
#-----------------------------------
#percents = [str(int(i))+"%" for i in Var_names]

#--------------------------------
#Plotting
#--------------------------------
fig, ax = plt.subplots()
cmap = plt.get_cmap('magma')
reversed_map = cmap.reversed() 
im = ax.imshow(data, cmap = reversed_map)
fig.colorbar(im, ax=ax, orientation="horizontal", location='bottom',  pad=0.04)

# We want to show all ticks...
ax.set_xticks(np.arange(len(percents)))
ax.set_yticks(np.arange(len(iteration_names)))
# ... and label them with the respective list entries
ax.set_xticklabels(percents)
ax.set_yticklabels(iteration_names)

# Turn spines off and create white grid.
for edge, spine in ax.spines.items():
    spine.set_visible(False)
        
# Rotate the tick labels and set their alignment.
plt.setp(ax.get_xticklabels(), rotation=45, ha="right",
         rotation_mode="anchor")

# Loop over data dimensions and create text annotations.
for i in range(len(iteration_names)):
    for j in range(len(percents)):
        text = ax.text(j, i, data[i, j],
                       ha="center", va="center", color="b")

ax.set_title("Cation diffusion evolution of Li+ ions in a Hybrane polymer")
fig.tight_layout()
plt.savefig('diffusion of lithiums ions'+ '.png')    
plt.show()

