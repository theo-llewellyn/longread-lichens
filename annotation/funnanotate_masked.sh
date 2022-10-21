#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=32:mem=124gb

#get name of contigs file
ACCESSION=LIQ254RAFAR_Flye_sup
ACCESSION2=LIQ254RAFAR
SPECIES='Ramalina farinacea'

module load anaconda3/personal
source activate funannotate

cd $PBS_O_WORKDIR

export FUNANNOTATE_DB=/rdsgpfs/general/user/tbl19/home/anaconda3/envs/funannotate/funannotate_db

funannotate predict \
 -i ${ACCESSION}_Asco_redundans_headers_filtered_sorted.fa.masked \
 -s "${SPECIES}" \
 --name ${ACCESSION2} \
 --transcript_evidence Clagr3_ESTs_20111209_Velvet_and_Trinity_contigs.fasta Clagr3_ESTs_20111121_454_ESTs.fasta Usnflo1_ESTs_20160419_est.fasta Xanpa2_ESTs_20140928_est.fasta \
 --protein_evidence Clagr3_GeneCatalog_proteins_20111121.aa.fasta Usnflo1_GeneCatalog_proteins_20160419.aa.fasta Xanpa2_GeneCatalog_proteins_20140928.aa.fasta $FUNANNOTATE_DB/uniprot_sprot.fasta \
 -o ${ACCESSION}_genes_masked \
 --cpus 32 \
 --force

conda deactivate
