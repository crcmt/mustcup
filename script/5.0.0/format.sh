#!/bin/bash -ue

# remove the header and keep only the first and last column
input_dir=$(dirname $1)
filename=$(basename $1)
filename_no_extension=${filename%.*}
awk '$1 ~ /^ENS/' $1 | awk '{print $1 "\t" $NF}' > "$input_dir/$filename_no_extension.adapted.tsv"

# remove PAR_Y gene (e.g. ENSG00000002586.20_PAR_Y)
cat "$input_dir/$filename_no_extension.adapted.tsv" | grep -v "_PAR_Y" > "$input_dir/$filename_no_extension.without_PAR.tsv"

# remove version
#cat "$input_dir/without_PAR.tsv" | sed '2,$s/^\([^.\t]\+\)[^\t]*/\1/' > "$input_dir/without_version.tsv"
cat "$input_dir/$filename_no_extension.without_PAR.tsv" > "$input_dir/$filename_no_extension.without_version.tsv"


cp "$input_dir/$filename_no_extension.without_version.tsv" $2

# cleaning
rm "$input_dir/$filename_no_extension.without_PAR.tsv"
rm "$input_dir/$filename_no_extension.without_version.tsv"
