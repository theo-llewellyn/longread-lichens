#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=32:mem=96gb
 
module load jellyfish

cd $PBS_O_WORKDIR

ACCESSION=LIQ254RAFAR_Flye_sup

jellyfish count \
 -C \
 -m 21 \
 -s 1000000000 \
 -t 32 \
 /rds/general/project/theollewellynproject/live/LIQ254RAFAR_ONT_data/${ACCESSION}_Asco_reads_2.fasta \
 -o /rds/general/project/theollewellynproject/live/jellyfish/${ACCESSION}_reads.jf

jellyfish histo \
 -t 32 \
 /rds/general/project/theollewellynproject/live/jellyfish/${ACCESSION}_reads.jf > /rds/general/project/theollewellynproject/live/jellyfish/${ACCESSION}_reads.histo
