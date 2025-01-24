# Final CMEE Bootcamp Assessment: Sebastian

*Overall organization OK - weekly directory naming convention kinda fell of the cliff after the bootcamp weeks!*

## Week 1

- The structure of the project directory was consistent and logical, with dedicated folders for `code`, `data`, `results`, and `sandbox`.
- The README file was present and provided a basic overview of the week's objectives, though it lacked detailed descriptions of some scripts and their usage.
- Minimal errors were detected in this week's scripts, mainly related to file paths in the `sandbox` directory.

## Week 2

  - The README file for Week 2 included descriptions of all scripts, which was an improvement over Week 1.
  - Code modularity was slightly better, with smaller, well-defined functions.
  - Scripts like `align_seq.py` were well-written, with logical flow and adequate commenting.
  - The use of standard Python libraries was effective, but docstrings were missing in some scripts, which would have improved readability.
  - Syntax was correct, but error handling could have been enhanced in `basic_csv.py` to account for missing or malformed input files.
  - Scripts such as `basic_io1.py` demonstrated clear logic for reading and writing files.
  - Error messages were handled more gracefully in cases of missing files or directories.
  - Output files were saved with proper naming conventions, making them easy to locate and interpret - good!
  - A minor issue was identified in `basic_io2.py`, where an attempt to write to a non-existent directory caused the script to fail. Adding a check to create missing directories would resolve this.
  - You could have formatted the output of certain scripts to be a little neater/organised/informative -- for example lc1.py is perfectly functional, but the output could have been improved (compare with my solution). 
 - Python scripts such as `align_seqs.py` demonstrated some modularity but still scope for improvement.

## Week 3

- The quality of the README file improved further, including a brief description of dependencies and usage instructions for each script.
- `basic_io.R` and `control_flow.R` were fine - no improvements detected.
- Outputs from R scripts were correctly formatted and saved in the `results` folder.
- An error in `treeheights.R` related to a missing `results` directory could have been avoided with pre-checks.

## Week 4
- There was a noticeable improvement in the use of Python's `subprocess` module to interact with R scripts.
- Jupyter notebooks were introduced but contained syntax errors and incomplete cells.
- Python scripts from the group practicals were included but lacked uniform formatting and consistent error handling.
- Python scripts had inconsistent formatting of printed output, which could confuse users.
- Scripts like `subprocess.py` demonstrated advanced concepts but suffered from circular import errors due to poor naming conventions.
- The Jupyter notebook included mixed Python and R code, which was innovative but poorly executed.
- Errors in the notebook's LaTeX equations and missing output files from `TestR.py`.
- Several runtime errors were detected, particularly in `subprocess.py` - need more robust testing.

 - Your Groupwork practicals were all in order, and your group did OK in collaborating  - have a look at my group-specific feedback (already pushed to the git repo).

## Florida Autocorrelation Temperatures Practical

- The R scripts provided for this practical were functional but lacked comments explaining the methodology.
- The output files were well-formatted but included unnecessary rows, which could confuse readers.
- The LaTeX report had good formatting; has some minor grammatical errors. 
- Fitting a linear regression is not justified...
- Your statistical and biological/ecological interpretations could have been more succinct / insightful. The conclusion was unclear / missing at the end.

---

## Git Practices

- Git usage improved across the weeks, with more frequent and meaningful commit messages.
- The repository size grew significantly due to committed binary files, which should have been avoided by updating the `.gitignore` file.

---

### Overall Assessment

Overall, a good job. 

You demonstrated significant improvement in project organization, coding practices, and documentation over four weeks. In the future, focus more on modularizing code, improving documentation, and writing descriptive commit messages for sustained progress. Focusing on Jupyter notebooks will elevate the overall quality of your work coming up.

Some of your scripts did retain some fatal errors. Try to be a little more persistent in chasing down errors in future. Your commenting is ok; this will improve experience.

It was a tough set of weeks, but I believe your hard work in them has given you a great start towards further training, a quantitative masters dissertation, and ultimately a career in quantitative biology! 

---

### (Provisional) Mark
 *68*