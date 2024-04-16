#!/usr/bin/env bash

outdir=$(mrrdir.sh)
bname=TM_culture
fnameinfo=../culture_metadata.txt
slurmtaco.sh -t 14 -m 30G -- scrnascanpyconcat2h5ad.sh -d "$outdir" -b "$bname" -t 14 -- "$fnameinfo"
