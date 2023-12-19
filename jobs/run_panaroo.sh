#!/bin/bash

usage() {
    echo -e "Usage: ./run_ppanggolin.sh -i <input_file> -o <output_file>"
    echo -e "\t-i <input_file>\t\tThe input file to use"
    echo -e "\t-o <output_file>\tThe output file to generate"
    echo -e "\t-t <threads>\t\tThe number of threads to use (default: 32)"
    echo -e "\t-c <clean_mode>\t\tThe clean mode to use (default: strict)"
}

# Check if the correct number of arguments is provided
if [ "$#" -ne 4 ]; then
  usage
  exit 1
fi

while getopts ":i:o:" opt; do
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
    c)
        clean_mode="$OPTARG"
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
    threads=32
fi

if [ ! -d "$output_dir" ]; then
    mkdir -p "$output_dir"
fi

if [ -z "$clean_mode" ]; then
    clean_mode=strict
fi

panaroo \
    -i "$input_file" \
    -o "$output_dir" \
    -t "$threads" \
    --clean-mode "$clean_mode"
