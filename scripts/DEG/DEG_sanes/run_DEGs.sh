#!/usr/bin/bash

# user parameters
dirOut="/storage/chentemp/alice/TM_project/DEG"   
finrds="/storage/chentemp/alice/TM_project/sains_chkMarkers/out_assign_CellType/obj_TM_culture_wCTannot_2.rds"
prefix="TM_culture"  
  
# run r script
Rscript --vanilla /storage/chen/home/u244187/TM_project/DEG/degs.R $dirOut $finrds $prefix  


