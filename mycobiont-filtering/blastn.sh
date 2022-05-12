#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=16:mem=124gb

module load blast+

cd $PBS_O_WORKDIR

blastn \
 -task megablast \
 -num_threads 16 \
 -culling_limit 5 \
 -query /rds/general/project/theollewellynproject/live/flye_sup_metagenome_assembly_LIQ254RAFAR/assembly.fasta \
 -db /rds/general/project/theollewellynproject/live/BlobTools/Lecanoromycetes_genomes_all \
 -outfmt 6 \
 -evalue 1e-25 \
 -out /rds/general/project/theollewellynproject/live/BlobTools/blast_output/LIQ254RAFAR_Flye_sup.vs.Lecanoromycetes_genomes.blastn
