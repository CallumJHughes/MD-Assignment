#!/bin/bash

gfortran -g -fcheck=all -Wall -c stats.f90 block_avg.f90

gfortran -g -fcheck=all -Wall -o block_avg stats.o block_avg.o

./block_avg
