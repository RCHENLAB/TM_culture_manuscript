suppressPackageStartupMessages(library(Seurat))

#load object
a <- readRDS("/storage/chentemp/alice/TM_project/reclustering/TM_culture_wharmony_reclustered.rds")
prefix <- "TM_culture" #make this changeable later

p <- DimPlot(a, reduction = "umap")

setwd("/storage/chentemp/alice/TM_project/final_figs")
png(paste0("01","_plot_umap_",prefix,"_wharmony_reclustered.png"))
print(p)
dev.off()

p2 <- DimPlot(a, reduction = "umap", group.by = "sampleid")

setwd("/storage/chentemp/alice/TM_project/final_figs")
png(paste0("02","_plot_umap_",prefix,"_wharmony_reclustered_sampleid.png"))
print(p2)
dev.off()

p3 <- DimPlot(a, reduction = "umap", group.by = "disease")

setwd("/storage/chentemp/alice/TM_project/final_figs")
png(paste0("03","_plot_umap_",prefix,"_wharmony_reclustered_disease.png"))
print(p3)
dev.off()

p4 <- DimPlot(a, reduction = "umap", group.by = "scPred_predictions")

setwd("/storage/chentemp/alice/TM_project/final_figs")
png(paste0("04","_plot_umap_",prefix,"_wharmony_reclustered_scpred.png"))
print(p4)
dev.off()

a <- saveRDS(a, "TM_culture_wharmony_reclustered.rds")
