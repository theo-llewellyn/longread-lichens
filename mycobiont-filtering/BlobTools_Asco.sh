#PBS -l walltime=03:00:00
#PBS -l select=1:ncpus=8:mem=96gb

module load anaconda3/personal
source activate blobtools

ACCESSION=LIQ254RAFAR_Flye_sup_Asco
ACCESSION2=LIQ254RAFAR

cd $PBS_O_WORKDIR

#taxify results of diamond using the taxid_mapping file to link GCA to NCBI taxonomy numbers
/rds/general/user/tbl19/home/blobtools/blobtools taxify \
 -f /rds/general/project/theollewellynproject/live/BlobTools/diamond_output/${ACCESSION}.vs.uniref90.diamond \
 -m /rds/general/project/theollewellynproject/live/BlobTools/uniref90.fasta.taxlist \
 -s 0 -t 1

mv /rds/general/project/theollewellynproject/live/BlobTools/${ACCESSION}.vs.uniref90.diamond.taxified.out /rds/general/project/theollewellynproject/live/BlobTools/diamond_output/

#taxify results of blast linking to wgs nucleotide taxids
/rds/general/user/tbl19/home/blobtools/blobtools taxify \
 -f /rds/general/project/theollewellynproject/live/BlobTools/blast_output/${ACCESSION}.vs.Lecanoromycetes_genomes.blastn \
 -m /rds/general/project/theollewellynproject/live/BlobTools/nucl_wgs.accession2taxid_xan \
 -s 1 -t 2

mv /rds/general/project/theollewellynproject/live/BlobTools/${ACCESSION}.vs.Lecanoromycetes_genomes.blastn.taxified.out /rds/general/project/theollewellynproject/live/BlobTools/blast_output/

mkdir /rds/general/project/theollewellynproject/live/BlobTools/${ACCESSION}_blobtools.out

#create the blobDB with input, -t hits files for uniprot and lichens
/rds/general/user/tbl19/home/blobtools/blobtools create \
 -i /rds/general/project/theollewellynproject/live/flye_sup_Asco_assembly_${ACCESSION2}/assembly.fasta \
 -b /rds/general/project/theollewellynproject/live/alignments/${ACCESSION}_minimap2.bam \
 -t /rds/general/project/theollewellynproject/live/BlobTools/diamond_output/${ACCESSION}.vs.uniref90.diamond.taxified.out \
 -t /rds/general/project/theollewellynproject/live/BlobTools/blast_output/${ACCESSION}.vs.Lecanoromycetes_genomes.blastn.taxified.out \
 -o ${ACCESSION}_blobtools.out/${ACCESSION}_blobplot

#create a view of the blobDB, at family rank, default is phylum
/rds/general/user/tbl19/home/blobtools/blobtools view \
 -i ${ACCESSION}_blobtools.out/${ACCESSION}_blobplot.blobDB.json \
 -r phylum \
 -o ${ACCESSION}_blobtools.out/

#create the blobplot colouring by family and plotting unwanted ones first
/rds/general/user/tbl19/home/blobtools/blobtools plot \
 -i ${ACCESSION}_blobtools.out/${ACCESSION}_blobplot.blobDB.json \
 -o ${ACCESSION}_blobtools.out/ \
 -r phylum \
 -m \
 --sort_first no-hit,other 

conda deactivate
