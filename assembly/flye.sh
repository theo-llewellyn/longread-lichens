#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=32:mem=96gb
 
module load anaconda3/personal
source activate Flye-env

cd $PBS_O_WORKDIR

ACCESSION=LIQ254RAFAR

flye --nano-hq \
 /rds/general/project/theollewellynproject/live/Guppy/${ACCESSION}_sup/*.fastq.gz \
 --out-dir /rds/general/project/theollewellynproject/live/flye_sup_metagenome_assembly_${ACCESSION} \
 --threads 32 \
 --scaffold \
 --meta \
 -g 33.66m

conda deactivate
