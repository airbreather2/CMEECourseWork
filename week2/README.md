
# Week2

Week 2 contains content from the: Biological computing in python 1 chapter

## Files and folders in code/: 

### [align_seq.py]

This script reads two DNA sequences from an input CSV file, aligns them using a custom scoring function, and saves the best alignment along with its score to an output text file.

**Input:** CSV file with 2 DNA sequences (../data/test_seqs/seq1.csv)  
**Output:** Text file with the best alignment and score

### [basic.csv.py]

This script demonstrates how to read from and write to CSV files using the `csv` module in Python. It reads species data from a CSV file, prints species information, and writes specific columns (species name and body mass) to a new CSV file.

**Input:** `../data/testcsv.csv` (CSV file with species data)  
**Output:** `../data/bodymass.csv` (CSV file with species name and body mass)

### [basic_io1.py]

This script demonstrates how to read from a file in Python. It reads and prints each line of a file, while skipping and ignoring blank lines. The script shows both manual file opening/closing and using the `with` statement for automatic file closure.

**Input:** `../sandbox/test.txt` (Text file with content to read)  
**Output:** None (prints content to console

### [basic_io2.py]

This script demonstrates how to write data to a file in Python. It saves the elements of a list (range 0 to 99) to a text file, with each element written on a new line.

**Input:** None  
**Output:** `../sandbox/testout.txt` (Text file containing numbers from 0 to 99, each on a new line)

### [basic_io3.py]

This script demonstrates how to store and retrieve Python objects using the `pickle` module. It saves a dictionary to a file using `pickle` and then loads the dictionary back from the file for further use.

**Input:** None  
**Output:** `../sandbox/testp.p` (Binary file storing the pickled dictionary)


### [boilerplate.py]

This is a basic boilerplate script for Python programs. It demonstrates how to structure a Python script with a main entry point, import modules, and handle command-line arguments. The script prints a simple message and exits with a status code.

**Input:** Command-line arguments (if any)
**Output:** None (prints "This is a boilerplate" to the console)

### [cfexercises1.py]

This program provides various mathematical utility functions, including:
- Calculating the square root of a number.
- Finding the maximum of two numbers.
- Sorting three numbers in ascending order.
- Calculating the factorial of a number using three methods: iteratively, recursively, and with a while loop.

**Input:** Function arguments passed within the script or through the command line.  
**Output:** Prints results of the mathematical operations to the console.

### [cfexercises2.py]

This script demonstrates several functions that print "hello" based on different conditions using for loops and while loops. Each function implements unique logic for when and how "hello" is printed.

**Input:** Various function arguments passed within the script.  
**Output:** Prints "hello" to the console based on the conditions defined in each function.

### [controlflow.py]

This script provides several functions demonstrating the use of control statements in Python. It includes:
- Determining whether a number is even or odd.
- Finding the largest divisor of a number from 2, 3, 4, or 5.
- Checking if a number is prime.
- Finding all prime numbers up to a given number.

**Input:** Function arguments passed within the script.  
**Output:** Prints results (e.g., even/odd status, largest divisor, prime checks, list of primes) to the console.

### [debugme.py]

This script contains a function `buggyfunc` that attempts to perform division in a loop, catching errors such as division by zero. It demonstrates the use of try-except blocks for error handling in Python and prints the progress and errors encountered during execution.

**Input:** Integer passed to the `buggyfunc` function.  
**Output:** Prints the result of the division, along with any errors encountered (e.g., division by zero).


### [dictionary.py]

This script demonstrates how to populate a dictionary that maps taxonomic order names to sets of species (taxa). It uses both conventional loops and list comprehensions to achieve this and prints the resulting dictionary to the screen.

**Input:** A list of tuples containing species and their taxonomic order.  
**Output:** Prints a dictionary that maps each order to its respective species.

### [handlingcsvs.py]

This script reads species data from a CSV file and prints the species name along with other details. It then writes a new CSV file that contains only the species name and body mass.

**Input:** `../data/testcsv.csv` (CSV file with species data)  
**Output:** `../data/bodymass.csv` (CSV file containing species names and body mass)

### [lc1.py]

This script demonstrates the use of list comprehensions and conventional loops to extract specific information from a tuple of bird species. It performs the following:
- Creates lists of latin names, common names, and body masses using list comprehensions.
- Recreates the same lists using conventional loops.

**Input:** A tuple containing bird species data (latin name, common name, and body mass).  
**Output:** Prints lists of latin names, common names, and body masses to the console.

### [lc1.py]

This script analyzes the average UK rainfall for the year 1910 by month, using both list comprehensions and conventional loops. It performs the following tasks:
- Creates a list of month and rainfall tuples where rainfall exceeds 100 mm.
- Creates a list of month names where rainfall is less than 50 mm.
- Recreates both tasks using conventional loops.

**Input:** A list of tuple in the script containing monthly rainfall data for 1910 (month and rainfall amount).  
**Output:** Prints lists of months with

### [loops.py]

This script demonstrates basic examples of using loops in Python. It includes:
- A `FOR` loop to iterate over a range of numbers.
- A `FOR` loop to iterate over a list of mixed data types.
- A `FOR` loop that sums values in a list.
- A `WHILE` loop that increments a variable until a condition is met.

**Input:** Hardcoded values and lists within the script.  
**Output:** Prints numbers, list elements, and running totals to the console.

### [MyExampleScript.py]

This script demonstrates a simple function `foo` that multiplies a number by itself and prints the result. It also includes instructions on how to run the script using different Python interpreters in the terminal.

**Input:** An integer passed to the `foo` function within the script.  
**Output:** Prints the result of the multiplication to the console.

### [Oaks_debugme.py]

This script filters species names in a CSV file to identify those belonging to the *Quercus* genus (oak trees) and writes them to a new CSV file. It reads from an input file, processes the data, and saves the results to an output file. Additionally, the script includes a function with built-in tests using `doctest`.

**Input:** `../data/TestOaksData.csv` (CSV file containing species data)  
**Output:** `../Results/JustOaksData.csv` (CSV file containing only *Quercus* species)

### [oaks.py]

This script identifies oak species (those that start with 'Quercus ') from a given list of taxa using both for loops and list comprehensions. It also prints the oak species names in uppercase using both methods.

**Input:** A list of species names (`taxa` in code).  
**Output:** Prints oak species names and their uppercase versions to the console.

### [open.py]

This script demonstrates how to read from a text file in Python using a `with` statement. It includes examples of reading all lines from the file and skipping blank lines during the process.

**Input:**  Any txt file: `../sandbox/test.txt` (Text file used in this example)
**Output:** Prints each line from the file to the console, with the option to skip blank lines.

### [sysargv.py]

This script demonstrates the usage of `sys.argv`, which is used to access command-line arguments in Python. It prints:
- The name of the script.
- The number of arguments passed to the script.
- The list of arguments themselves.

**Input:** Command-line arguments passed when running the script.  
**Output:** Prints the script name, number of arguments, and the arguments themselves to the console.

### [test_control_flow.py]

This script demonstrates the use of control statements by determining whether a number is even or odd. It includes built-in tests using the `doctest` module to validate the functionality of the `even_or_odd` function.

**Input:** A number passed to the `even_or_odd` function within the script or through doctest.  
**Output:** Prints whether the number is even or odd, and returns test results when run with doctest.

### [tuple.py]

This script processes a tuple of bird species, each containing the Latin name, common name, and mass. It outputs each species' information on a separate line in a readable format, including the Latin name, common name, and mass.

**Input:** A tuple containing bird species data (Latin name, common name, and mass).  
**Output:** Prints each species' information (Latin name, common name, and mass) on a separate line.

### [using_name.py]

This script demonstrates how the `__name__` variable works in Python. It checks whether the script is being run directly or imported as a module and prints an appropriate message based on that. It also displays the module's name.

**Input:** None  
**Output:** Prints whether the script is being run directly or imported, along with the module's name.


#Data
This folder contains data mentioned for input in the above scripts: 

#Results
This folder contains the outputs of the above scripts, specifically: 

- oaks_debugme.py
- align_seq.py

#Sandbox
this is the sandbox area, it contains files used for experimentation: 

additionally it contains py_guides, which contains python files used for learning purposes





