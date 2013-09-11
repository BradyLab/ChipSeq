data_path= #change to some path where your data is stored
           ##need full data path

WT= #header name of WT files
KO= #header name of KO files
index= # name of index file

##################################################
############## Convert sra to fastq ##############
##################################################


path_to_files=${path_to_files}/

#################################################
############### Quality Control #################
#################################################

#Before
#TODO find out why can only do from this dir
## will do all in file
./FastQC/fastqc ${path_to_files}*.fastq

#Script to loop though trim reads
#trimReads -q 20 -m 20 -f ${data_path}/adapters.fasta ${WT_path}.fastq
python loop_trimreads.py -p ${path_to_files}

#################################################
################### BWA #########################
#################################################


#### maybe rewrite so it loops though files and paralizes it.!!!
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

python chipseq_peak.py \
  -e ${data_path}/sorted-${KO}.sam-W200-G${best_gap}-E0.001.scoreisland
  -c ${data_path}/sorted-${WT}_head.sam-W200-G${best_gap}-E0.001.scoreisland 
  --pad 1000
  --genes ## file with start stop postion for genes/ bed file
  -o ## name of output file

