#############################
# FILE OUTPUT
#############################
# Save the elements of a list to a file
list_to_save = range(100)

f = open('../sandbox/testout.txt','w') #w stands for write mode, if file exists, contents will be overwritten, if not, contents created 
for i in list_to_save:
    f.write(str(i) + '\n') ## Add a new line at the end
#this tring of text created a txt file goin from 0 to 99 where each number is written on a new line
f.close() #ensure the file is closed, data saved correctly and no longer used by programme