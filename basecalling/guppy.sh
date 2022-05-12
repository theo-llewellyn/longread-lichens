#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=4:mem=24gb:ngpus=1

module load cuda/10.2

PATH=/rds/general/user/tbl19/home/software/ont-guppy/bin:$PATH
LD_LIBRARY_PATH=/rds/general/user/tbl19/home/software/ont-guppy/lib:$LD_LIBRARY_PATH

cd $PBS_O_WORKDIR

guppy_basecaller \
 -i /rds/general/project/theollewellynproject/live/data/MINION_RAWREADS/LIQ254RAFAR \
 -s /rds/general/project/theollewellynproject/live/Guppy/LIQ254RAFAR_sup \
 -c dna_r9.4.1_450bps_sup.cfg \
 --compress_fastq \
 -x "cuda:0"
 
