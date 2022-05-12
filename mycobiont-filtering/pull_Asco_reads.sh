#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=32:mem=124gb


module load samtools

cd $PBS_O_WORKDIR

ACCESSION=LIQ254RAFAR_Flye_sup
ACCESSION2=LIQ254RAFAR


#pull Ascomycota contains
perl -lane 'if(($F[5]=~"Ascomycota")|($F[5]=~"undef")&&($F[4]>=20)&&($F[1]>=5000)){print $F[0]}' BlobTools/${ACCESSION}_blobtools.out/${ACCESION}_blobplot.blobDB.bestsum.table.txt > filtered_Asco_contigs/${ACCESION}_Asco_headers.txt

FILENAME="filtered_Asco_contigs/${ACCESSION}_Asco_headers.txt"
LINES=$(cat $FILENAME)

for LINE in $LINES
 do
 samtools view alignments/${ACCESSION}_minimap2.bam $LINE | cut -f1,10 | sed 's/^/>/' | sed 's/\t/\n/' | sed 's/\t/\n+\n/' >> filtered_Asco_reads/${ACCESSION}_Asco_reads.fasta
 done

#change fasta headers
cat filtered_Asco_reads/${ACCESSION}_Asco_reads.fasta | awk -v var="${ACCESSION2}" '/^>/{print ">"var"_read" ++i; next}{print}' > filtered_Asco_reads/${ACCESSION}_Asco_reads_1.fasta

#remove any lines with empty sequences, reverses it, removes lines with asterisk plus following lines they flips it right way
tac filtered_Asco_reads/${ACCESSION}_Asco_reads_1.fasta | sed '/\*/I,+1 d' | tac > ${ACCESSION}_Asco_reads_2.fasta
