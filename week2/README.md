
# Week2

### Week 2 contains content from the: Biological computing in python 1 chapter

#### code used: 

-python

## Files and folders in code/: 


### align_seq.py

#### Description
This script compares two DNA sequences from a CSV file, aligns them, and calculates the best alignment based on the number of matching bases. It uses a scoring function to find the optimal match and saves the alignment result, along with its score, to a text file.

#### Features
The script includes the following key operations:
- **Loading DNA Sequences**: Reads two DNA sequences from a CSV file.
- **Sequence Alignment**: Assigns the longer sequence to `s1` and the shorter sequence to `s2` and calculates alignment scores.
- **Optimal Alignment Calculation**: Determines the alignment with the highest score and displays a visual representation.
- **Saving Results**: Saves the best alignment, associated DNA sequence, and alignment score to a text file.

#### Dependencies
This script requires Python 3.x. No additional libraries are needed, but a properly formatted CSV file is essential.

#### Usage
1. Prepare a CSV file containing two DNA sequences in the first two columns, with a header row.
2. Run the script in a Python environment:

bash
python3 align_seq.py


### basic_csv.py

#### Description
This script demonstrates how to read from and write to CSV files using the `csv` module in Python. It performs the following tasks:
- **Reading Data**: Reads data from a CSV file and prints species information.
- **Writing Data**: Extracts specific columns (species name and body mass) from the input CSV file and writes them to a new CSV file.

#### Features
- Reads the file `../data/testcsv.csv`, which contains the following columns:
  - `Species`
  - `Infraorder`
  - `Family`
  - `Distribution`
  - `Body mass male (Kg)`
- Extracts the `Species` and `Body mass male (Kg)` columns and saves them in a new file, `../data/bodymass.csv`.

#### Dependencies
This script requires:
- Python 3.x
- A CSV file named `testcsv.csv` in the `../data/` directory with at least five columns.

#### Usage
1. Place the input CSV file (`testcsv.csv`) in the `../data/` directory.
2. Run the script in a Python environment:

   ```bash
   python3 basic_csv.py
```

### basic_io1.py

## Description

This script demonstrates fundamental techniques for reading and processing files in Python. It showcases multiple methods for handling file input, including reading the entire file at once, iterating through each line, and skipping blank lines. The script also demonstrates the use of both manual file handling and the `with` statement to automatically close files.

## Features

The script includes the following key operations:

1. **Basic File Reading**: Opens a file and reads each line, printing the content to the console.
2. **Skipping Blank Lines**: Reads each line individually and prints only non-blank lines, skipping empty or whitespace-only lines.
3. **Automatic File Closure with `with`**: Uses the `with` statement to manage file resources automatically, ensuring files are closed after reading is complete.
4. **Error Handling**: Implements error handling for common file-related issues, including:
   - Missing files (`FileNotFoundError`)
   - File access or permission issues (`OSError`)

## Usage

1. Place the target file, `test.txt`, in the relative path `../sandbox/`.
2. Run the script in a Python environment using

   ```bash
   python3 basic
      ``` 
#### dependencies
- Python3 only

### basic_io2.py

#### Description
This script demonstrates how to write data to a file in Python. It performs the following tasks:
- Saves each element from a list of numbers (ranging from 0 to 99) to a text file.
- Writes each element on a new line in the output file `testout.txt` located in the `../sandbox` directory.

#### Dependencies
This script requires Python 3.x. No additional libraries are needed.

#### Usage
The script iterates over a list of numbers and writes each to a new line in the output file. If the file or directory is missing, or if there is a file access issue, an appropriate error message is displayed.

#### License
This code is available under the "License for this code/program".

#### Code Logic
1. Defines a list of numbers from 0 to 99.
2. Attempts to write each element to `../sandbox/testout.txt`, creating the file if it doesn’t exist or overwriting it if it does.
3. Handles errors if the file path is missing or inaccessible, printing error messages for:
   - File not found (`FileNotFoundError`)
   - File corruption or lack of permission (`OSError`)

### `basic_io3.py`

#### Description
This script demonstrates how to store and retrieve Python objects using the `pickle` module. Specifically, it performs the following tasks:
- Saves a dictionary object to a binary file for later use.
- Loads the dictionary from the file and verifies the data integrity by printing it.

#### Dependencies
- **Python 3.x**: Required for compatibility with the `pickle` module.
  
#### Usage
The script uses the following steps to save and retrieve data:
1. **Dictionary Creation**: A dictionary with key-value pairs is created.
2. **Saving the Dictionary**: The `pickle.dump()` function is used to serialize the dictionary and save it in binary format to `../sandbox/testp.p`.
3. **Loading the Dictionary**: The file is reopened, and `pickle.load()` deserializes the data back into a dictionary, which is then printed to verify it matches the original.

#### License
This code is available under the "License for this code/program".


### boilerplate.py

#### Description
This is a boilerplate script designed to serve as a starting template for Python programs. It includes basic structure and explanations for:
- The purpose of the shebang line.
- The use of docstrings for documentation.
- The inclusion of metadata such as application name, author, version, and license.
- Main entry point logic with `if __name__ == "__main__"`.


#### Dependencies
- Python 3.x
- `sys` module: Used to interface the script with the operating system.

#### Usage
1. Modify the script as needed for your application.
2. Run the script in a Python environment:

   ```bash
   python3 boilerplate.py
```

### cfexercises1.py

#### Description
This program provides a collection of mathematical utility functions, including:
- Calculating the square root of a number.
- Finding the maximum of two numbers.
- Sorting three numbers in ascending order.
- Calculating the factorial of a number using:
  - Iterative method
  - Recursive method
  - While loop

Additionally, the script uses `doctest` to validate the correctness of the functions through embedded test cases.

#### Features
1. **Square Root Calculation**:
   - Function: `foo_1(x)`
   - Calculates the square root of a given number.

2. **Maximum of Two Numbers**:
   - Function: `foo_2(x, y)`
   - Finds the larger of two numbers.

3. **Sorting Three Numbers**:
   - Function: `foo_3(x, y, z)`
   - Sorts three numbers in ascending order.

4. **Factorial Calculation**:
   - Iterative: `foo_4(x)`
   - Recursive: `foo_5(x)`
   - While Loop: `foo_6(x)`

5. **Embedded Testing**:
   - The script uses `doctest` to run test cases directly embedded within the function docstrings.

#### Dependencies
- Python 3.x
- No additional libraries are required beyond the standard library.

#### Usage
1. Run the script in a Python environment:

   ```bash
   python3 cfexercises1.py
```
### cfexercises2.py

#### Description
This script demonstrates the use of various control flow structures, including `for` loops, `while` loops, and conditional statements. Each function prints "hello" based on different conditions.

#### Features
- **`hello_1`**: Prints "hello" for values divisible by 3 in the range 0 to `x-1`.
- **`hello_2`**: Prints "hello" for values with a remainder of 3 when divided by 5 or 4.
- **`hello_3`**: Prints "hello" for each integer between `x` (inclusive) and `y` (exclusive).
- **`hello_4`**: Prints "hello" repeatedly, incrementing `x` by 3 until it equals 15.
- **`hello_5`**: Prints "hello" once for `x=18` and seven times for `x=31`.
- **`hello_6`**: Prints "hello!" followed by `y` incremented by 1 until `y=6`.

#### Dependencies
- Python 3.x
- No additional libraries required.

#### Usage
1. Run the script in a Python environment:

   ```bash
   python3 cfexercises2.py
```

### control_statements.py

#### Description
This script demonstrates the use of control statements in Python, including conditionals and loops. It provides functions to determine properties of numbers and find prime numbers.

#### Features
- **`even_or_odd(x)`**: Determines if `x` is even or odd.
- **`largest_divisor_five(x)`**: Finds the largest divisor of `x` among 2, 3, 4, and 5.
- **`is_prime(x)`**: Checks if `x` is a prime number.
- **`find_all_primes(x)`**: Finds all prime numbers up to `x`.

#### Dependencies
- Python 3.x
- No additional libraries required.

#### Usage
1. Run the script in a Python environment:

   ```bash
   python3 control_statements.py
``` 

### debugme.py

#### Description
This script demonstrates the use of try-except blocks for error handling in Python. It contains a function `buggyfunc` that performs a division operation in a loop and handles errors such as division by zero. The script is useful for understanding how to manage and debug errors effectively during runtime.

#### Features
- **`buggyfunc(x)`**:
  - Performs a division operation inside a loop.
  - Uses `try-except` blocks to catch and handle:
    - **ZeroDivisionError**: Handles cases where division by zero occurs.
    - **Other Exceptions**: Captures any unexpected errors and provides debug information.
  - Prints progress and error messages during execution.

#### Dependencies
- Python 3.x
- No additional libraries required.

#### Usage
1. Run the script in a Python environment:

   ```bash
   python3 debugme.py
```

### dictionary.py

#### Description
This script demonstrates how to create a dictionary that maps taxonomic order names to sets of species. It uses both conventional loops and dictionary comprehensions to achieve this, showcasing two approaches for solving the same problem.

#### Features
- **Taxonomic Mapping**:
  - Creates a dictionary where keys are taxonomic order names, and values are sets of species within those orders.
- **Two Implementation Methods**:
  - **For Loop**: Iteratively populates the dictionary by checking if an order exists and appending species to it.
  - **List Comprehension**: Concisely builds the dictionary in a single line.

#### Dependencies
- Python 3.x
- No additional libraries required.

#### Usage
1. Run the script in a Python environment:

   ```bash
   python3 dictionary.py
```

### handling_csvs.py

#### Description
This script demonstrates how to handle CSV files using Python's `csv` module. It includes the following functionality:
- Reading data from an input CSV file that contains taxonomic details of species.
- Converting each row of the input CSV file into a tuple and storing it in a list.
- Printing each row and the species name to the console.
- Writing a new CSV file containing only the species names and their body masses.

The script is designed to process taxonomic data efficiently and illustrates basic file I/O operations in Python.

#### Features
1. **Read Data from a CSV File**:
   - Reads a CSV file (`testcsv.csv`) with the following columns:
     - `Species`
     - `Infraorder`
     - `Family`
     - `Distribution`
     - `Body mass male (Kg)`
   - Prints each row and the species name to the console.
   - Converts rows into tuples and stores them in a list.

2. **Write Filtered Data to a CSV File**:
   - Creates a new CSV file (`bodymass.csv`) containing only:
     - `Species`
     - `Body mass male (Kg)`
   - Writes these filtered columns from the input file.

#### Dependencies
- Python 3.x
- `csv` module: Used for reading and writing CSV files.
- Input CSV file: The script expects a file named `testcsv.csv` in the `../data/` directory with

### lc1.py

#### Description
This script demonstrates the use of **list comprehensions** and **conventional loops** to extract specific information from a tuple of bird species. The script performs the following tasks:
- Creates lists of:
  - Latin names of the bird species.
  - Common names of the bird species.
  - Mean body masses of the bird species (in grams).
- Recreates these lists using conventional loops, showcasing the difference between the two approaches.

#### Features
1. **List Comprehensions**:
   - Creates separate lists for Latin names, common names, and body masses in a concise manner.
   
2. **Conventional Loops**:
   - Recreates the same lists using explicit loops to append items to the lists.

3. **Example Output**:
   - Prints the lists generated by both methods for comparison.

#### Dependencies
- Python 3.x
- No additional libraries required.

#### Usage
1. Run the script in a Python environment:

   ```bash
   python3 lc1.py
```
### lc2.py

#### Description
This script analyzes the average UK rainfall for the year 1910 by month, using both **list comprehensions** and **conventional loops**. It performs the following tasks:
1. Creates a list of `(month, rainfall)` tuples for months with rainfall exceeding 100 mm.
2. Creates a list of month names for months with rainfall below 50 mm.
3. Recreates both tasks using conventional loops for comparison.

#### Features
1. **List Comprehensions**:
   - Efficiently filters and processes rainfall data to generate required lists.
   
2. **Conventional Loops**:
   - Achieves the same results as the list comprehensions but through explicit iteration and conditional checks.

3. **Example Output**:
   - Displays the months with rainfall greater than 100 mm.
   - Displays the months with rainfall less than 50 mm.

#### Dependencies
- Python 3.x
- No additional libraries required.

#### Usage
1. Run the script in a Python environment:

   ```bash
   python3 lc2.py
``` 
### loops.py

#### Description
This script demonstrates the use of **loops** in Python through basic examples. It includes:
- **FOR loops**: Iterating over ranges, lists, and summing elements in a list.
- **WHILE loop**: Incrementing a variable until a condition is met.

#### Features
1. **FOR Loop - Range Iteration**:
   - Iterates over numbers in a range (0 to 4) and prints each value.
   
2. **FOR Loop - List Iteration**:
   - Iterates over a list containing mixed data types (`int`, `str`, `float`, `bool`) and prints each element.

3. **FOR Loop - Summing List Elements**:
   - Iterates over a list of numbers (`summands`) and calculates the running total, printing it after each addition.

4. **WHILE Loop**:
   - Initializes a variable (`z`) at 0 and increments it by 1 in each iteration until it reaches 100, printing the value of `z` during each step.

#### Dependencies
- Python 3.x
- No additional libraries required.

#### Usage
1. Run the script in a Python environment:

   ```bash
   python3 loops.py
``` 
### [MyExampleScript.py]

This script demonstrates a simple function `foo` that multiplies a number by itself and prints the result. It also includes instructions on how to run the script using different Python interpreters in the terminal.

**Input:** An integer passed to the `foo` function within the script.  
**Output:** Prints the result of the multiplication to the console.

### oaks_debugme.py

#### Description
This script filters species names from a CSV file to identify those belonging to the genus **Quercus** (oak trees). The script processes the input data, extracts relevant species, and writes the results to a new CSV file. Additionally, it includes a function, `is_an_oak`, with built-in tests using Python's `doctest` module to ensure functionality.

#### Features
1. **`is_an_oak(name)` Function**:
   - Checks if a given species name belongs to the genus **Quercus** (case-insensitive).
   - Includes tests within the function, runnable using the `doctest` module.

2. **Data Processing**:
   - Reads species data from an input CSV file (`TestOaksData.csv`).
   - Filters species names belonging to the genus **Quercus**.
   - Writes the filtered data to a new output CSV file (`JustOaksData.csv`).

3. **Built-in Testing**:
   - The `is_an_oak` function is tested with `doctest` to ensure correct results for various input cases.

#### Dependencies
- Python 3.x
- `csv` module: For reading and writing CSV files.
- `doctest` module: For testing the `is_an_oak` function.
- Input CSV file: The script expects a file named `TestOaksData.csv` in the `../data/` directory with at least two columns (`Genus` and `Species`).

#### Usage
1. Place the input file (`TestOaksData.csv`) in the `../data/` directory.
2. Run the script in a Python environment:

   ```bash
   python3 oaks_debugme.py
``` 
### oaks.py

#### Description
This script identifies oak species (those whose names start with `'Quercus '`), using both **for loops** and **list comprehensions**. Additionally, it converts the names of identified oak species to uppercase, showcasing two approaches to achieve the same results.

#### Features
1. **`is_an_oak(name)` Function**:
   - Checks if a given species name starts with `'quercus '` (case-insensitive).
   - Returns `True` for valid oak species names, `False` otherwise.

2. **Identifying Oak Species**:
   - **Using For Loops**: Iterates through a list of species, identifying oaks and adding them to a set.
   - **Using List Comprehensions**: Concisely creates a set of oak species names that match the condition.

3. **Converting Oak Names to Uppercase**:
   - **Using For Loops**: Converts identified oak species names to uppercase and stores them in a set.
   - **Using List Comprehensions**: Achieves the same result with a compact one-liner.

#### Dependencies
- Python 3.x
- No additional libraries required.

#### Usage
1. Run the script in a Python environment:

   ```bash
   python3 oaks.py
``` 
### open.py

#### Description
This script demonstrates the usage of Python's `open` function for file handling. It showcases two examples of reading a file:
1. Reading and printing all lines from a file.
2. Reading and printing only non-blank lines from a file.

The script utilizes the `with` statement to manage file resources, ensuring that the file is safely closed after processing.

#### Features
1. **File Reading**:
   - Opens the file `test.txt` in read mode and prints each line.
   - Demonstrates the use of an implicit loop to iterate through the lines of the file.

2. **Skipping Blank Lines**:
   - Reads the file again, skipping any blank lines using a condition (`len(line.strip()) > 0`) to print only non-blank lines.

3. **Automatic File Closure**:
   - Uses the `with` statement for file handling, ensuring that files are automatically closed without requiring a manual `close()` call.

#### Dependencies
- Python 3.x
- An input file named `test.txt` located in the `../sandbox/` directory.

#### Usage
1. Ensure the input file (`test.txt`) exists in the `../sandbox/` directory.
2. Run the script in a Python environment:

   ```bash
   python3 open.py
``` 
### sysargv.py

#### Description
This script demonstrates the usage of Python's `sys.argv` for accessing command-line arguments. It prints:
1. The name of the script.
2. The number of arguments passed to the script.
3. The list of arguments themselves.

#### Features
1. **Command-Line Arguments**:
   - Accesses the script name and arguments passed to it using `sys.argv`.
   - Prints details about the script and its arguments to the console.

2. **Dynamic Argument Handling**:
   - Handles any number of arguments, making it useful for testing and learning about command-line argument passing in Python.

#### Dependencies
- Python 3.x
- `sys` module: Used to access command-line arguments.

#### Usage
1. Save the script as `sysargv.py`.
2. Run the script with different arguments in a terminal or command line:

   **Example 1**: Run with no arguments.
   ```bash
   python3 sysargv.py
``` 

output: This is the name of the script:  sysargv.py
Number of arguments:  1
The arguments are:  ['sysargv.py']

   **Example 2**: Run with 2 arguments.
   ```bash
   python3 sysargv.py var1 var2 
   ``` 
This is the name of the script:  sysargv.py
Number of arguments:  3
The arguments are:  ['sysargv.py', 'var1', 'var2']
   
### control_statements.py

#### Description
This script demonstrates the use of control statements in Python through the function `even_or_odd`, which determines if a number is even or odd. The script includes:
- **Functionality**:
  - Handles both positive and negative numbers.
  - Provides results in a user-friendly string format.
- **Built-in Testing**:
  - Utilizes Python's `doctest` module to test the function directly within the script.

#### Features
1. **`even_or_odd(x)` Function**:
   - Accepts an integer (`x`) as input.
   - Determines whether the number is even or odd.
   - Handles negative numbers by checking the modulus of their absolute value.

2. **Embedded Testing with `doctest`**:
   - Provides test cases within the function docstring.
   - Runs these tests automatically upon script execution.

3. **Example Usage**:
   - Prints results for specific test values in the `main()` function.

#### Dependencies
- Python 3.x
- `doctest` module: For testing the function with embedded examples.

#### Usage
1. Run the script in a Python environment:

   ```bash
   python3 control_statements.py
``` 
### tuple.py

#### Description
This script processes a tuple containing bird species data, where each entry includes:
- **Latin name**: The scientific name of the bird.
- **Common name**: The widely known name of the bird.
- **Mass**: The bird's mass in grams.

The script outputs each species' information on a separate line in a readable format, displaying the Latin name, common name, and mass.

#### Features
1. **Bird Data Processing**:
   - Iterates through a tuple of bird species (`birds`).
   - Extracts the Latin name, common name, and mass for each bird.

2. **Formatted Output**:
   - Prints the bird information in the format:
     ```
     Latin name: <Latin Name> Common name: <Common Name> Mass: <Mass>
     ```

#### Dependencies
- Python 3.x
- No additional libraries required.

#### Usage
1. Run the script in a Python environment:

   ```bash
   python3 tuple.py
``` 
### using_name.py

#### Description
This script demonstrates the functionality of the `__name__` variable in Python. It checks whether the script is being run directly or imported as a module and prints an appropriate message. Additionally, it displays the module's name to illustrate how `__name__` behaves in different contexts.

#### Features
1. **Direct Execution Check**:
   - Prints "This program is being run by itself!" if the script is executed directly.

2. **Import Check**:
   - Prints "I am being imported from another script/program/module!" if the script is imported as a module.

3. **Module Name Display**:
   - Displays the value of the `__name__` variable, which is:
     - `"__main__"` if the script is executed directly.
     - The module's name if it is imported.

#### Dependencies
- Python 3.x
- No additional libraries required.

#### Usage
1. **Run Directly**:
   Execute the script in a Python environment:

   ```bash
   python3 using_name.py
``` 
# Data
This folder contains data mentioned for input in the above scripts: 

# Results
This folder contains the outputs of the above scripts

# Sandbox
this is the sandbox area, it contains files used for experimentation: 






