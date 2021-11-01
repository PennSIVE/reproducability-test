#!/bin/bash

set -euf -o pipefail
cd $(dirname $0)

curl -LO https://johnmuschelli.com/open_ms_data/cross_sectional/raw/patient01/T1W.nii.gz
curl -LO https://johnmuschelli.com/open_ms_data/cross_sectional/raw/patient01/FLAIR.nii.gz

for cores in 1 2 8 32; do
    for run in 1 2; do
        qsub -b y -cwd \
            -o logs/\$JOB_ID -e logs/\$JOB_ID \
            -pe threaded $cores \
            -l h_vmem=20G \
            -l h_rt=04:00:00 \
            singularity run --cleanenv --bind /cbica ~/simg/neuror_4.1.sif ./run.sh $cores $run
    done
done
