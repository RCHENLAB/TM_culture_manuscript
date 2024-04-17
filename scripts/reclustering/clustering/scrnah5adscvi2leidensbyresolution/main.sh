#!/usr/bin/env bash

indir=$(mrrdir.sh ../scrnah5adfiles2scviwkfl)
outdir=$(mrrdir.sh)

function cmd {
local f=$1
local bname=$(basename "$f" .h5ad)
scrnah5adscvi2leidensbyresolution -d "$outdir" -b "$bname" /storage/chentemp/alice/TM_project/scrnah5adfiles2scviwkfl/TM_culture.h5ad
}

source env_parallel.bash
env_parallel cmd ::: "$indir"/*.h5ad
