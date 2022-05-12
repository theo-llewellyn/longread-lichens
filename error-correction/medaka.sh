#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=32:mem=124gb

cd $PBS_WORKDIR

module load anaconda3/personal
source activate medaka

ACCESSION=LIQ254RAFAR_Flye_sup
ACCESSION2=LIQ254RAFAR

medaka_consensus -i /rds/general/project/theollewellynproject/live/Guppy/${ACCESSION2}_sup/*.fastq.gz \
 -d /rds/general/project/theollewellynproject/live/Racon/${ACCESSION}_Asco_Racon3_assembly.fasta \
 -o /rds/general/project/theollewellynproject/live/medaka/${ACCESSION}_Racon \
 -t 32 \
 -m r941_min_sup_g507
