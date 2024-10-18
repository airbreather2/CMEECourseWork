#!/usr/bin/env python3

"""
Description: This script compares two DNA sequences from a CSV file, aligns them, and calculates 
the best alignment based on the number of matching bases. It uses a scoring function to determine
the best match and saves the alignment result along with the score to a text file.

The script includes:
- Reading DNA sequences from a CSV file.
- Calculating the best alignment using a custom scoring function.
- Saving the best alignment and score to a text file.

Author: Sebastian Dohne (sed24@ic.ac.uk)
Version: 0.0.1
License: License for this code/program
"""
__appname__ = '[align_seq.py]'
__author__ = 'Sebastian Dohne (sed24@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"

import ipdb
import csv
import sys

def load_sequence(filename):
    """
    Loads two DNA sequences from a CSV file.

    This function checks if the provided filename ends with '.csv' and attempts to read 
    the sequences from the specified CSV file. It expects the CSV file to contain two 
    sequences in the first two columns of the file. The first row is treated as a header 
    and is skipped during the reading process.

    Args:
        filename (str): The path to the CSV file containing the DNA sequences.

    Returns:
        tuple: A tuple containing two strings:
            - The first string is the concatenated sequence from the first column.
            - The second string is the concatenated sequence from the second column.
            
        If the file is not found or is not a CSV file, returns (None, None).
    """
    if not filename.lower().endswith('.csv'):
        print("Error: The file is not a CSV file. Please provide a .csv file.")
        return None, None
    
    sequence = ""  # Will store sequence 1
    sequence2 = "" # Will store sequence 2
    try:
        with open(filename, newline='') as f:  # Ensure no blank rows between DNA sequences
            reader = csv.reader(f)
            next(reader)  # Skip the header row
            for row in reader:
                sequence += row[0]  # Concatenate each nucleotide of sequence 1
                sequence2 += row[1] # Concatenate each nucleotide of sequence 2
    except FileNotFoundError:
        print(f"Error: File '{filename}' not found.")
        return None, None
    
    return sequence, sequence2

file_path = input("Enter the file path for the sequence CSV file: ") # code that saves inputed csv file in terminal as variable
seqs = load_sequence(file_path) #to be run in the function
seq1 = seqs[0]
seq2 = seqs[1]

#seq2 = load_sequence('seq2.csv')

# Assign the longer sequence s1, and the shorter to s2
# l1 is length of the longest, l2 that of the shortest

l1 = len(seq1)
l2 = len(seq2)
if l1 >= l2:
    s1 = seq1
    s2 = seq2
else:
    s1 = seq2
    s2 = seq1
    l1, l2 = l2, l1 # swap the two lengths


#ipdb.set_trace()

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



# Test the function with some example starting points:
#calculate_score(s1, s2, l1, l2, 0)
#calculate_score(s1, s2, l1, l2, 1)
#calculate_score(s1, s2, l1, l2, 5)

# now try to find the best match (highest score) for the two sequences
my_best_align = None
my_best_score = -1 #makes sure value is properley updated even if lower than 0 

for i in range(l1): # Note that you just take the last alignment with the highest score
    z = calculate_score(s1, s2, l1, l2, i)
    if z > my_best_score:
        my_best_align = "." * i + s2 # creates visual respresentation of best alignment 
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
    
file_path = "../../Results/Best-alignment-Results.txt"
save_to_text(file_path, my_best_align, s1, my_best_score)


# saves output to txt file

