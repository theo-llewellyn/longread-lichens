#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=16:mem=124gb

#get name of contigs file
ACCESSION=LIQ254RAFAR_Flye_sup

module load anaconda3/personal
source activate RepeatModeler

cd $PBS_O_WORKDIR

## add dirs to @INC
export PERL5LIB=${PERL5LIB}:/rds/general/user/tbl19/home/perl5/lib/perl5:/rds/general/user/tbl19/home/anaconda3/envs/RepeatModeler/lib/perl5/site_perl/5.32.0/x86_64-linux/:/rds/general/user/tbl19/home/anaconda3/envs/RepeatModeler/lib/perl5/site_perl/5.32.0:/rds/general/user/tbl19/home/anaconda3/envs/RepeatModeler/lib/perl5/5.32.0/x86_64-linux:/rds/general/user/tbl19/home/anaconda3/envs/RepeatModeler/lib/perl5/5.32.0
## check @INC
perl -V

RepeatMasker \
 -e ncbi \
 -lib ${ACCESSION}-families.fa \
 -pa 16 \
 -xsmall \
 -dir ${ACCESSION}_masked \
 -alignments \
 ${ACCESSION}_Asco_redundans_headers_filtered_sorted.fa

conda deactivate
