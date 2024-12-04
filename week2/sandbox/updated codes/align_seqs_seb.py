#!/usr/bin/env python3

"""
Description: This script compares two DNA sequences from a FASTA file, aligns them, and calculates 
the best alignment based on the number of matching bases. It uses a scoring function to determine
the best match and saves the alignment result along with the score to a text file.

Author: Sebastian Dohne (sed24@ic.ac.uk)
Version: 0.0.1
License: License for this code/program
"""

__appname__ = '[align_seq.py]'
__author__ = 'Sebastian Dohne (sed24@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"

import sys

def load_sequence(filename1, filename2):
    """
    Loads two DNA sequences from FASTA files.

    This function checks if the provided filenames end with '.fasta' and attempts to read 
    the sequences from the specified FASTA files. It expects the FASTA files to contain 
    DNA sequences, ignoring the header lines that start with '>'.

    Args:
        filename1 (str): The path to the first FASTA file containing the DNA sequence.
        filename2 (str): The path to the second FASTA file containing the DNA sequence.

    Returns:
        tuple: A tuple containing two strings:
            - The first string is the concatenated sequence from the first file.
            - The second string is the concatenated sequence from the second file.
            
        If the file is not found or is not a FASTA file, returns (None, None).
    """
    # Check if both filenames end with '.fasta'
    if not (filename1.lower().endswith('.fasta') and filename2.lower().endswith('.fasta')):
        print("Error: Both files must be FASTA files. Please provide valid .fasta files.")
        return None, None

    sequence1 = ""  # Will store sequence 1
    sequence2 = ""  # Will store sequence 2

    # Read the first file
    try:
        with open(filename1, 'r') as f:
            for line in f:
                if not line.startswith(">"):  # Ignore the header lines
                    sequence1 += line.strip()  # Concatenate the DNA sequence
    except FileNotFoundError:
        print(f"Error: File '{filename1}' not found.")
        return None, None

    # Read the second file
    try:
        with open(filename2, 'r') as f:
            for line in f:
                if not line.startswith(">"):  # Ignore the header lines
                    sequence2 += line.strip()  # Concatenate the DNA sequence
    except FileNotFoundError:
        print(f"Error: File '{filename2}' not found.")
        return None, None

    return sequence1, sequence2

# Check if the correct number of arguments is provided
if len(sys.argv) != 3:
    print("Invalid number of arguments provided. Using default files instead.")
    print("Usage: python3 align_seqs_fasta.py exampleseq1.fasta exampleseq2.fasta")
    
    # Set default file paths
    file_path1 = '407228326.fasta'
    file_path2 = '407228412.fasta'
else:
    # Get filenames from command-line arguments
    file_path1 = sys.argv[1]
    file_path2 = sys.argv[2]

print(f"Using file paths: {file_path1}, {file_path2}")


# Load the sequences
seqs = load_sequence(file_path1, file_path2)

# Check if sequences were loaded correctly
if seqs is None:
    sys.exit(1)

seq1 = seqs[0]
seq2 = seqs[1]

# Determine the longer sequence (s1) and the shorter (s2)
l1 = len(seq1)
l2 = len(seq2)
if l1 >= l2:
    s1 = seq1
    s2 = seq2
else:
    s1 = seq2
    s2 = seq1
    l1, l2 = l2, l1  # Swap the two lengths


def calculate_score(s1, s2, l1, l2, startpoint):
    """
    Computes the alignment score by counting the number of matching bases 
    between two DNA sequences starting from a specified point.

    Args:
        s1 (str): The first DNA sequence (the longer sequence).
        s2 (str): The second DNA sequence (the shorter sequence).
        l1 (int): The length of the first DNA sequence.
        l2 (int): The length of the second DNA sequence.
        startpoint (int): The starting index in the first sequence for the alignment.

    Returns:
        int: The total score representing the number of matching bases found during the alignment.
    
    This function prints a visual representation of the alignment, where 
    '*' indicates a match and '-' indicates a mismatch.
    """
    matched = ""  # Holds the alignment representation
    score = 0
    for i in range(l2):
        if (i + startpoint) < l1:  # Check within bounds of the first sequence
            if s1[i + startpoint] == s2[i]:  # If the bases match
                matched += "*"  # Append '*' for a match
                score += 1  # Increment score
            else:
                matched += "-"  # Append '-' for a mismatch

    # Print formatted output
    print("." * startpoint + matched)  # Align matched sequence
    print("." * startpoint + s2)  # Print second sequence
    print(s1)  # Print first DNA sequence
    print(score)  # Print match score
    print(" ")  # Blank line for spacing

    return score  # Return the total score


# Now find the best match (highest score) for the two sequences
my_best_align = None
my_best_score = -1  # Initialize to ensure the value is properly updated

for i in range(l1):  # Test different alignments
    z = calculate_score(s1, s2, l1, l2, i)
    if z > my_best_score:
        my_best_align = "." * i + s2  # Create visual representation of best alignment
        my_best_score = z

# Print the final results after finding the best alignment
print(my_best_align)
print(s1)
print("Best score:", my_best_score)


def save_to_text(file_path, best_alignment, s1, best_score):
    """
    Saves the best alignment and score to a specified text file.

    Args:
        file_path (str): The path to the output text file.
        best_alignment (str): The best alignment of the two sequences.
        s1 (str): The longer DNA sequence involved in the best alignment.
        best_score (int): The score of the best alignment.
    
    This function writes the best alignment, the associated DNA sequence,
    and the best score to the specified file. It prints a confirmation message
    once the results are saved.
    """
    with open(file_path, 'w') as outfile: 
        outfile.write("Best Alignment:\n")
        outfile.write(best_alignment + "\n")
        outfile.write(s1 + "\n")
        outfile.write(f"Best Score: {best_score}\n")
    print(f"Results saved to {file_path}")

# Specify the output file path
output_file_path = "../Results/Best-alignment-Results.txt"
save_to_text(output_file_path, my_best_align, s1, my_best_score)
