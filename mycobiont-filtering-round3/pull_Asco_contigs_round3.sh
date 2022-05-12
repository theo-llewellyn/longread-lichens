#PBS -l walltime=03:00:00
#PBS -l select=1:ncpus=8:mem=96gb


module load samtools seqkit

cd $PBS_O_WORKDIR

ACCESSION=LIQ254RAFAR_Flye_sup
ACCESSION2=LIQ254RAFAR


#pull Ascomycota contig headers with coverage over 20x
perl -lane 'if(($F[5]=~"Ramalinaceae")|($F[5]=~"Umbilicariaceae")){print $F[0]}' BlobTools/${ACCESSION}_Asco_redundans_with_nt_blobtools.out/${ACCESSION}_Asco_redundans_blobplot.blobDB.bestsum.table.txt > ${ACCESSION}_Asco_redundans_headers_filtered.txt

#pull contigs
cat /rds/general/project/theollewellynproject/live/medaka/LIQ254RAFAR_Flye_sup_Racon/consensus.fasta | /rds/general/user/tbl19/home/anaconda3/envs/seqkit-env/bin/seqkit grep -f ${ACCESSION}_Asco_redundans_headers_filtered.txt > ${ACCESSION}_Asco_redundans_headers_filtered.fa
