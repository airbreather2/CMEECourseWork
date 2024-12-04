# Week 1

Week 1 contains content from the following chapters: **UNIX and Linux, Shell Scripting, and LaTeX.**

## BASH Scripts in Code

### boilerplate.sh

- **Description**:  
  A simple boilerplate script to demonstrate the basic structure of a shell script with a basic `echo` command.

- **Usage**:  
  1. Make the script executable:
     ```bash
     chmod +x boilerplate.sh
     ```
  2. Run the script:
     ```bash
     ./boilerplate.sh
     ```

- **Arguments**:  
  None.

- **Dependencies**:  
  None.
  
### CompileLaTeX.sh

- **Description**:  
  Automates the process of compiling a LaTeX document with references, opens the resulting PDF, and cleans up intermediate files.

- **Usage**:  
  1. Save the script in the same directory as your LaTeX (`.tex`) and BibTeX (`.bib`) files.
  2. Run the script using:
     ```bash
     ./compile_latex.sh mydocument.tex
     ```
     Replace `mydocument.tex` with the name of your LaTeX file (without the extension if desired).

- **Arguments**:  
  - `<filename.tex>`: The name of the LaTeX file to compile. The `.tex` extension is optional as the script handles it automatically.

- **Dependencies**:  
  - `pdflatex` and `bibtex`: To compile the LaTeX document and process the bibliography.
  - `evince`: To open the resulting PDF. You can change this to another PDF viewer if needed.
  - Optional: Ensure that LaTeX packages required by the document are installed.

### ConcatenateTwoFiles.sh

- **Description**:  
  Concatenates two input files into an existing third file. The contents of the first file overwrite the output file, and the contents of the second file are appended to it.

- **Usage**:  
  1. Run the script with the following syntax:
     ```bash
     ./ConcatenateTwoFiles.sh file1.txt file2.txt outputfile.txt
     ```
     - `file1.txt`: The first input file.
     - `file2.txt`: The second input file.
     - `outputfile.txt`: The file where the contents of both input files will be concatenated.

- **Arguments**:  
  The script requires exactly **three arguments**:
  1. `file1.txt`: The first input file.
  2. `file2.txt`: The second input file.
  3. `outputfile.txt`: The output file where the concatenated content will be written.

- **Dependencies**:  
  - No external dependencies. The script uses basic shell commands (`cat`, `read`, `echo`) available in all Unix-like environments.


### countlines.sh

- **Description**:  
  Counts the number of lines in a specified file and prints the result to the console.

- **Usage**:  
  1. Run the script using the following syntax:
     ```bash
     ./countlines.sh <filename>
     ```
     - `<filename>`: The name of the file you want to count lines for.
     
     - **Arguments**:  
    The script requires exactly **one argument**:
    1. `<filename>`: The input file whose lines will be counted. The file can be in any format (e.g., `.txt`, `.csv`, etc.).

  - **Dependencies**:  
    No external dependencies. The script uses the built-in `wc` command, which is available in all Unix-like environments.

### csvtospace.sh

- **Description**:  
  Takes a comma-separated values (CSV) file and converts it to a space-separated format, saving the output as a `.txt` file. 

  - **Arguments**:  
    The script requires exactly **one argument**:
    1. `<filename.csv>`: A comma-separated input file (must have a `.csv` extension).

  - **Dependencies**:  
    No external dependencies. The script uses basic shell commands like `cat` and `tr`, which are available in all Unix-like environments.

- **Usage**:  
  1. Run the script using the following syntax:
     ```bash
     ./tabtospace.sh <filename.csv>
     ```
     - `<filename.csv>`: The CSV file you want to convert to a space-separated file.

### csvtotab.sh

- **Description**:  
  Converts a comma-separated values (CSV) file to a tab-delimited format and saves the output as a `.txt` file.

  - **Arguments**:  
    The script requires exactly **one argument**:
    1. `<filename.csv>`: A comma-separated input file (must have a `.csv` extension).

  - **Dependencies**:  
    No external dependencies. The script uses basic shell commands like `cat` and `tr`, which are available in all Unix-like environments.

- **Usage**:  
  1. Run the script using the following syntax:
     ```bash
     ./csvtotsv.sh <filename.csv>
     ```
     - `<filename.csv>`: The CSV file you want to convert to a tab-delimited file.

- **Example**:
  ```bash
  ./csvtotsv.sh data.csv

### MyExampleScript.sh

- **Description**:  
  A simple script that greets the user twice, using the environment variable `$USER` to retrieve the system's username.

  - **Arguments**:  
    This script does not require any arguments. It automatically retrieves and uses the current system username from the `$USER` environment variable.

  - **Dependencies**:  
    No external dependencies. The script uses standard shell commands available in all Unix-like environments.

- **Usage**:  
  1. Run the script using the following syntax:
     ```bash
     ./MyExampleScript.sh
     ```
  - The script will print a greeting to the user running the script.

### tabtocsv.sh

- **Description**:  
  Converts a tab-delimited file (`.txt`) to a comma-separated values (CSV) file by replacing all tabs with commas.

  - **Arguments**:  
    The script requires exactly **one argument**:
    1. `<filename.txt>`: A tab-delimited input file (must have a `.txt` extension).

  - **Dependencies**:  
    No external dependencies. The script uses basic shell commands like `cat` and `tr`, which are available in all Unix-like environments.

- **Usage**:  
  1. Run the script using the following syntax:
     ```bash
     ./tabtocsv.sh <filename.txt>
     ```
     - `<filename.txt>`: The tab-delimited file you want to convert to a CSV format.


### tiff2png.sh

- **Description**:  
  This script converts all `.tif` files in the current directory to `.png` format using the `convert` command from ImageMagick.

  - **Arguments**:  
    No arguments are required. The script automatically converts all `.tif` files in the current directory.

  - **Dependencies**:  
    - **ImageMagick**: The `convert` command used in the script is provided by ImageMagick. Ensure that ImageMagick (or a similar tool) is installed on your system.

- **Usage**:  
  1. Navigate to the directory containing the `.tif` files.
  2. Run the script using the following syntax:
     ```bash
     ./tiff2png.sh
     ```
  - The script will convert all `.tif` files in the directory to `.png`.

### variables.sh

- **Description**:  
  This script demonstrates the use of variables in a shell script. It showcases:
  - Special variables such as `$#`, `$0`, `$@`, `$1`, and `$2`.
  - Assigning variables explicitly and using the `read` command to take user input.
  - Simple arithmetic operations by reading two numbers and summing them.

  - **Arguments**:  
    The script can accept up to two optional arguments:
    1. `arg1`: The first argument passed to the script (optional).
    2. `arg2`: The second argument passed to the script (optional).

  - **Dependencies**:  
    No external dependencies. The script uses basic shell commands like `echo` and `read`, which are available in all Unix-like environments.

- **Usage**:  
  1. Run the script using the following syntax:
     ```bash
     ./variables.sh [arg1] [arg2]
     ```
     - `arg1`: The first argument passed to the script (optional).
     - `arg2`: The second argument passed to the script (optional).

## Fasta Exercise

**Location:** `code/UnixPrac1.txt` (to be used on files in `data/fasta`)

### Terminal Commands Involved:
- Counting lines in a sequence
- Printing the sequence
- Counting sequence length
- Counting the number of character matches in a particular sequence
- Computing the AT/GC ratio of a sequence

## Associated Files with Content Covered in UNIX and Linux Chapters
- Building Coursework Structure
- Command Arguments
- Redirection and Pipes (`test.txt`)
- Wildcards (all files in `sandbox/TestWild` directory)
- Using `grep` (`data/Spawannxs.txt`)
- Finding Files (all files in `sandbox/Testfind` directory)

## Shell Scripting Chapters
- **Conventions and Syntax Rules:** Boilerplates (`code/boilerplate.sh`)
- **Variables in Shell Scripts:** (`code/Variables.sh` and `code/MyExampleScript.sh`)

