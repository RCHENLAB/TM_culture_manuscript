#source("/storage/chen/home/sangbaek/pipeline/pipeline_taco/R_script/Retina_function_cellmarker.R",encoding="UTF-8")
#source("/storage/chen/home/sangbaek/pipeline/pipeline_taco/R_script/Retina_cellmarkerList.R",encoding="UTF-8")
source("/storage/chen/data_share_folder/22_10x_hs_AnteriorSegment_data/scAtacQC/R_functions_scATAC.R")

library(Seurat)
library(dplyr)
library(Matrix)
library(ggplot2)
library(reticulate)

#user parameters
# newCellTypes; objectA; prefix; dirOut;rsN; 
if(F){
dirIn ="/storage/chentemp/alice/TM_project/reclustering"
finrds="TM_culture_wharmony_reclustered.rds"
prefix="TM_culture"
mkerList="C1OB,MSR1,MARCO,NKG7,KLRB1,CD3D,KRT5,SFN,AOP5,MLANA,PMEL,TYRP1,L1CAM,NGFR,SOX2,PLP1,MPZ,DCN,PDGFRA,TAGLN,ACTA2,DES,MYH11,RGS5,PDGFRB,VWF,FLT1,DLL4,KDR,PECAM1,MMRN1,FLT4,PROX1" # split by ,
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
  mkerList <- args[4]
  cat("input #= ",length(args),"\n")
}

#}
# read markers
#print(mode(mkerList))
mkers<-strsplit(mkerList,",")[[1]]

print(mkers)
#print(mode(mkers))

ya<-round((length(mkers)/4))*300
xl<-round((length(mkers)/7))+5
# creat outdir
# process
dirOut <- "out_check_knownMarkers"
dirOut <- setDir(dirIn, dirOut)

# read rds
setwd(dirIn)
obj_data <- readRDS(finrds)
yl<-round(dim(table(obj_data$seurat_clusters))/6)+5


# plots
# plot
setwd(dirOut)
p1 <- DimPlot(obj_data, label = TRUE, repel = TRUE)
setwd(dirOut)
png(paste0("01_plot_umap_classf_",prefix,".png"),width = 400, height = 400)
  print(p1 + ggtitle(paste0("UMAP-",prefix)))
dev.off()

# dotplot
p2<- DotPlot(object = obj_data, features = mkers, dot.scale = xl, assay = "RNA", group.by = "scpred_no_rejection",col.min = 0, scale.max = 80, cols = c("gray","magenta1")) + RotatedAxis() + 
  theme(axis.text.x = element_text(angle = 45,hjust=1)) +
  theme(panel.grid.major = element_line(colour = "grey95", size = (.1))) #+ coord_flip

setwd(dirOut)
pdf(paste0("02_plot_dot_markers","_",prefix,"_mk3.pdf"), width = xl, height = yl)
  print(p2 + ggtitle(paste0("Dotplot-",prefix))) 
dev.off()

p3 <-VlnPlot(object = obj_data, features = mkers, pt.size=0, ncol = 4)
setwd(dirOut)
png(paste0("03_plot_vlin_",prefix,"_mk.png"),width = 1200, height = (ya+300))
  print(p3)+print(p1)
dev.off()

p4 <- FeaturePlot(obj_data,features = mkers,pt.size=0, ncol = 4)
setwd(dirOut)
png(paste0("04","_plot_feature_",prefix,"_mk.png"),width = 1200, height =(ya+300))
  print(p4)+print(p1)
dev.off()

# save history
setwd(dirOut)
savehistory(file=paste0("log_checkMarkers_",prefix,".Rhistory"))
cat("Process was done! \n")
	





