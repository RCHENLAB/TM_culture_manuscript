#!/usr/bin/bash

# user parameters
dirIn="/storage/chentemp/alice/TM_project/reclustering"   
finrds="TM_culture_wharmony_reclustered.rds"  
prefix="TM_culture"  
#mkerList="c('CD163','LYVE1','CD96','CD69','CPA3','SCN7A','LGI4','CDH3','TYR','SPP1','PECAM1','VWF','CCL21','PIEZO2','PLAT','FN1','POU6F2','CA10','DCC','TWIST2','COL6A3','RSPO4','SLC4A10','MYOC','APOD','BMP5','EYA1','CHRM3','DGKI','ADCY3','NOTCH3','KRT14','TENM2','KRT3','MUC5AC','AGR3','KRT24','PIGR','CEACAM6','KRT13','NUPR1')"
mkerList="PAX6,JCHAIN,CD163,NKG7,CPA3,CA3,COL14A1,PLVAP,ALPL,TFF3,ANGPTL7,BMP5,TMEFF2,CHRM3,NDUFA4L2,TYRP1,SCN7A,PRX,SYT1"

# log out
  
# run r script
Rscript --vanilla run_chkMakers.R $dirIn $finrds $prefix $mkerList 

