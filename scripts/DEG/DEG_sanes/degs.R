source("/storage/chen/home/u244187/TM_project/tm_culture_fn.R")
# source("/storage/chen/data_share_folder/22_10x_hs_AnteriorSegment_data/scAtacQC/R_functions_scATAC.R")

library(Seurat)
library(tidyverse)

#user parameters
# prefix; dirOut; finrds; 
if(F){
dirOut ="/storage/chentemp/alice/TM_project/DEG"
finrds="/storage/chentemp/alice/TM_project/reclustering/TM_culture_wharmony_reclustered.rds"
prefix="TM_culture"
}

# input arguments
#if(F){
args = commandArgs(trailingOnly=TRUE)
print(args)
if (length(args)!=3) {
  stop("please type 3 parameters:dirIn, finrds, prefix, and mkerList", call.=FALSE)
} else {
  # default output file
  dirOut    <- args[1]
  finrds   <- args[2]
  prefix   <- args[3]
  cat("input #= ",length(args),"\n")
}

# load object
obj_data <- readRDS(finrds)
# run DEGs
objA.markers <- runDEGs_afterCT(objectA=obj_data, prefix = prefix, dirOut = dirOut)
