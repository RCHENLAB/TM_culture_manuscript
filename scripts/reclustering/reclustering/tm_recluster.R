suppressPackageStartupMessages(library(Seurat))

#load object
a <- readRDS("/storage/chentemp/alice/TM_project/harmony/obj_RPE_TMcells_wHarmony_sct.rds")
prefix <- "TM_culture" #make this changeable later

#reclustering
DefaultAssay(a) <- "RNA"
a <- RunUMAP(a, dims = 1:20, reduction = "harmony")
a <- FindNeighbors(a, dims = 1:20, reduction = "harmony")
a <- FindClusters(a, resolution = 0.1)

p <- DimPlot(a, reduction = "umap")

setwd("/storage/chentemp/alice/TM_project/reclustering")
png(paste0("02","_plot_umap_",prefix,"_wharmony_reclustered.png"))
print(p)
dev.off()

a <- saveRDS(a, "TM_culture_wharmony_reclustered.rds")
