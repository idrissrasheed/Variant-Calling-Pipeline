#variables for the reference sequence
bwa_ref="/home/idrisr/tiny-test-data/genomes/Hsapiens/hg19/bwa/hg19.fa"
sam_ref="/home/idrisr/tiny-test-data/genomes/Hsapiens/hg19/seq/hg19.fa"

#variable to avoid hardcoding into pipeline
sample_name=$1
echo $sample_name

#align to reference genome
bwa mem $bwa_ref ${sample_name}_1.fq.gz ${sample_name}_2.fq.gz > $sample_name.sam

#sort same file
samtools sort ${sample_name}.sam > ${sample_name}_s.sam

#variant calling
samtools mpileup -Ou -f $sam_ref ${sample_name}_s.sam | bcftools call -vmO v -o ${sample_name}.vcf

#print the variants
cat ${sample_name}.vcf