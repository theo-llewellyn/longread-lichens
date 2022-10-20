# longread-lichens

Order is 

1. basecalling
2. assembly
3. mycobiont-filtering-round
5. error-correction
6. mycobiont-filtering-round3
7. annotation

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
The following steps remove redundant contigs and error correct the remaining mycobiont reads.
1. `qsub redundans.sh`
2. `qsub Racon.sh`
3. `qsub medaka.sh`

## Mycobiont filtering round 3
`cd mycobiont-filtering-round3`
1. `qsub blastn_Asco_round3.sh`
2. `qsub diamond_Asco_round3.sh`
3. `qsub BlobTools_Asco_round3.sh`
4. `qsub pull_Asco_contigs_round3.sh`

## Annotation

### Structural annotation

*Insert structural annotation instructions here*

### Functional annotation

These scripts were run on Queen Mary University of London's [Apocrita HPC facility](http://doi.org/10.5281/zenodo.438045) which uses the Univa 
Grid Engine batch-queue system.

1. `qsub antismash.sh`
2. `qsub interproscan.sh`
3. `qsub eggnogmapper.sh`
4. `qsub funannotate_annotate.sh`
