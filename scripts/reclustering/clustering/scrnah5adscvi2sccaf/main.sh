#!/usr/bin/env bash

indir=$(mrrdir.sh ../scrnah5adfiles2scviwkfl)
outdir=$(mrrdir.sh)
local f=$1
local bname=$(basename "$f" .h5ad)

scrnah5adscvi2sccaf -d "$outdir" -b "$bname" /storage/chentemp/alice/TM_project/scrnah5adfiles2scviwkfl/TM_culture.h5ad
