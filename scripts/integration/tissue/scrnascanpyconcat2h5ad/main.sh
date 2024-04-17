#!/usr/bin/env bash

outdir=$(mrrdir.sh)
bname=TM_culture_wtissue
fnameinfo=2_Concat.txt
#fnameinfo=fnameinfo.txt
scrnascanpyconcat2h5ad.sh -d "$outdir" -b "$bname" -t 14 -- "$fnameinfo"
