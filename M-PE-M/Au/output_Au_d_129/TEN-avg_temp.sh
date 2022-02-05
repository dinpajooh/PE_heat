#!/bin/bash

# 1- Generate the executable rdfavg from avgfiles.f  
# 2- RUN ./avg_SKs.sh
#Set up a base directory
BD=$PWD

cd $BD

f95 -o rdfavg TEN-avgfiles_temps.f 

rm -rf DATA_final
mkdir DATA_final
cp rdfavg DATA_final


for ((K=1;K<=10;K++)); do
     cp $BD/average-profile-run$K.dat    $BD/DATA_final/$K
done
cd $BD/DATA_final
./rdfavg
mv final Temp-profile.dat
for ((K=1;K<=10;K++)); do
     rm -rf $K
done

exit
