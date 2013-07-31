data_path= #change to some path where your data is stored
           ##need full data path

WT= #header name of WT files
KO= #header name of KO files


##################################################
############## Convert sra to fastq ##############
##################################################

fastq-dump ${data_path}/${WT}.sra
fastq-dump ${data_path}/${KO}.sra

WT_path=${data_path}/${WT}
KO_path=${data_path}/${KO}


#################################################
############### Quality Control #################
#################################################

#Before
#TODO find out why can only do from this dir
./FastQC/fastqc ${WT_path}.fastq
./FastQC/fastqc ${KO_path}.fastq

#Trim and QC
trimReads -q 20 -m 20 -f ${data_path}/adapters.fasta ${WT_path}.fastq
trimReads -q 20 -m 20 -f ${data_path}/adapters.fasta ${KO_path}.fastq

#After
./FastQC/fastqc ${WT_path}.trimmed.fastq
./FastQC/fastqc ${KO_path}.trimmed.fastq


#################################################
################### BWA #########################
#################################################

python aln_bwa.py -n ${WT_path}.trimmed -i ${data_path}/${index}
python aln_bwa.py -n ${KO_path}.trimmed -i ${data_path}/${index}


#TODO add code for removing dups
#################################################
################### SICER #######################
#################################################

mkdir ${data_path}/SICER_res/
python determine_gapsize.py --ko ${data_path}/sorted-${KO}.sam.bed --wt ${data_path}/sorted-${WT}.sam.bed -w 200 -o ${data_path}/SICER_res

#run graph_gap_size.R 
#TODO make a wrapper for this

#run with best parmas
best_gap=800
sh ~/Downloads/SICER_V1.1/SICER/SICER-df-rb.sh ${data_path}/sorted-${KO}.sam.bed ${data_path}/sorted-${WT}_head.sam.bed 200 ${best_gap} 0.1 0.001 > $data_path/SICER_res/


#################################################
############## Gene enrichment ##################
#################################################



