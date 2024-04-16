#!/usr/bin/env bash

infiles=(
/storage/chen/data_share_folder/22_10x_hs_AnteriorSegment_data/scRNA_HAS/integration/predict_Robjs_rna/obj_query_predicted_umap_22_0500_TM.rds
/storage/chen/data_share_folder/22_10x_hs_AnteriorSegment_data/scRNA_HAS/integration/predict_Robjs_rna/obj_query_predicted_umap_22_0688_TM.rds
/storage/chen/data_share_folder/22_10x_hs_AnteriorSegment_data/scRNA_HAS/integration/predict_Robjs_rna/obj_query_predicted_umap_22_0769_TM.rds
)
outdir=$(mrrdir.sh)

function cmd {
local f=$1
local bname=$(basename "$f" .rds)
slurmtaco.sh -t 1 -m 10G -- scrnaseuratobject2clean.sh -d "$outdir" -b "$bname" -- "$f"
}

source env_parallel.bash
env_parallel cmd ::: "${infiles[@]}"
