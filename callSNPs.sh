#!/bin/bash

"""
Script to process all the commands (primarily samtools) to create a text file of
single nucleotide polymorphisms between a DNA sequence and a reference

run command: i.e. bash callSNPs.sh dichotoma dichotoma.fa finola_SRR352927.fastq
PARAMETERS: organism name, reference FASTA file, DNA sequence file

Ezra Huscher
Kane Lab, University of Colorado Boulder

last updated March 2017
"""

# example run: bash callSNPs.sh dichotoma dichotoma.fa finola_SRR352927.fastq
name=$1
ref=$2
fastq1=$3
fastq2=$4

# 2.) Convert to fastq (would make two files for paired end reads)
#fastq-dump -SL --split-3 $name.sra  # for paired ends, should also work if single end

# 3.) Aligning reads to a reference      
bwa index $ref
bwa mem -t 8 -k 13 -B 2 -O 2 -L 3 $ref $fastq1 $fastq2 > $name.sam   # use -t 8 to use 8 cores

# 4.) SNP and indel calling
samtools view -b -o $name.bam -S $name.sam
samtools sort $name.bam $name.sorted

#if [ $fastq2 -ne "" ]
#then
#samtools merge # combine multiple sorted bams?
#fi

samtools index $name.sorted.bam
samtools faidx $ref
#samtools tview $name.sorted.bam $ref
samtools mpileup -uf $ref $name.sorted.bam | bcftools view -bvcg - > $name.bcf
bcftools view $name.bcf > $name_snps_indels.vcf
#awk '$6 >= 100' $name_snps_indels.vcf | grep -v '##' | grep -v 'INDEL' > allSNP.txt

#samtools mpileup -f $ref $name.sorted.bam > $name.mpileup
#awk '$4 > 0{print $1}' I_stenanthum99_1.sam | uniq > mappedReadsList.txt
#grep -A3 --no-filename --no-group-separator -Ff mappedReadsList.txt ${library_input1}.fastq > mappedReads_1.fastq
#grep -A3 --no-filename --no-group-separator -Ff mappedReadsList.txt ${library_input2}.fastq > mappedReads_2.fastq
