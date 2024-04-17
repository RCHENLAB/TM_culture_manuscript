
### set dir -----
setDir <- function(dirIn, dirOut){
  setwd(dirIn)
  dirIn <- getwd()

  if(!file.exists(dirOut))
    dir.create(dirOut)
  setwd(dirOut)
  dirOut <- getwd()
  cat("dirOut: ",dirOut,"\n")
  return(dirOut)
}

##function - runSeurat2h5ad
# converts seurat object to .h5ad
# usage: objectA <- runSeurat2h5ad(objectA,dirOut,prefix)
# libraries: sceasy,reticulate

runSeurat2h5ad<- function(objectA,dirOut,prefix){
  setwd(dirOut)
  sceasy::convertFormat(objectA, from="seurat", to="anndata", main_layer ="counts",outFile=paste0('obj_',prefix,'_counts.h5ad')) #option: "counts", "data","scale.data"
  return(objectA)
}

##function - runH5ad2Seurat
# converts .h5ad object to seurat object
# usage: objectA <- runH5ad2Seurat(objectA,dirOut,prefix)
# libraries: sceasy

runH5ad2Seurat<- function(objectA,dirOut,prefix){
  setwd(dirOut)
  sceasy::convertFormat(h5ad_file, from="anndata", to="seurat",outFile='filename.rds')
  return(objectA)
}

##function: runCellcyleCorrection
# correct cellcycle of Seurat object
# parameters: objectA-seurat object, prefix, rsN:resolution(default=0.1), dirOut-output dir
# usage: objA <- runCellcyleCorrection(objectA,prefix,rsN=0.1,dirOut)

runCellcyleCorrection <- function(objectA,prefix,rsN,dirOut){
  dn=20;
  # check input parameters
  if(!exists("objectA")||!exists("prefix")||!exists("rsN")||!exists("dirOut")){stop("Please check parameters: objectA,prefix,rsN,dirOut")}

  # set cellcycle genes
  refCC <- "/storage/chen/data_share_folder/22_10x_hs_AnteriorSegment_data/scAtacQC/regev_lab_cell_cycle_genes.txt"
  cc.genes   <- readLines(con = refCC)
  # We can segregate this list into markers of G2/M phase and markers of S phase
  s.genes    <- cc.genes[1:43]
  g2m.genes  <- cc.genes[44:97]

  # cell cycle regression
  # alternative way
  objectA$CC.Difference <- objectA$S.Score - objectA$G2M.Score
  objectA <- ScaleData(objectA, vars.to.regress = "CC.Difference", features = rownames(objectA))
  saveRDS(objectA,paste0("obj_",prefix,"_wCCcorreced.rds"))

  # cell cycle effects strongly mitigated in PCA
  objectA <- NormalizeData(objectA)
  objectA <- ScaleData(objectA,features=rownames(objectA))
  objectA <- FindVariableFeatures(objectA,nfeatures=2000)
  objectA <- RunPCA(objectA, features = VariableFeatures(objectA), nfeatures.print = 10)
  saveRDS(objectA,paste0("obj_",prefix,"_wCCcorreced_wPCA.rds"))
  # when running a PCA on cell cycle genes, actively proliferating cells remain distinct from G1
  # cells however, within actively proliferating cells, G2M and S phase cells group together
  objectA <- RunPCA(objectA, features = c(s.genes, g2m.genes))
  objectA <- RunUMAP(object = objectA, reduction = "pca", dims = c(1:dn))
  # cell clustering
  objectA <- FindNeighbors(object = objectA, reduction = "pca", dims = 1:dn)
  objectA <- FindClusters(objectA, resolution = rsN)

  # plot-umap/phase
  p1a<-DimPlot(objectA)
  p2a<-DimPlot(objectA, group.by = "Phase")
  p3a<-DimPlot(objectA, group.by = "Phase", split.by = "Phase")
  p4a<-PCAPlot(objectA, group.by = "Phase")

  pdf(paste0("4.3_umap_pca_cellcycle_regOut_",prefix,".pdf"))
  print(p1a);print(p2a);print(p3a);print(p4a);
  dev.off()
  # save rds
  setwd(dirOut)
  saveRDS(objectA,paste0("obj_",prefix,"_wCCcorrected.rds") )

  return(objectA)

}

### DEGs ----
runDEGs <- function(objectA, prefix, dirOut){
  # set dir
  subDir <- paste0("out_DEGs_",prefix)
  setwd(dirOut)
  dir.create(subDir)
  setwd(subDir)

  # DEGs
  #Identify conserved cell type markers: for two groups
  DefaultAssay(object = objectA) <- "RNA"
  # scale data
  objectA <- ScaleData(object = objectA)

  #find differentially expressed gene markers for every cluster compared to all remaining cells
  objA.markers <- FindAllMarkers(object = objectA, only.pos = TRUE, min.pct = 0.25, thresh.use = 0.25)
  head(objA.markers)

  # select top 20, 50 genes of each cluster
  aTop2  <- objA.markers %>% group_by(cluster) %>% top_n(2, avg_log2FC)
  aTop5  <- objA.markers %>% group_by(cluster) %>% top_n(5, avg_log2FC)
  aTop10 <- objA.markers %>% group_by(cluster) %>% top_n(10, avg_log2FC)
  aTop50 <- objA.markers %>% group_by(cluster) %>% top_n(50, avg_log2FC)
  aTop100 <- objA.markers %>% group_by(cluster) %>% top_n(100, avg_log2FC)

  # write table - top50 markers
  write.csv(aTop50, paste0("out_top50markers_eachCluster_",prefix,".csv"),row.names= F)
  write.csv(aTop100, paste0("out_top100markers_eachCluster_",prefix,".csv"), row.names= F)

  #save - DEG.obj
  saveRDS(objA.markers,paste0("objA.marker_",prefix,".rds"))

# Heatmap
  pdf(paste0("1.1_plot_heatmap_top10_",prefix,"2.pdf"), height = 20)
  print(DoHeatmap(object = objectA, features = aTop10$gene) + NoLegend())
  dev.off()

  pdf(paste0("1.2_plot_heatmap_top10_by100cells_",prefix,".pdf"), height = 20)
  print(DoHeatmap(object = subset(objectA,downsample=500), features = aTop10$gene) + NoLegend())
  dev.off()

  # plot_dot_top5
  wd <- length(unique(aTop5$gene))
  wd <- ceiling(wd/2.3)
  pdf(paste0("1.3.plot_dot_markers_top5_",prefix,"_1.pdf"), height=4,width = wd)
  print(DotPlot(object = objectA, features = rev(x = unique(aTop5$gene)), dot.scale = 8, assay = "RNA", col.min = 0) + RotatedAxis())
  dev.off()

  wd1 <- length(unique(aTop10$gene))
  wd1 <- ceiling(wd1/2.3)
  pdf(paste0("1.4.plot_dot_markers_top10_",prefix,".pdf"), height=4,width = wd1)
  print(DotPlot(object = objectA, features = rev(x = unique(aTop10$gene)), dot.scale = 8, assay = "RNA", col.min = 0) + RotatedAxis())
  dev.off()

  return(objA.markers)
}
# test DEGs
# runDEGs(objectA,prefix = "test",dirOut = dirOut)


### DEGs ----
runDEGs_afterCT <- function(objectA, prefix, dirOut){
  # set dir
  subDir <- paste0("out_DEGs_",prefix)
  setwd(dirOut)
  dir.create(subDir)
  setwd(subDir)

  # DEGs
  #Identify conserved cell type markers: for two groups
  DefaultAssay(object = objectA) <- "RNA"
  # scale data
  objectA <- ScaleData(object = objectA)

  #find differentially expressed gene markers for every cluster compared to all remaining cells
  objA.markers <- FindAllMarkers(object = objectA, only.pos = TRUE, min.pct = 0.25, thresh.use = 0.25)
  head(objA.markers)

  # select top 20, 50 genes of each cluster
  aTop2  <- objA.markers %>% group_by(cluster_names) %>% top_n(2, avg_log2FC)
  aTop5  <- objA.markers %>% group_by(cluster_names) %>% top_n(5, avg_log2FC)
  aTop10 <- objA.markers %>% group_by(cluster_names) %>% top_n(10, avg_log2FC)
  aTop50 <- objA.markers %>% group_by(cluster_names) %>% top_n(50, avg_log2FC)
  aTop100 <- objA.markers %>% group_by(cluster_names) %>% top_n(100, avg_log2FC)

  # write table - top50 markers
  write.csv(aTop50, paste0("out_top50markers_eachCluster_",prefix,".csv"),row.names= F)
  write.csv(aTop100, paste0("out_top100markers_eachCluster_",prefix,".csv"), row.names= F)

  #save - DEG.obj
  saveRDS(objA.markers,paste0("objA.marker_",prefix,".rds"))

# Heatmap
  pdf(paste0("1.1_plot_heatmap_top10_",prefix,"2.pdf"), height = 20)
  print(DoHeatmap(object = objectA, features = aTop10$gene) + NoLegend())
  dev.off()

  pdf(paste0("1.2_plot_heatmap_top10_by100cells_",prefix,".pdf"), height = 20)
  print(DoHeatmap(object = subset(objectA,downsample=500), features = aTop10$gene) + NoLegend())
  dev.off()

  # plot_dot_top5
  wd <- length(unique(aTop5$gene))
  wd <- ceiling(wd/2.3)
  pdf(paste0("1.3.plot_dot_markers_top5_",prefix,"_1.pdf"), height=4,width = wd)
  print(DotPlot(object = objectA, features = rev(x = unique(aTop5$gene)), dot.scale = 8, assay = "RNA", col.min = 0) + RotatedAxis())
  dev.off()

  wd1 <- length(unique(aTop10$gene))
  wd1 <- ceiling(wd1/2.3)
  pdf(paste0("1.4.plot_dot_markers_top10_",prefix,".pdf"), height=4,width = wd1)
  print(DotPlot(object = objectA, features = rev(x = unique(aTop10$gene)), dot.scale = 8, assay = "RNA", col.min = 0) + RotatedAxis())
  dev.off()

  return(objA.markers)
}
# test DEGs
# runDEGs(objectA,prefix = "test",dirOut = dirOut)
