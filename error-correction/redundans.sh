#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=32:mem=124gb

module load anaconda3/personal
source activate redundans-env

cd $PBS_O_WORKDIR

ACCESSION=LIQ254RAFAR

#reduction, scaffolding using pe-reads and gap closing using pe-reads
/rds/general/user/tbl19/home/anaconda3/envs/redundans-env/redundans/redundans.py -v \
-l /rds/general/project/theollewellynproject/live/Guppy/${ACCESSION}_sup/*.fastq.gz \
-f /rds/general/project/theollewellynproject/live/${ACCESSION}_Flye_sup_Asco_contigs_filtered.fa \
-t 32 \
-o /rds/general/project/theollewellynproject/live/redundans/redundans_${ACCESSION}_Flye_sup_BlobTools_filtered
