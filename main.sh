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

for i in 110 120 #130 140 150 160 170 180 190 200 210 220 230 240 250
do
  # Set actual temperature to variable t e.g. 1.1 instead of 110
  t=$( bc <<<"scale=1; $i / 100" )

  # Sets output file to have current temperature in the name of the output file
  sed 's/equil_temp.out/equil_'$i'.out/' equil_temp.in > equil_$i.in

  # Changes the placeholder temp to current temperature
  sed -i "" 's/temp/'$t'/' equil_$i.in

  # Run equillibrium stage using md3 with initial_coords_256 and equil_$i.in as input files
  # Run production stage using md3 with equil_$i.out and prod_$i.in as input files
  # Organise files into relevant folders 
done

exit 0
