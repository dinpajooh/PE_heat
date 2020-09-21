#!/bin/bash

nchain=1
timestep=1.25
ndata=8000
timespan=$(echo "$timestep*4000" | bc -l)
runtime=$(echo "$ndata * $timespan" | bc -l)
scale=$(echo "4.184*0.00001/6.022*10^12" | bc -l)

BD=$PWD
cd $BD
rm -rf CONDUCTANCE-pW_K

energy1=$(sed -n -e '/32000000 steps/{x;p;d;}' -e x log.lammps  | awk '{print $5}')
energy2=$(sed -n -e '/32000000 steps/{x;p;d;}' -e x log.lammps  | awk '{print $6}')
temp=$(sed -n -e '/32000000 steps/{x;p;d;}' -e x log.lammps  | awk '{print $8}')

energycurrent=$(echo "(-1*$energy1+$energy2)/2/$runtime" | bc -l)
conductance=$(echo "$scale*$energycurrent/$temp/$nchain" | bc -l)
echo $conductance >> CONDUCTANCE-pW_K


exit
