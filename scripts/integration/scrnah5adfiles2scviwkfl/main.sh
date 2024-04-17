#!/usr/bin/env bash

indir=$(mrrdir.sh ../scrnah5adfiltergenescellsbycount)
outdir=$(mrrdir.sh)
# slurmtaco.sh -n g01 -t 2 -m 80G -- scrnah5adfiles2scviwkfl -d "$outdir" -t 4 -n -- "$indir"/*.h5ad
slurmtaco.sh -n g01 -t 2 -m 80G -- scrnah5adfiles2scviwkfl -d "$outdir" -t 4 -c config.yaml -- "$indir"/*.h5ad
