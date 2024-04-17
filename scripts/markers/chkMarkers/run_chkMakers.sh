#!/usr/bin/bash

# user parameters
dirIn="/storage/chentemp/alice/TM_project/reclustering"   
finrds="TM_culture_wharmony_reclustered.rds"  
prefix="TM_culture"  
#mkerList="c('CD163','LYVE1','CD96','CD69','CPA3','SCN7A','LGI4','CDH3','TYR','SPP1','PECAM1','VWF','CCL21','PIEZO2','PLAT','FN1','POU6F2','CA10','DCC','TWIST2','COL6A3','RSPO4','SLC4A10','MYOC','APOD','BMP5','EYA1','CHRM3','DGKI','ADCY3','NOTCH3','KRT14','TENM2','KRT3','MUC5AC','AGR3','KRT24','PIGR','CEACAM6','KRT13','NUPR1')"
mkerList="C1OB,MSR1,MARCO,NKG7,KLRB1,CD3D,KRT5,SFN,AOP5,MLANA,PMEL,TYRP1,L1CAM,NGFR,SOX2,PLP1,MPZ,DCN,PDGFRA,TAGLN,ACTA2,DES,MYH11,RGS5,PDGFRB,VWF,FLT1,DLL4,KDR,PECAM1,MMRN1,FLT4,PROX1"

# log out
  
# run r script
Rscript --vanilla /storage/chen/home/u244187/TM_project/chkMarkers/run_chkMakers.R $dirIn $finrds $prefix $mkerList 


