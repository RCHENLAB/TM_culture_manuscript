#!/usr/bin/env bash

outdir=$(mrrdir.sh)
bname=TM_tissue
fnameinfo=3_concat.txt
#fnameinfo=fnameinfo.txt
scrnascanpyconcat2h5ad.sh -d "$outdir" -b "$bname" -t 14 -- "$fnameinfo"
