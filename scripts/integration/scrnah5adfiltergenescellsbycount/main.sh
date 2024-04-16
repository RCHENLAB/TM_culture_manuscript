#!/usr/bin/env bash

indir=$(mrrdir.sh ../scrnascanpyconcat2h5ad)
outdir=$(mrrdir.sh)

function cmd {
local f=$1
local bname=$(basename "$f" .h5ad)
slurmtaco.sh -- scrnah5adfiltergenescellsbycounts.sh -d "$outdir" -b "$bname" -c 1 -- "$f"
}

source env_parallel.bash
env_parallel cmd ::: "$indir"/*.h5ad
