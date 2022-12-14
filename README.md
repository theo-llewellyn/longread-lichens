# longread-lichens

Bioinformatic scripts/code for Llewellyn et al. (2022) Whole Genome Sequence and Flow Cytometry Genome Size Data for the Lichen-Forming Fungus Ramalina farinacea (in prep.)

All bash scripts were run on the Imperial College London High Performance Computer except the Functional Annotation section (details below). This HPC uses the PBS queueing system, therefore core/RAM/runtimes in .sh scripts are specified in PBS format. All scripts are written for a single genome file.

Order is 

1. basecalling
2. assembly
3. mycobiont-filtering-round
5. error-correction
6. mycobiont-filtering-round3
7. K-mer profiling
8. annotation

## Basecalling & Assembly

`cd basecalling-assembly`

1. `qsub guppy.sh`
2. `qsub flye.sh`

## Mycobiont filtering
`cd mycobiont-filtering`   
The following commands extract Ascomycota reads belonging to the mycobiont using the BlobTools workflow.
### Round 1
1. `qsub blastn.sh`
2. `qsub diamond.sh`
3. `qsub BlobTools.sh`
4. `qsub pull_Asco_reads.sh`

### Round 2
1. `qsub flye_Asco.sh`
2. `qsub blastn_Asco.sh`
3. `qsub diamond_Asco.sh`
4. `qsub BlobTools_Asco.sh`
5. `qsub pull_Asco_contigs.sh`

## Error correction
`cd error-correction`   
The following steps remove redundant contigs, error correct the remaining mycobiont reads, and produces a final blobplot for the mycobiont assembly.
1. `qsub redundans.sh`
2. `qsub Racon.sh`
3. `qsub medaka.sh`

## Mycobiont filtering round 3
`cd mycobiont-filtering-round3`
1. `qsub blastn_Asco_round3.sh`
2. `qsub diamond_Asco_round3.sh`
3. `qsub BlobTools_Asco_round3.sh`
4. `qsub pull_Asco_contigs_round3.sh`
5. `qsub mycobiont_figure_plot.sh`

## K-mer profiling
`cd kmer-profiling`
1. `qsub jellyfish.sh`
2. Kmer histogram uploaded to GenomeScope online webpage http://qb.cshl.edu/genomescope/

## Annotation

`cd annotation`

### Protein prediction
The following steps identify repeat regions de novo, soft masks them and then annotates proteins.
1. `qsub repeatmodeler.sh`
2. `qsub repeatmasker.sh`
3. `qsub funannotate.sh`

### Structural annotation

*Insert structural annotation instructions here*
1. `qsub tapestry.sh`

### Functional annotation

These scripts were run on Queen Mary University of London's [Apocrita HPC facility](http://doi.org/10.5281/zenodo.438045) which uses the Univa 
Grid Engine batch-queue system.

1. `qsub antismash.sh`
2. `qsub interproscan.sh`
3. `qsub eggnogmapper.sh`
4. `qsub funannotate_annotate.sh`
