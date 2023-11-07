#!/bin/bash

fastq_filepath=$1 #"./fastq/unmod.fastq"
output_list=$2 # "./fastq/unmod_fastq_list.csv"

cat <(printf "read, channel, fastq_seq\n") \
    <(cat $fastq_filepath| sed -E "N;N;N; s#^@([0-9a-z-]+).* read=([0-9]+) ch=([0-9]+).*\n([AUCG]+)\n\+\n.*#\2, \3, \4#" \
    | sort -n) > $output_list

printf "Finished tabulating $fastq_filepath to $output_list\n"

