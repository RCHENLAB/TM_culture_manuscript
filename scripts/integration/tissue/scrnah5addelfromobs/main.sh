#!/usr/bin/env bash

outdir=$(mrrdir.sh)

function cmd {
local id=$1
local f=$5
slurmtaco.sh -t 1 -m 10G -- scrnah5addelfromobs.sh -d "$outdir" -b "$id" -n orig.ident -- "$f"
}

source env_parallel.bash
env_parallel --colsep='\t' cmd < concat.txt
