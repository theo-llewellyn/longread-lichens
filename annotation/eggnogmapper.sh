#!/bin/sh
#$ -cwd           	# Set the working directory for the job to the current directory
#$ -pe smp 5		# Request 5 cores
#$ -l h_rt=12:00:0 	# Request 12 hours runtime
#$ -l h_vmem=5G   	# Request 5GB RAM
#$ -j y
#$ -m ea

module load anaconda3
conda activate eggnog-mapper

emapper.py 	-i Ramalina_farinacea.proteins.fa \
		-m diamond \
		-o Ramalina_farinacea_proteins \
		--output_dir eggnog-mapper \
		--cpu ${NSLOTS}
