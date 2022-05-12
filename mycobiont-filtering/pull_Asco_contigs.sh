#PBS -l walltime=03:00:00
#PBS -l select=1:ncpus=8:mem=96gb


module load samtools seqkit

cd $PBS_O_WORKDIR

ACCESSION=LIQ254RAFAR_Flye_sup
ACCESSION2=LIQ254RAFAR


#pull Ascomycota contig headers with coverage over 20x
perl -lane 'if(($F[5]=~"Ascomycota")|($F[5]=~"undef")&&($F[4]>=20)&&($F[1]>=5000)){print $F[0]}' ${ACCESION}_Asco_blobplot.blobDB.bestsum.table.txt > ${ACCESION2}_Asco_headers_filtered.txt

#pull contigs
cat /rds/general/project/theollewellynproject/live/flye_sup_Asco_assembly_${ACCESSION2} | /rds/general/user/tbl19/home/anaconda3/envs/seqkit-env/bin/seqkit grep -f ${ACCESSION}_Asco_headers_filtered.txt > ${ACCESION}_Asco_contigs_filtered.fa
