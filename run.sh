#!/bin/bash

set -euf -o pipefail

cores=$1
run=$2
outdir=./output/$cores/$run

export ITK_GLOBAL_DEFAULT_NUMBER_OF_THREADS=$cores
export OMP_NUM_THREADS=$cores
export OMP_THREAD_LIMIT=$cores
export MKL_NUM_THREADS=$cores
export OPENBLAS_NUM_THREADS=$cores

mkdir -p $outdir

/usr/bin/time -pv Rscript n4.R T1W.nii.gz $outdir/n4.nii.gz
/usr/bin/time -pv Rscript fslbet.R T1W.nii.gz $outdir/fslbet.nii.gz
/usr/bin/time -pv Rscript reg.R T1W.nii.gz FLAIR.nii.gz $outdir/reg.nii.gz
