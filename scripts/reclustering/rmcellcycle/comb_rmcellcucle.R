suppressPackageStartupMessages(library(Seurat))
#suppressPackageStartupMessages(library(sceasy))

source("/storage/chen/home/u244187/TM_project/tm_culture_fn.R")

args = commandArgs(trailingOnly=TRUE)
if (length(args)!=3) {
  stop("please type 1 parameter: outdir", call.=FALSE)
} else {
  # default output file
  infile <- args[1]
  prefix <- args[1]
  outdir <- args[2]
  rsN    <- args[3]
}

#convert back to seurat .rds object
sceasy::convertFormat(infile, from="anndata", to="seurat",outFile='tm_culture.rds')
objectA <- readRDS('tm_culture.rds')

objA <- runCellcyleCorrection(objectA,prefix,rsN,outdir)
