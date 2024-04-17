#!/usr/bin/env bash

indir="/storage/chentemp/alice/TM_project/tissue/scrnascanpyconcat2h5ad"
outdir=$(mrrdir.sh)
#slurmtaco.sh -n g01 -t 2 -m 80G -- scrnah5adfiles2scviwkfl -d "$outdir" -t 4 -n -- "$indir"/*.h5ad
slurmtaco.sh -n g01 -t 2 -m 80G -- scrnah5adfiles2scviwkfl -d "$outdir" -t 4 -c config_230821141735.yaml -- "$indir"/*.h5ad
