#!/usr/bin/Rscript

#-- libraries
library(stringr)
library(GenomicRanges)
library(biomaRt)
library(EDASeq)

#-- functions
count2tpm <- function(counts,len) {
  x <- counts/len
  return(t(t(x)*1e6/colSums(x)))
}


#-- input
arg=commandArgs(TRUE)
# read the transcriptome profile
counts <- read.table(arg[[1]], header=TRUE, sep='\t', row.names=1,check.names=FALSE)
# method name
method_name=arg[[3]]

#-- main
# read gene length table
output=arg[[2]]
db_dir=arg[[4]]
output_dir <- str_replace(output, "/[^/]+\\.csv$", "/")
tmp=list.files(db_dir)
tmp=tmp[grep("^gene_lengths_",tmp)]
glength_edaseq <- read.table(paste(db_dir,tmp, sep="/"), header=TRUE, row.names = 1, sep=',')

# extract gene lengths and map them to the genes of the profile
glength <- glength_edaseq[order(match(rownames(glength_edaseq), rownames(counts))),1]
# compute TPM normalized profile
tpm=count2tpm(counts,glength)
# compute log2(1+TPM) normalized profile
log2tpm=log2(1+tpm)
# compute log2(1+counts) normalized profile
log2counts=log2(1+counts)

# prepare output format
sample_name = toString(colnames(counts))
#sample_name = substr(sample_name,2,nchar(sample_name))
Header=paste("GENCODE", sample_name, sep='\t')
putHeader=paste( "sed -i \'1s/^/",Header,"\\n/\' ", arg[[2]], sep="")


##-- output
if(method_name=="v1_rm500" || method_name=="v1_rm500dropout" || method_name=="transcuptomics_knn" || method_name=="transcuptomics_rf"){
  write.table(tpm, arg[[2]], sep='\t' , quote=FALSE, col.names=FALSE); system(putHeader)}
if(method_name=="cuppa"){
  write.table(log2tpm, arg[[2]], sep='\t', quote=FALSE, col.names=FALSE);system(putHeader)}
#if(method_name=="cupaidx"){
  #write.table(log2counts,arg[[2]], sep='\t' , quote=FALSE, col.names=FALSE);system(putHeader)}