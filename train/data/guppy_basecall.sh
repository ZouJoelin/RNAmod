#!/bin/bash

input_dir="$1"
subfolder=$(echo "$input_dir" | sed 's/.*\///')
output_dir="$2"

printf "Start basecalling...\nfrom ./$input_dir/ to ./$output_dir/\n"

guppy_basecaller -i ./$input_dir -s ./$output_dir/guppy_temp -c rna_r9.4.1_70bps_hac.cfg --chunks_per_runner 512 --num_callers 20 || exit

# for subfolder in "$input_dir"/*; do
#     if [ -d "$subfolder" ]; then
#         guppy_basecaller -i ./$subfolder -s ./$output_dir/guppy_temp/$subfolder -c rna_r9.4.1_70bps_hac.cfg --chunks_per_runner 512 --num_callers 20            
#     fi
# done

printf "Finished basecalling!\n"

printf "Start collecting *.fastq from ./"$output_dir"/guppy_temp to ./"$output_dir"/"$subfolder".fastq...\n"

cat ./$output_dir/guppy_temp/*.fastq > ./$output_dir/$subfolder.fastq &&
rm -rf ./$output_dir/guppy_temp &&
printf "Finished collecting!\n"
