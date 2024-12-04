print("Hello, this is R!")

#Rscript --verbose TestR.R > ../results/TestR.Rout 2> ../results/TestR_errFile.Rout

#heck the contents of TestR.Rout and TestR_errFile.Rout. The former should contain the output of the R script, and the latter the additonal information produced due to the --verbose flag.

#subprocess.Popen("Rscript --verbose TestR.R > ../results/TestR.Rout 2> ../results/TestR_errFile.Rout", shell=True).wait()

#shell=TRUE because we want subprocess to execute a non-standard R command
#.wait() to allow Rscript to terminate
#remove stdout=subprocess.PIPE, stderr=subprocess.PIPE, because they won't work when using wait()

# Dynamically constructs a file path that works across different operating systems
# os.path.join() ensures the correct path separator is used for the OS (e.g., '/' on Unix, '\' on Windows)
# This prevents errors from hardcoding file paths and makes the code more flexible and readable
MyPath = subprocess.os.path.join('directory', 'subdirectory', 'file')

