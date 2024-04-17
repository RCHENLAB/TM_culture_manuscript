suppressPackageStartupMessages(library(Seurat))
suppressPackageStartupMessages(library(sceasy))

source("/storage/chen/home/u244187/TM_project/functions/tm_culture_fn.R")

args = commandArgs(trailingOnly=TRUE)
if (length(args)!=4) {
  stop("please type 1 parameter: outdir", call.=FALSE)
} else {
  # default output file
  infile <- args[1]
  prefix <- args[2]
  outdir <- args[3]
  rsN    <- args[4]
}

#convert back to seurat .rds object
sceasy::convertFormat(infile, from="anndata", to="seurat",outFile='tm_culture.rds')
objA <- readRDS('tm_culture.rds')

objA <- runCellcyleCorrection(objectA,prefix,rsN,outdir)
