#!/bin/sh
#$ -cwd           	# Set the working directory for the job to the current directory
#$ -pe smp 5		# Request 5 cores
#$ -l h_rt=12:00:0 	# Request 12 hours runtime
#$ -l h_vmem=60G   	# Request 60GB RAM
#$ -l highmem
#$ -j y
#$ -m ea

~/funannotate_latest.sif funannotate annotate	--gff Ramalina_farinacea.gff3 \
						--fasta Ramalina_farinacea.scaffolds.fa \
						--species "Ramalina farinacea" \
						--isolate LIQ254RAFAR \
						--eggnog eggnog-mapper/Ramalina_farinacea_proteins.emapper.annotations \
						--iprscan interproscan/Ramalina_farinacea_proteins_interproscan.xml \
						--antismash antismash/Ramalina_farinacea.gbk \
						--rename "OHK93" \
						--sbt template.sbt \
						-o Ramalina_farinacea_functional_annotation \
						--cpus ${NSLOTS}
