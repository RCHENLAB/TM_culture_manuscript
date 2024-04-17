suppressPackageStartupMessages(library(Seurat))

#load object
a <- readRDS("/storage/chentemp/alice/TM_project/reclustering/TM_culture_wharmony_reclustered.rds")
prefix <- "TM_culture" #make this changeable later

p5 <- DimPlot(a, reduction = "umap", group.by = "Phase")

setwd("/storage/chentemp/alice/TM_project/final_figs")
png(paste0("05","_plot_umap_",prefix,"_wharmony_reclustered_phase.png"),width=850,height=800)
print(p5)
dev.off()

#a <- saveRDS(a, "TM_culture_wharmony_reclustered.rds")
