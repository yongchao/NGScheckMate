# NGScheckMate
the snakemake pipeline for the NGScheckMate

Loading the MoTrPAC RNA-seq environment

1. Build a bam folder that has the soft links of the all bam files
2. Build a NGScheckmate folder at the same level of bam folder
3. go to the sub folder  NGScheckmate, use the following commands

Snakemake_lsf.sh -- -s {NGScheckMate githubfolder}/NGSCheckMate.snakefile --config idir=../bam
