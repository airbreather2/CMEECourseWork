"""
L Gene Extraction Script (FASTA Format)
========================================
Description:
This script extracts the L gene sequence from a FASTA file containing a complete genome.
The user provides:
1. Start and end positions of the L gene (1-based coordinates).
2. A desired output filename (without needing to add '.fasta').

The script saves the extracted L gene sequence as a FASTA file in the '../results' directory.

Usage Instructions:
1. Place your FASTA file in the same folder or specify its path.
2. Run the script:
       python script_name.py
3. Enter the following when prompted:
   - Input file name (FASTA format)
   - Start and end positions of the L gene
   - Desired output filename (e.g., L_gene_extracted)

Dependencies:
- Python (3.x)
- Ensure you have permission to write to the '../results' directory.

Example Input/Output:
---------------------
Input:
   Enter the input FASTA file name: my_genome.fasta
   Enter the L gene start position: 10000
   Enter the L gene end position: 16000
   Enter the output filename (without extension): L_gene_extracted

Output:
   A file named 'L_gene_extracted.fasta' will be saved in the '../results' folder.
"""

# Import required libraries
import os

# Ensure the output folder exists
output_folder = "../results"
if not os.path.exists(output_folder):
    os.makedirs(output_folder)

# Prompt user for inputs
input_file = input("Enter the input FASTA file name (e.g., genome.fasta): ").strip()
l_gene_start = int(input("Enter the L gene start position (1-based): ").strip())
l_gene_end = int(input("Enter the L gene end position (1-based): ").strip())
output_filename = input("Enter the output filename (without extension): ").strip()
if not output_filename.endswith(".fasta"):
    output_filename += ".fasta"
output_path = os.path.join(output_folder, output_filename)

# Read the input FASTA file and extract the sequence
sequence = ""
with open(input_file, "r") as infile:
    for line in infile:
        if not line.startswith(">"):  # Skip headers
            sequence += line.strip()

# Extract the L gene sequence
l_gene_seq = sequence[l_gene_start-1:l_gene_end]  # Adjust for zero-based indexing

# Write the extracted L gene sequence to a new FASTA file
with open(output_path, "w") as outfile:
    outfile.write(f">L_gene_extracted\n{l_gene_seq}\n")

print(f"L gene sequence saved to: {output_path}")

