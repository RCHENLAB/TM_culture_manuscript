#!/usr/bin/bash

# user parameters
dirOut="/storage/chentemp/alice/TM_project/DEG_tissue"   
finrds="/storage/chen/data_share_folder/22_10x_hs_AnteriorSegment_data/scRNA_HAS/integration/predict_Robjs_rna/out_integration_TM_combined/obj_integ_TM_combined_rs_0.1_ds_30_TM_combined.rds"  
prefix="TM_tissue"  
  
# run r script
Rscript --vanilla /storage/chen/home/u244187/TM_project/DEG/degs.R $dirOut $finrds $prefix  


