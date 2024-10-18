import ipdb
import csv
import sys

def load_sequence(filename):
    #csv file check
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

# A function that computes a score by returning the number of matches starting
# from arbitrary startpoint (chosen by user)
def calculate_score(s1, s2, l1, l2, startpoint): #takes these as inputs
    matched = "" # to hold string displaying alignements
    score = 0
    for i in range(l2):
        if (i + startpoint) < l1: #iterates through length of  chosen start point and checks 
            if s1[i + startpoint] == s2[i]: # if the bases match
                matched = matched + "*" # a star is added to matched indicating a match
                score = score + 1 # score counter goes up
            else:
                matched = matched + "-" #otherwise a dash is indicated showing no match

    # some formatted output
    print("." * startpoint + matched) #asterisk multiples number of dots by assigned startpoint value to indicate value at which it starts          
    print("." * startpoint + s2) #same as above but for the sequence of the second dna string
    print(s1) #prints first dna sequence
    print(score) #prince matches score below
    print(" ") #blank line for spacing

    return score #returns score value back to function where it is defined 



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
    with open(file_path, 'w') as outfile: 
        outfile.write("Best Alignment:\n")
        outfile.write(best_alignment + "\n")
        outfile.write(s1 + "\n")
        outfile.write(f"Best Score: {best_score}\n")
    print(f"Results saved to {file_path}")
    
file_path = "../../Results/Best-alignment-Results.txt"
save_to_text(file_path, my_best_align, s1, my_best_score)


# saves output to txt file

