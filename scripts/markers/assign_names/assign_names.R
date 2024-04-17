source("/storage/chen/home/u244187/TM_project/tm_culture_fn.R")
# source("/storage/chen/data_share_folder/22_10x_hs_AnteriorSegment_data/scAtacQC/R_functions_scATAC.R")

library(Seurat)
library(ggplot2)

#user parameters
# newCellTypes; objectA; prefix; dirOut;rsN;
if(F){
dirIn ="/storage/chentemp/alice/TM_project/reclustering"
finrds="TM_culture_wharmony_reclustered.rds"
prefix="TM_culture"
#new.cluster.List=c("pericyte","pericyte","pericyte","pericyte","pericyte","TM2","TM1","pericyte","pericyte","pericyte")
new_cluster_List = "pericyte,pericyte,pericyte,pericyte,pericyte,TM2,TM1,pericyte,pericyte,pericyte"
}

# input arguments
#if(F){
args = commandArgs(trailingOnly=TRUE)
print(args)
if (length(args)!=4) {
  stop("please type 4 parameters:dirIn, finrds, prefix, and mkerList", call.=FALSE)
} else {
  # default output file
  dirIn    <- args[1]
  finrds   <- args[2]
  prefix   <- args[3]
  new_cluster_List <- args[4]
  cat("input #= ",length(args),"\n")
}

#set dir
dirOut <- "out_assign_CellType"
dirOut <- setDir(dirIn, dirOut)

# read markers
#print(mode(mkerList))
new.cluster.ids<-strsplit(new_cluster_List,",")[[1]]

print(new.cluster.ids)
#print(mode(mkers))

#read rds
setwd(dirIn)
obj_data <- readRDS(finrds)

#assign new names
names(new.cluster.ids) <- levels(obj_data)
obj_data <- RenameIdents(obj_data, new.cluster.ids)

p5 = DimPlot(obj_data, label = TRUE, repel = TRUE, label.size = 8)+theme(axis.text = element_text(size = 20))

setwd(dirOut)
png(paste0("plot_umap_labeled_",prefix,".png"),width = 800, height = 800)
  print(p5 + ggtitle(paste0("UMAP-",prefix)))
dev.off()

#saveRDS(obj_data,paste0("obj_",prefix,"_wCTannot_2.rds"))


