#SBATCH --ntasks-per-node=24
#SBATCH --ntasks=504
#SBATCH --cpus-per-task=1
#SBATCH -p cpu                    
#SBATCH -J e3                
#SBATCH --exclusive    
# Pre-requisitos

echo $SLURM_JOB_NODELIST
nodeset -e $SLURM_JOB_NODELIST

# opcional
module load openmpi/1.10_gnu
module load rosetta/2017.52_openmpi-1.10_gnu

cd $SLURM_SUBMIT_DIR

srun --mpi=pmi2 --resv-ports -n $SLURM_NTASKS $ROSETTA_BIN/AbinitioRelax.mpi.linuxgccrelease -database $ROSETTA3_DB -in:file:fasta t000_.fasta -in:file:frag3 aat000_03_05.200_v1_3 -in:file:frag9 aat000_09_05.200_v1_3 -use_input_sc -nstruct 100000 -abinitio:relax -ex1 -ex2 -abinitio::rg_reweight 0.5 -output_all -overwrite -out:pdb -database $ROSETTA3_DB
