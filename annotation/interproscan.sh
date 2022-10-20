#!/bin/sh
#$ -cwd
#$ -pe parallel 48
#$ -l infiniband=sdv-i
#$ -l h_rt=240:0:0
#$ -j y
#$ -m ea

module load java/11.0.2

/data/scratch/btx494/interproscan-5.57-90.0/interproscan.sh \
	-i Ramalina_farinacea.proteins.fa \
	-o Ramalina_farinacea_proteins_interproscan.xml \
	-appl CDD,COILS,Gene3D,HAMAP,MobiDBLite,PANTHER,Pfam,Phobius,PIRSF,PRINTS,SignalP_EUK,SFLD,SMART,SUPERFAMILY,TIGRFAM \
	-f xml \
	-goterms \
	-pa \
	-cpu ${NSLOTS}
