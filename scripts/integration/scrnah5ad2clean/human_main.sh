#!/usr/bin/env bash

indir=$(mrrdir.sh ../scrnaseuratobjectrds2h5ad/human_data)
outdir=$(mrrdir.sh)

function cmd {
local f=$1
local bname=$(basename "$f" .h5ad)
    scrnah5ad2clean.sh -d outdir -b "$bname" -- "$f"
}

source env_parallel.bash
env_parallel cmd ::: "$indir"/*.h5ad
