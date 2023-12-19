#!/bin/bash

echo -e "\n\t============== RAxML Runner ==============\n"
usage() {
    echo -e "Usage:\n\t./run_raxml.sh -i <input_file> -o <outdir> -T <cores> -n <run_name> -m <model>\n"
    echo -e "\t-i <input_file>\t\tThe input file to use"
    echo -e "\t-o <outdir>\t\tThe output directory to use (default: raxml_outputs/<run_name>)"
    echo -e "\t-n <run_name>\t\tThe name of the run (default: timestamp)"
    echo -e "\t-T <threads>\t\tThe number of ~cores~ (not threads) to use (default: 32)"
    echo -e "\t-m <model>\t\tThe model to use (default: GTRGAMMA)"
}

# If less than four arguments, complain and exit
if [ "$#" -lt 4 ]; then
  usage
  exit 1
fi

while getopts ":i:o:n:t:m:" opt; do
    case $opt in
    i)
        input_file="$OPTARG"
        ;;
    o)
        output_dir="$OPTARG"
        ;;
    t)
        threads="$OPTARG"
        ;;
    n)
        run_name="$OPTARG"
        ;;
    m)
        model="$OPTARG"
        ;;
    \?)
        echo "Invalid option: -$OPTARG" >&2
        usage
        exit 1
        ;;
    esac    
done

# If threads doens't exist, set it to 32
if [ -z "$threads" ]; then
    threads=2
fi


if [ -z "$run_name" ]; then
    run_name="raxml_$(date +%m%d%Y_%H%M%S)"
fi

if [ -z "$output_dir" ]; then
    output_dir="./raxml_outputs"
fi

output_dir="$output_dir/$run_name"

if [ ! -d "$output_dir" ]; then
    mkdir -p "$output_dir"
fi    

if [ -z "$model" ]; then
    model="GTRGAMMA"
fi

cat << EOF
    Input file: $input_file
    Output directory: $output_dir
    Number of threads: $threads
    Run name: $run_name
    Model: $model
EOF

# raxmlHPC-PTHREADS -T $threads \
#     -p 489 \
#     -m $model \
#     -n $run_name \ 
#     -w $output_dir \
#     -s $input_file

raxmlHPC-PTHREADS -T $threads \
    -m $model \
    -s $input_file \
    -w $output_dir \
    -n $run_name \
    -p 489
