#!/bin/bash

# Rename equil_170.in since temperature is not necassarily 1.7
mv equil_170.in equil_temp.in

# Give temperature and temporary name temp.
sed -i "" 's/170/temp/g' equil_temp.in
sed -i "" 's/1.7/temp/g' equil_temp.in

# Change value of time step
sed -i "" 's/0.0032/0.004/' equil_temp.in

# Change value of skin
sed -i "" 's/.1/.6/' equil_temp.in

# Include 100 in your loop
for i in 110 120 #130 140 150 160 170 180 190 200 210 220 230 240 250
do
  # Set actual temperature to variable t e.g. 1.1 instead of 110
  t=$( bc <<<"scale=1; $i / 100" )

  ##############################
  ### CREATE NECASSARY FILES ###
  ##############################

  # Sets output file to have current temperature in the name of the output file
  sed 's/equil_temp.out/equil_'$i'.out/' equil_temp.in > equil_$i.in

  # Changes the placeholder temp to current temperature
  sed -i "" 's/temp/'$t'/' equil_$i.in

  # Run equillibrium stage using md3 with initial_coords_256 as input and equil_$i.in as control
  # equil_$i.out and equil_$i.tup will be the output files
  ./md3 <equil_$i.in >equil_$i.tup

  # Change output file in production stage control file prod_$i.in  
  sed 's/equil_'$i'.out/prod_'$i'.out/' equil_$i.in > prod_$i.in

  # Change input file in equil_$i,in for the production stage and save to a new input file
  sed -i "" 's/initial_coords_256/equil_'$i'.out/' prod_$i.in

  # Change line 7 in prod_$i.in to be -1 and save to new input file
  # This is to keep total energy of the system constant rather than temperature.
  # Therefore no velocity scaling
  sed -i "" '7s/'$t'/-1/' prod_$i.in

  # Run production stage using md3 with equil_$i.out and prod_$i.in as input files
  # prod_$i.out and prod_$i.tup will be the output files
  ./md3 <prod_$i.in >prod_$i.tup

  ####################################################################
  ############################## PART A ##############################
  ####################################################################

  # Create data file from data in .tup file (All values calculated; Step, Temp, Kinetic, Potential, Total Energy, Pressure)
  # Also removes all comments in the .tup file and saves it to .dat file
  sed -n '18,$p' prod_$i.tup | sed '/^#/d' > prod_$i.dat

  # Separate U* and T* from rest of data (Internal energy is in column 5 and temperature is in column 2)
  awk '{print $5,$2}' prod_$i.dat > UT_$i.dat

  # Finds values of internal energy then finds error of the internal energy by subtracting the true value of internal energy (2.41) and makes it positive.
  # Then runs the  fortran programme block_avg to find the block averages and saves mean and variance to data file
  # ./block_avg >> mean_variance_$i.dat
  awk '{print $1}' UT_$i.dat | awk '{print ($0+2.41)*-1}' ./block_avg # >> mean_variance.dat

  # Need to estimate errors???

  ##############
  ### PART B ###
  ##############

  # Plot U* against T*

  # Obtain best fit cubic polynomial relating U* and T*

  # Find expression for constant volume thermal capacity as a function of temperature (Outside of code)

  ###############
  ### TIDY UP ###
  ###############

  # Make directories for equilibrium and production stage files
  mkdir Equilibrium
  mkdir Production

  # Make Directories for .in .out .tup files in Equilibrium directory
  mkdir Equilibrium/in
  mkdir Equilibrium/out
  mkdir Equilibrium/tup

  # Make directories for .in .out .tup files in Production directory
  mkdir Production/in
  mkdir Production/out
  mkdir Production/tup
  mkdir Production/dat

  # Organise equilibrium stage files into relevant directories
  mv equil_$i.in Equilibrium/in
  mv equil_$i.out Equilibrium/out
  mv equil_$i.tup Equilibrium/tup

  # Organise production stage files into relavant directories
  mv prod_$i.in Production/in
  mv prod_$i.out Production/out
  mv prod_$i.tup Production/tup
  mv prod_$i.dat Production.dat
done

exit 0
