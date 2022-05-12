#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=16:mem=124gb
 
module load anaconda3/personal
source activate diamond-env

cd $PBS_O_WORKDIR

#blast genome assembly against the uniprot90
diamond blastx \
   --index-chunks 1 \
   -e 1e-25 \
   -p 16 \
   -q /rds/general/project/theollewellynproject/live/flye_sup_metagenome_assembly_LIQ254RAFAR/assembly.fasta \
   -d /rds/general/project/theollewellynproject/live/BlobTools/uniref90.fasta.dmnd \
   --out /rds/general/project/theollewellynproject/live/BlobTools/diamond_output/LIQ254RAFAR_Flye_sup.vs.uniref90.diamond \
   --outfmt 6 \
   --sensitive

conda deactivate
