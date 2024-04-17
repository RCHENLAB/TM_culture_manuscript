library(Seurat)
library(ggplot2)

TM_Culture <- readRDS("/storage/chentemp/alice/TM_project/reclustering/TM_culture_wharmony_reclustered.rds")

#p=VlnPlot(TM_Culture, features=c('nFeature_RNA', 'nCount_RNA', 'percent.mt'), group.by = "sampleid", ncol=3, pt.size=0)+theme(axis.text.x = element_text(angle = 90, vjust = 0.5),axis.text = element_text(size = 16))
#png(paste0("combined_vlnplot_2.png"),height=800,width=4000)
#par(mfrow=c(1,3))
p1=VlnPlot(TM_Culture, features='nFeature_RNA', group.by = "sampleid", pt.size=0)+theme(axis.text.x = element_text(angle = 90, vjust = 0.5),axis.text = element_text(size = 18),legend.position = "none")
p2=VlnPlot(TM_Culture, features='nCount_RNA', group.by = "sampleid", pt.size=0)+theme(axis.text.x = element_text(angle = 90, vjust = 0.5),axis.text = element_text(size = 18),legend.position = "none")
p3=VlnPlot(TM_Culture, features='percent.mt', group.by = "sampleid", pt.size=0)+theme(axis.text.x = element_text(angle = 90, vjust = 0.5),axis.text = element_text(size = 18),legend.position = "none")


png(paste0("nFeature_RNA.png"),height=800,width=600)
print(p1)
dev.off()

png(paste0("nCount_RNA.png"),height=800,width=600)
print(p2)
dev.off()

png(paste0("percent.mt.png"),height=800,width=600)
print(p3)
dev.off()
