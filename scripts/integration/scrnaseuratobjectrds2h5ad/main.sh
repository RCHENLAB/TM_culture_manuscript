#!/usr/bin/env bash

indir=$(mrrdir.sh ../scrnaseuratobject2clean)
outdir=$(mrrdir.sh)

function cmd {
local f=$1
local bname=$(basename "$f" .rds)
slurmtaco.sh -b -t 1 -m 10G -- scrnaseuratobjectrds2h5ad.sh -o "$outdir/$bname.h5ad" -- "$f" &
}

source env_parallel.bash
env_parallel cmd ::: "$indir"/*.rds
