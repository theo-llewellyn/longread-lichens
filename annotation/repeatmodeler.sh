#PBS -l walltime=72:00:00
#PBS -l select=1:ncpus=5:mem=96gb

#get name of contigs file
ACCESSION=LIQ254RAFAR_Flye_sup

module load anaconda3/personal
#source activate funannotate

cd $PBS_O_WORKDIR

export FUNANNOTATE_DB=/rdsgpfs/general/user/tbl19/home/anaconda3/envs/funannotate/funannotate_db

funannotate sort \
 -i  /rds/general/project/theollewellynproject/live/LIQ254RAFAR_ONT_data/${ACCESSION}_Asco_redundans_headers_filtered.fa \
 -o  /rds/general/project/theollewellynproject/live/LIQ254RAFAR_ONT_data/${ACCESSION}_Asco_redundans_headers_filtered_sorted.fa

source activate RepeatModeler

#build database
/rds/general/user/tbl19/home/software/RepeatModeler/BuildDatabase \
 -name /rds/general/project/theollewellynproject/ephemeral/RepeatModeler/${ACCESSION} \
 /rds/general/project/theollewellynproject/live/LIQ254RAFAR_ONT_data/${ACCESSION}_Asco_redundans_headers_filtered_sorted.fa

## add dirs to @INC
export PERL5LIB=${PERL5LIB}:/rds/general/user/tbl19/home/perl5/lib/perl5:/rds/general/user/tbl19/home/anaconda3/envs/RepeatModeler/lib/perl5/site_perl/5.32.0/x86_64-linux/:/rds/general/user/tbl19/home/anaconda3/envs/RepeatModeler/lib/perl5/site_perl/5.32.0:/rds/general/user/tbl19/home/anaconda3/envs/RepeatModeler/lib/perl5/5.32.0/x86_64-linux:/rds/general/user/tbl19/home/anaconda3/envs/RepeatModeler/lib/perl5/5.32.0
## check @INC
perl -V

#run repeatmodeller
/rds/general/user/tbl19/home/software/RepeatModeler/RepeatModeler \
 -database /rds/general/project/theollewellynproject/ephemeral/RepeatModeler/${ACCESSION} \
 -pa 1 -LTRStruct >& /rds/general/project/theollewellynproject/ephemeral/RepeatModeler/${ACCESSION}.out

conda deactivate
