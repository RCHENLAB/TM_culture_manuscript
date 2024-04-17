#!/usr/bin/env bash

infiles=(
/storage/chenlab/Users/shared_data/314_10xRNA_TM_Pcell2/01.data_QC/out_10x3V31_GTM_1672_P3/obj_query_afterPrediction_10x3V31_GTM_1672_P3.rds
/storage/chenlab/Users/shared_data/314_10xRNA_TM_Pcell2/01.data_QC/out_10x3V31_GTM_2956/obj_query_afterPrediction_10x3V31_GTM_2956.rds
/storage/chenlab/Users/shared_data/314_10xRNA_TM_Pcell2/01.data_QC/out_10x3V31_GTM_7445/obj_query_afterPrediction_10x3V31_GTM_7445.rds
/storage/chenlab/Users/shared_data/314_10xRNA_TM_Pcell2/01.data_QC/out_10x3V31_hTM_0114_P1/obj_query_afterPrediction_10x3V31_hTM_0114_P1.rds
/storage/chenlab/Users/shared_data/314_10xRNA_TM_Pcell2/01.data_QC/out_10x3v31_hTM_11701_P2/obj_query_afterPrediction_10x3v31_hTM_11701_P2.rds
/storage/chenlab/Users/shared_data/314_10xRNA_TM_Pcell2/01.data_QC/out_10x3v31_hTM_11703_P2/obj_query_afterPrediction_10x3v31_hTM_11703_P2.rds
/storage/chenlab/Users/shared_data/314_10xRNA_TM_Pcell2/01.data_QC/out_10x3v31_hTM_2180/obj_query_afterPrediction_10x3v31_hTM_2180.rds
/storage/chenlab/Users/shared_data/314_10xRNA_TM_Pcell2/01.data_QC/out_10x3V31_hTM_659_P1_DCR/obj_query_afterPrediction_10x3V31_hTM_659_P1_DCR.rds
/storage/chenlab/Users/shared_data/314_10xRNA_TM_Pcell2/01.data_QC/out_10x3V31_hTM_74M_P2/obj_query_afterPrediction_10x3V31_hTM_74M_P2.rds
/storage/chenlab/Users/shared_data/314_10xRNA_TM_Pcell2/01.data_QC/out_10x3V31_hTM_7987_P2/obj_query_afterPrediction_10x3V31_hTM_7987_P2.rds
/storage/chenlab/Users/shared_data/314_10xRNA_TM_Pcell2/01.data_QC/out_10x3v31_hTM_9355_P1/obj_query_afterPrediction_10x3v31_hTM_9355_P1.rds
/storage/chenlab/Users/shared_data/314_10xRNA_TM_Pcell2/01.data_QC/out_10x3v31_hTM_9632_P2/obj_query_afterPrediction_10x3v31_hTM_9632_P2.rds
/storage/chenlab/Users/shared_data/314_10xRNA_TM_Pcell2/01.data_QC/out_10x3v31_hTM_9691_P1/obj_query_afterPrediction_10x3v31_hTM_9691_P1.rds
/storage/chenlab/Users/shared_data/314_10xRNA_TM_Pcell2/01.data_QC/out_10x3V31_OHSU_GTM_2019_0461/obj_query_afterPrediction_10x3V31_OHSU_GTM_2019_0461.rds
)
outdir=$(mrrdir.sh)

function cmd {
local f=$1
local bname=$(basename "$f" .rds)
slurmtaco.sh -t 1 -m 10G -- scrnaseuratobject2clean.sh -d "$outdir" -b "$bname" -- "$f"
}

source env_parallel.bash
env_parallel cmd ::: "${infiles[@]}"
