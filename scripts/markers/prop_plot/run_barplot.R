library(dittoSeq)
library(Seurat)
library(ggplot2)

# user's parameters
dirIn  <- "/storage/chentemp/alice/TM_project/final_figs/out_assign_CellType"
finrds <- "obj_TM_culture_wCTannot_2.rds"
prefix <- "TM_Culture_reassigned"
dirOut <- "/storage/chentemp/alice/TM_project/final_figs/prop_plot"
#
# category in metadata to generate
# - i.g. "seurat_clusters","celltype","subset"
#-------------------

# load data
setwd(dirIn)
objA <- readRDS(finrds)

#get cluster names
cluster_names <- Idents(objA)
objA$cluster_names <- cluster_names

# dittoseq plot
## cell proportion
p1 <- dittoBarPlot(objA, "cluster_names", group.by = "orig.ident",ylab="Proportion of cells")+theme(text = element_text(size = 20),axis.text.x = element_text(angle = 90, vjust = 0.5))
p2 <- dittoBarPlot(objA, "cluster_names", group.by = "subset",ylab="Proportion of cells")+theme(text = element_text(size = 20),axis.text.x = element_text(angle = 90, vjust = 0.5),legend.text=element_text(size=20))

# plot
setwd(dirOut)
png(paste0("plot_bar_orig_ident",prefix,".png"), width=600, height=800)
  print(p1)
dev.off()

setwd(dirOut)
png(paste0("plot_bar_subset_",prefix,".png"), width=1000, height=800)
  print(p2)
dev.off()

print("process was done!")

