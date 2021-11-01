library(neurobase)
library(fslr)
library(extrantsr)

Sys.getenv("ITK_GLOBAL_DEFAULT_NUMBER_OF_THREADS")
Sys.getenv("OMP_NUM_THREADS")
Sys.getenv("OMP_THREAD_LIMIT")
Sys.getenv("MKL_NUM_THREADS")
Sys.getenv("OPENBLAS_NUM_THREADS")

args <- commandArgs(trailingOnly = TRUE)
brain <- fslbet_robust(readnii(args[1]), correct=F)
writenii(brain, args[2])
