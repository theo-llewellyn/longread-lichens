#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=32:mem=124gb
 
module load anaconda3/personal bwa

cd $PBS_O_WORKDIR
ACCESSION=LIQ254RAFAR_Flye_sup
ACCESSION2=LIQ254RAFAR

#Round 1
source activate funannotate
minimap2 -ax map-ont \
 -t 32 \
 /rds/general/project/theollewellynproject/live/redundans/redundans_${ACCESSION}_BlobTools_filtered/contigs.reduced.fa \
 /rds/general/project/theollewellynproject/live/Guppy/${ACCESSION2}_sup/*.fastq.gz \
 -o /rds/general/project/theollewellynproject/live/alignments/${ACCESSION}_Asco_filtered_minimap2.sam

conda deactivate
conda activate Racon-env
~/software/racon/build/bin/racon \
 /rds/general/project/theollewellynproject/live/Guppy/${ACCESSION2}_sup/*.fastq.gz \
 /rds/general/project/theollewellynproject/live/alignments/${ACCESSION}_Asco_filtered_minimap2.sam \
 /rds/general/project/theollewellynproject/live/redundans/redundans_${ACCESSION}_BlobTools_filtered/contigs.reduced.fa \
 -t 32 -m 8 -x -6 -g -8 -w 500 > /rds/general/project/theollewellynproject/live/Racon/${ACCESSION}_Asco_Racon_assembly.fasta

#Round 2
conda deactivate
source activate funannotate
minimap2 -ax map-ont \
 -t 32 \
 /rds/general/project/theollewellynproject/live/Racon/${ACCESSION}_Asco_Racon_assembly.fasta \
 /rds/general/project/theollewellynproject/live/Guppy/${ACCESSION2}_sup/*.fastq.gz \
 -o /rds/general/project/theollewellynproject/live/alignments/${ACCESSION}_Asco_Racon_minimap2.sam

conda deactivate
conda activate Racon-env
~/software/racon/build/bin/racon \
 /rds/general/project/theollewellynproject/live/Guppy/${ACCESSION2}_sup/*.fastq.gz \
 /rds/general/project/theollewellynproject/live/alignments/${ACCESSION}_Asco_Racon_minimap2.sam \
 /rds/general/project/theollewellynproject/live/Racon/${ACCESSION}_Asco_Racon_assembly.fasta \
 -t 32 -m 8 -x -6 -g -8 -w 500 > /rds/general/project/theollewellynproject/live/Racon/${ACCESSION}_Asco_Racon1_assembly.fasta

#Round 3
conda deactivate
source activate funannotate
minimap2 -ax map-ont \
 -t 32 \
 /rds/general/project/theollewellynproject/live/Racon/${ACCESSION}_Asco_Racon1_assembly.fasta \
 /rds/general/project/theollewellynproject/live/Guppy/${ACCESSION2}_sup/*.fastq.gz \
 -o /rds/general/project/theollewellynproject/live/alignments/${ACCESSION}_Asco_Racon1_minimap2.sam

conda deactivate
conda activate Racon-env
~/software/racon/build/bin/racon \
 /rds/general/project/theollewellynproject/live/Guppy/${ACCESSION2}_sup/*.fastq.gz \
 /rds/general/project/theollewellynproject/live/alignments/${ACCESSION}_Asco_Racon1_minimap2.sam \
 /rds/general/project/theollewellynproject/live/Racon/${ACCESSION}_Asco_Racon1_assembly.fasta \
 -t 32 -m 8 -x -6 -g -8 -w 500 > /rds/general/project/theollewellynproject/live/Racon/${ACCESSION}_Asco_Racon2_assembly.fasta

#Round 4
conda deactivate
source activate funannotate
minimap2 -ax map-ont \
 -t 32 \
 /rds/general/project/theollewellynproject/live/Racon/${ACCESSION}_Asco_Racon2_assembly.fasta \
 /rds/general/project/theollewellynproject/live/Guppy/${ACCESSION2}_sup/*.fastq.gz \
 -o /rds/general/project/theollewellynproject/live/alignments/${ACCESSION}_Asco_Racon2_minimap2.sam

conda deactivate
conda activate Racon-env
~/software/racon/build/bin/racon \
 /rds/general/project/theollewellynproject/live/Guppy/${ACCESSION2}_sup/*.fastq.gz \
 /rds/general/project/theollewellynproject/live/alignments/${ACCESSION}_Asco_Racon2_minimap2.sam \
 /rds/general/project/theollewellynproject/live/Racon/${ACCESSION}_Asco_Racon2_assembly.fasta \
 -t 32 -m 8 -x -6 -g -8 -w 500 > /rds/general/project/theollewellynproject/live/Racon/${ACCESSION}_Asco_Racon3_assembly.fasta

conda deactivate
