#PBS -l walltime=03:00:00
#PBS -l select=1:ncpus=8:mem=96gb

module load anaconda3/personal
source activate blobtools

ACCESSION=LIQ254RAFAR_Flye_sup

cd $PBS_O_WORKDIR

### PREPARE FILES FOR BLOBPLOT
#make cov file for blobtools
pileup.sh in=medaka/LIQ254RAFAR_Flye_sup_Racon/calls_to_draft.bam out=medaka/LIQ254RAFAR_Flye_sup_Racon/stats.txt
perl -lane 'BEGIN{print "# contig_id\tread_cov\tbase_cov"}if(/#/){next}else{$reads=($F[6]+$F[7]);print join("\t",$F[0],$reads,$F[1])}' medaka/LIQ254RAFAR_Flye_sup_Racon/stats.txt > medaka/LIQ254RAFAR_Flye_sup_Racon/calls_to_draft.sam.cov

#filter input files for blobtools
#make an empty new coverage to populate with filtered data
echo -e '# contig_id\tread_cov\tbase_cov' > LIQ254RAFAR_ONT_data/${ACCESSION}_medaka_Blobtools3rounds.sam.cov

while read contig; do
 #make filtered coverage file
 grep -w $contig medaka/LIQ254RAFAR_Flye_sup_Racon/calls_to_draft.sam.cov >> LIQ254RAFAR_ONT_data/${ACCESSION}_medaka_Blobtools3rounds.sam.cov
 
 #make filtered diamond file
 #grep -w $contig BlobTools/diamond_output/${ACCESSION}_Asco_redundans.vs.uniref90.diamond.taxified.out >> BlobTools/diamond_output/${ACCESSION}_medaka_BlobTools3rounds.vs.uniref90.diamond.taxified.out
 
 #make filtered blast file
 #grep -w $contig BlobTools/blast_output/${ACCESSION}_Asco_redundans.vs.Lecanoromycetes_genomes.blastn.taxified.out >>  BlobTools/blast_output/${ACCESSION}_medaka_BlobTools3rounds.vs.Lecanoromycetes_genomes.blastn.taxified.out
 #grep -w $contig BlobTools/blast_output/${ACCESSION}_Asco_redundans.vs.nt.blastn.taxified.out >>  BlobTools/blast_output/${ACCESSION}_medaka_BlobTools3rounds.vs.nt.blastn.taxified.out

done < LIQ254RAFAR_ONT_data/${ACCESSION}_Asco_redundans_headers_filtered.txt


### CREATE BLOBPLOT
mkdir /rds/general/project/theollewellynproject/live/BlobTools/${ACCESSION}_medaka_BlobTools3rounds_blobtools.out

#create the blobDB with input, -t hits files for uniprot and lichens
/rds/general/user/tbl19/home/blobtools/blobtools create \
 -i /rds/general/project/theollewellynproject/live/LIQ254RAFAR_ONT_data/${ACCESSION}_Asco_redundans_headers_filtered.fa \
 -c /rds/general/project/theollewellynproject/live/LIQ254RAFAR_ONT_data/${ACCESSION}_medaka_Blobtools3rounds.sam.cov \
 -t /rds/general/project/theollewellynproject/live/BlobTools/diamond_output/${ACCESSION}_medaka_BlobTools3rounds.vs.uniref90.diamond.taxified.out \
 -t /rds/general/project/theollewellynproject/live/BlobTools/blast_output/${ACCESSION}_medaka_BlobTools3rounds.vs.nt.blastn.taxified.out \
 -t /rds/general/project/theollewellynproject/live/BlobTools/blast_output/${ACCESSION}_medaka_BlobTools3rounds.vs.Lecanoromycetes_genomes.blastn.taxified.out \
 -o ${ACCESSION}_medaka_BlobTools3rounds_blobtools.out/${ACCESSION}_blobplot

#create a view of the blobDB, at family rank, default is phylum
/rds/general/user/tbl19/home/blobtools/blobtools view \
 -i ${ACCESSION}_medaka_BlobTools3rounds_blobtools.out/${ACCESSION}_blobplot.blobDB.json \
 -r family \
 -o ${ACCESSION}_medaka_BlobTools3rounds_blobtools.out/

#create the blobplot colouring by family and plotting unwanted ones first
/rds/general/user/tbl19/home/blobtools/blobtools plot \
 -i ${ACCESSION}_medaka_BlobTools3rounds_blobtools.out/${ACCESSION}_blobplot.blobDB.json \
 -o ${ACCESSION}_medaka_BlobTools3rounds_blobtools.out/ \
 -r family \
 -m \
 --sort_first no-hit,other 

conda deactivate
