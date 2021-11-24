#!/bin/bash

# Set correct values of density, no. of particles, and time step and correct input and output files

# Correct value for title
sed '1c\
Equilibrate 256 particles, density=0.7, T*=temp
' equil_170.in > test.in | \

# Correct value for input file
sed '2c\
initial_coords_100
' equil_170.in > test.in | \

# Correct value for output file
sed '3c\
equil_170.out
' equil_170.in > test.in | \

# Correct value for number of time steps
sed '4c\
500
' equil_170.in > test.in | \

# Correct value for time step
sed '5c\
0.004
' equil_170.in > test.in | \

# Correct value for density
sed '6c\
0.5
' equil_170.in > test.in | \

# Temporary value for temperature since it will be looped later on
sed '7c\
temp
' equil_170.in > test.in | \

# Correct value for skin
sed '8c\
.6
' equil_170.in > test.in
