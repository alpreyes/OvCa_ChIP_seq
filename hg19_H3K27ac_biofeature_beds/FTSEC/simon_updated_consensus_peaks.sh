
#! /bin/bash
set -a

declare -a names
declare -a files

mkdir -p holding
mv ./*.bed holding/

files=(holding/*.bed)

for file in ${files[@]}; do
    file=$(basename ${file%.bed})
    names=( ${names[@]} ${file} )
done

cat "${files[@]}" | sort -k1,1 -k2,2n -k3,3n > allpeaks.bed
bedtools annotate -names "${names[@]}" -i allpeaks.bed -files "${files[@]}" | sort -k1,1 -k2,2n -k3,3n > allpeaks.anno.tsv
gsed -i 's/\#\t\t\t/chr\tstart\tend\t/' allpeaks.anno.tsv


#Rscript --vanilla consensus_peaks.r -f allpeaks.anno.tsv -o allpeaks_consensus

