#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=32:mem=124gb

module load anaconda3/personal
source activate tapestry-env

cd $PBS_O_WORKDIR

ACCESSION=LIQ254RAFAR_Flye_sup
ACCESSION2=LIQ254RAFAR

weave \
 -a ${ACCESSION}_Asco_redundans_headers_filtered_sorted.fa \
 -r Guppy/${ACCESSION2}_sup/*.fastq.gz \
 -t CCCTAA TTAGGG \
 -o ${ACCESSION2} \
 -c 30

conda deactivate
