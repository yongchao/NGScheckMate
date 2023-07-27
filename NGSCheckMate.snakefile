include: "sample_sub.snakefile"
    
samples=get_samples(".bam")
root="/sc/arion/projects/sealfs01a/local/NGSCheckmate"
rule allsamples:
    input:expand("vcf/{sample}.vcf",sample=samples)
    output:"log/OK.all"
    shell:
        '''
        ml bcftools/1.9
        python2 {root}/src/ncm.py -V -d vcf -bed {root}/ref_data/hg38/SNP.bed -O .
        '''
    
rule onesample:
    input:idir+"{sample}.bam"
    output:"vcf/{sample}.vcf"
    shell:
        '''
        if [[ ! -e {input}.bai ]]; then
             samtools index {input}
		fi
        ml bcftools/1.9
        samtools mpileup -I -uf {root}/ref_data/hg38/genome.fa  \
        -l {root}/ref_data/hg38/SNP.bed {input} | bcftools call -c - > {output}
        '''
    
