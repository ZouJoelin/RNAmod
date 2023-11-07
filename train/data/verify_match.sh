#!/bin/bash

fast5_csv=$1
fastq_csv=$2

diff <(cat $fast5_csv| awk '{print $1 $2}') <(cat $fastq_csv| awk '{print $1 $2}')

if [[ $? -eq 0 ]]; then
    printf "Columns read&channel match: $fast5_csv & $fastq_csv\n"
else
    printf "Columns read&channel DON'T match: $fast5_csv & $fastq_csv\n"
fi