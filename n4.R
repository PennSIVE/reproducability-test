library(neurobase)
library(ANTsR)
library(extrantsr)

Sys.getenv("ITK_GLOBAL_DEFAULT_NUMBER_OF_THREADS")
Sys.getenv("OMP_NUM_THREADS")
Sys.getenv("OMP_THREAD_LIMIT")
Sys.getenv("MKL_NUM_THREADS")
Sys.getenv("OPENBLAS_NUM_THREADS")

args <- commandArgs(trailingOnly = TRUE)
n4 <- bias_correct(readnii(args[1]), correction="N4", reorient=F)
writenii(n4, args[2])
