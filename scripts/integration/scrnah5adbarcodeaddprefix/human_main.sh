#!/usr/bin/env bash

indir=$(mrrdir.sh ../scrnah5ad2clean/human_data)
outdir=$(mrrdir.sh)

function cmd {
local f=$1
local bname=$(basename "$f" .h5ad)
slurmtaco.sh -t 2 -m 20G -- scrnah5adbarcodeaddprefix.sh -d "$outdir" -b "$bname" -p "${bname}_" -- "$f"
}

source env_parallel.bash
env_parallel cmd ::: "$indir"/*.h5ad
