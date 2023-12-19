# Given an MSA, returns a new MSA with empty sequences removed.

from typing import Iterator, List, TextIO

"""
Generic fasta sequence class.
"""
from dataclasses import dataclass
from typing import Iterator, Union


def read_fasta(fasta_file: TextIO):
    """An iterator for fasta files.

    Inputs
    ------
    fasta_file: TextIO
        An open file for reading

    Outputs
    -------
    An iterator yielding the the sequence names and sequences from a fasta file

    Example
    -------
    input_file = 'tests/test_data/sequences/met_r.fa.fasta'
    with open(input_file) as fin:
        for name, seq in read_fasta(fin):
            print(f'{name}\n{seq}')

    """
    name = None
    seq: List[str] = []
    for line in fasta_file:
        line = line.rstrip()
        if line.startswith(">"):
            if name:
                header = name
                sequence = "".join(seq)
                yield header, sequence
            name, seq = line[1:], []
        else:
            seq.append(line)
    if name:
        header = name
        sequence = "".join(seq)
        yield header, sequence


if __name__ == "__main__":
    import argparse
    import sys

    parser = argparse.ArgumentParser(description="Remove empty sequences from an MSA.")
    parser.add_argument(
        "-i",
        "--input_file",
        type=argparse.FileType("r"),
        help="The input fasta file",
    )
    parser.add_argument(
        "-o",
        "--output_file",
        type=argparse.FileType("w"),
        help="The output fasta file",
    )
    args = parser.parse_args()

    for name, seq in read_fasta(args.input_file):
        if all([x == "-" for x in seq]):
            print(f"Empty sequence found: {name}")
        else:
            args.output_file.write(f">{name}\n{seq}\n")
