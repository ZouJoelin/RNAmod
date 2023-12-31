#!/bin/bash

fast_dir=$1
output_list=$2

cat <(printf "read,channel,fast5_filepath\n") \
    <(ls $fast_dir | sed -E "s#(.*read_([0-9]+)_ch_([0-9]+).*\.fast5$)#\2,\3,$fast_dir/\1#" \
    | sort -t',' -k1,1n -k2,2n) > $output_list

printf "Finished listing and tabulating $fast_dir to $output_list\n"

