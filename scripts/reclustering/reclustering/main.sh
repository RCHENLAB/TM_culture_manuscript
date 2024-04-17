#!/bin/bash
# vim: set noexpandtab tabstop=2:

function cmd {
local f=$1
set -x
R -s --vanilla \
	-e "infile='$f'" \
	-e "outfile='combctumap.pdf'" \
	-e "height=6" \
	-e "width=9" \
	-e "source('tm_recluster.R')"
}

if (($#))
then
	cmd "$@"
fi
