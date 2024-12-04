#!/bin/bash
# Author: Sebastian Dohne  <sed24@ic.ac.uk>
# Script: compileLatTeX.sh
# Description: Automates the process of compiling a LaTeX document and opens the resulting PDF, and cleans up intermediate files.
# Date: Oct 2024

#below is a shellscript that automates the process of compiling a LaTeX document and opens the resulting PDF(which is saved in results) , and cleans up intermediate files.

#Instructions: 

#Save this script in the same directory as your LaTeX and bibtex file. 
#If your LaTeX file is named mydocument.tex, can be run by passing this command the base name like so: bash CompileLaTeX.sh mydocument.tex

#!/bin/bash

# Removes the .tex extension if it's provided, otherwise uses the argument as-is
latexfile="${1%.tex}"

# Define variable for the results directory
results_dir="../results"

# Check if the results directory exists; if not, create it
if [ -d "$results_dir" ]; then
    echo "Directory $results_dir already exists."
else
    mkdir "$results_dir"
    echo "Directory $results_dir created."
fi

# Compile the LaTeX document twice to ensure proper linking of references and cross-references
pdflatex -output-directory="$results_dir" "${latexfile}.tex"
pdflatex -output-directory="$results_dir" "${latexfile}.tex"

# Check if the PDF was created successfully and open it
if [ -f "$results_dir/${latexfile}.pdf" ]; then
    evince "$results_dir/${latexfile}.pdf" &
else
    echo "Error: PDF file not created. Check for compilation errors."
    exit 1
fi

# Cleanup intermediate files in the results directory
rm -f "$results_dir"/*.aux "$results_dir"/*.log

