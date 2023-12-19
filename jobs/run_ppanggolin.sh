#!/bin/bash

usage() {
    echo -e "Usage: ./run_ppanggolin.sh -i <input_file> -o <output_file>"
    echo -e "\t-i <input_file>\t\tThe input file to use"
    echo -e "\t-o <output_file>\tThe output file to generate"
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
        output_file="$OPTARG"
        ;;
    t)
        threads="$OPTARG"
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

ppanggolin all \
    --anno "$input_file" \
    -o "$output_file" \
    -c "$threads"
