# PE_heat
The LAMMPS scripts, analysis codes and relevant simulation data
for studying heat conduction in polyethylene polymer chains 
are provided in the following directories.

The directories are named as NX, where X refers to the chain length.


##########################
####   INPUT FILES   #####
##########################

Each directory contains information about the LAMMPS scripts
(in.PEquil and in.PEprod) as well as
polyethylene configurations (lammps-AT-config) of various
chain lengths used to study the heat conduction.


###########################
####  MODEL DETAILS   #####
###########################

The simulated model comprises a molecular polymer chain which is held at each end
by fixed parallel walls, where the imposed interwall distance defines the chain
end-to-end distance and the tension within the chain.
Because our focus here is on the intrinsic heat conduction behavior of the polymer,
we use segments of the polymet itself as boundary thermostats.
This is done by having next to the walls sections of the polymer chains that are
held at the imposed left and right boundary temperatures using white
(Markovian) Langevin thermostats.
The lengths of these thermostated segments is taken greater than a slab
(chain segments used to define a coarse-grained local temperature) size,
namely, it comprises a number of carbon beads larger than N/X
where N is the number of carbon beads and X is the number of slabs.
Note that based on the LAMMPS instructions/commands, we thermostat
two regions of the polymer chain at different temperatures via fix langevin.
The system is propagated in time with a timestep of 1.25 fs
until steady state is reached typically after 1 ns.
At the steady state, the energy flux can be computed as the energy per unit time
taken out from the cold end or injected into the hot end.
Specifically, we calculate the heat conductance as

I_z  = 0.5/(Delta_t)* ( |Delta_Ehot| + |Delta_Ecold| ),
where at the steady state Delta_Ehot and Delta_Ecold are the amounts of energy
added to the hot region and subtracted from the cold region during
a time interval Delta_t to create the heat flux.


All the forcefield parameters and simulation parameters are provided in
the LAMMPS scripts, namely in.PEequil and in.PEprod.

################################
####   RUNING SIMULATIONS   ####
################################

If you want to run the molecular dynamics simulations simply run:

1- lammps < in.PEequil > Outequil

2- mv FINALCONFIG RESTART

3- lammps < in.PEprod > Outprod

where lammps is the executable of the LAMMMPS software program.
Note that we use the version of LAMMPS released on March 16, 2018.

##########################
####   OUTPUT FILES   ####
##########################

Additionally, sample output files and analysis codes are provided:
Heat current can be computed from the "log.lammps" file, where an analysis
code (get_conductance.sh) is provided to obtain the heat conductance
in pW/K units: simply run "bash get_conductance.sh"
Temperature profiles can be obtained from the "profile.langevin" file.

