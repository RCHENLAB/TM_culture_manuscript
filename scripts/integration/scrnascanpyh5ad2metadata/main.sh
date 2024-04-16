#!/usr/bin/env bash

indir=$(mrrdir.sh ../scrnah5adbarcodeaddprefix)
outdir=$(mrrdir.sh)

function cmd {
local f=$1
local bname=$(basename "$f" .txt.gz)
slurmtaco.sh -t 1 -m 10G -- scrnascanpyh5ad2metadata.sh -d "$outdir" -b "$bname" -- "$f"
}

source env_parallel.bash
env_parallel cmd ::: "$indir"/*.txt.gz
