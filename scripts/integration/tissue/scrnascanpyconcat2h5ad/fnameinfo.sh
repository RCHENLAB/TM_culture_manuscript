#!/usr/bin/env bash

hinnerjoin2.sh -k sampleid -S <(cut -f -4 concat.txt) id2file.txt > fnameinfo.txt
