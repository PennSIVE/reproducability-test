library(neurobase)
library(ANTsR)
library(extrantsr)

Sys.getenv("ITK_GLOBAL_DEFAULT_NUMBER_OF_THREADS")
Sys.getenv("OMP_NUM_THREADS")
Sys.getenv("OMP_THREAD_LIMIT")
Sys.getenv("MKL_NUM_THREADS")
Sys.getenv("OPENBLAS_NUM_THREADS")

args <- commandArgs(trailingOnly = TRUE)
t1 <- readnii(args[1])
flair <- readnii(args[2])
t1_to_flair = registration(filename = t1,
              template.file = flair,
              typeofTransform = "Rigid", remove.warp = FALSE,
              outprefix="t1_reg_to_flair") ### rigid

t1_reg = ants2oro(antsApplyTransforms(fixed = oro2ants(flair), moving = oro2ants(t1),
          transformlist = t1_to_flair$fwdtransforms, interpolator = "welchWindowedSinc"))

writenii(t1_reg, args[3])
