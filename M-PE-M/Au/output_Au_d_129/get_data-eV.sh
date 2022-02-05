#!/bin/bash

nchain=1
timestep=0.00025 # ps
ndata=4000
timespan=$(echo "$timestep*4000" | bc -l)
runtime=$(echo "$ndata * $timespan" | bc -l)
scale=$(echo "1.6*10^5" | bc -l)

BD=$PWD
cd $BD
rm -rf DATA_K


for dir in run1 run2 run3 run4 run5 run6 run7 run8 run9 run10; do
    energy1=$(sed -n -e '/16000000 steps/{x;p;d;}' -e x log.lammps-${dir}.dat  | awk '{print $5}')
    energy2=$(sed -n -e '/16000000 steps/{x;p;d;}' -e x log.lammps-${dir}.dat  | awk '{print $6}')
       temp=$(sed -n -e '/16000000 steps/{x;p;d;}' -e x log.lammps-${dir}.dat  | awk '{print $8}')

    energycurrent=$(echo "(-1*$energy1+$energy2)/2/$runtime" | bc -l)
    conductance=$(echo "$scale*$energycurrent/$temp/$nchain" | bc -l)
    echo $conductance >> DATA_K
done


cp DATA_K DATA
f95 average.f
./a.out > OUT_K


exit
