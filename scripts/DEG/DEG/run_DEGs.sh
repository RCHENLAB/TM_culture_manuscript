#!/usr/bin/bash

# user parameters
dirOut="/storage/chentemp/alice/TM_project/DEG"   
finrds="/storage/chentemp/alice/TM_project/reclustering/TM_culture_wharmony_reclustered.rds"  
prefix="TM_culture"  
  
# run r script
Rscript --vanilla /storage/chen/home/u244187/TM_project/DEG/degs.R $dirOut $finrds $prefix  


