#!/usr/bin/bash

# user parameters
dirIn="/storage/chentemp/alice/TM_project/reclustering"   
finrds="TM_culture_wharmony_reclustered.rds"  
prefix="TM_culture"  
new_cluster_List="TM_Culture_Cell,Proliferating_Culture_Cell,Stressed_Culture_Cell,BeamCell,Fibroblast"

# run r script
Rscript --vanilla /storage/chen/home/u244187/TM_project/final_figs/assign_names/assign_names.R $dirIn $finrds $prefix $new_cluster_List 

