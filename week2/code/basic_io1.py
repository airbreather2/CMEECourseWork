#############################
# FILE INPUT
#############################
# Open a file for reading
f = open('../sandbox/test.txt', 'r')
# use "implicit" for loop:
# if the object is a file, python will cycle over lines
for line in f:
    print(line)

# close the file
f.close()

# Same example, skip blank lines
f = open('../sandbox/test.txt', 'r')
for line in f:
    if len(line.strip()) > 0: #gets rid of emtpy lines: returns length of string after it has been stripped of white spaces 
        print(line)

f.close()#ensure the file is closed, data saved correctly and no longer used by programme 
