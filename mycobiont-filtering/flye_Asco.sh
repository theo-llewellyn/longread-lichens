#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=32:mem=96gb
 
module load anaconda3/personal
source activate Flye-env

cd $PBS_O_WORKDIR

ACCESSION=LIQ254RAFAR_Flye_sup
ACCESSION2=LIQ254RAFAR

flye --nano-hq \
 /rds/general/project/theollewellynproject/live/${ACCESSION}_Asco_reads_2.fasta \
 --out-dir /rds/general/project/theollewellynproject/live/flye_sup_Asco_assembly_${ACCESSION2} \
 --threads 32 \
 --scaffold \
 --meta \
 -g 33.66m

conda deactivate
