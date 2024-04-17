#!/bin/bash
# vim: set noexpandtab tabstop=2:

indir=$(mrrdir.sh ../scrnah5adfiltergenescellsbycount)
outdir=$(mrrdir.sh)

echo $indir
echo $outdir
prefix="TM_culture"
rsN=0.1


echo $rsN


function cmd {
local f=$1
local bname=$(basename "$f" .h5ad)
set -x
#R -s --vanilla \
#	-e "infile='$bname'" \
#	-e "source('tm_rmcellcycle.R')"
#  -e 

Rscript --vanilla /storage/chen/home/u244187/TM_project/rmcellcycle/tm_rmcellcycle.R $bname $prefix $outdir $rsN

}

if (($#))
then
	cmd "$@"
fi

echo "process was done!"
