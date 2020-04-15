#!/bin/sh
#SBATCH --ntasks=16
#SBATCH --nodes=1
#SBATCH --mem=60gb
#SBATCH --time=24:00:00
#SBATCH --partition=jyanglab
#SBATCH --licenses=common
#SBATCH --job-name=hapoid_h
#SBATCH --mail-user=zhikaiyang911@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --error=/common/jyanglab/zhikaiyang/projects/agro932_hm1/largedata/jinlong/hap_h.err
#SBATCH --output=/common/jyanglab/zhikaiyang/projects/agro932_hm1/largedata/jinlong/hap_h.out
module load R/3.5
Rscript /common/jyanglab/zhikaiyang/projects/agro932_hm1/largedata/jinlong/haploid_h.r
