

s = "this is a string"
len(s) #determiunes length
#18

s.replace(" ","-") # Substitute spaces " " with dashes
#'-this-is-a-string-'

s.find("s") # First occurrence of s (remember, indexing starts at 0)

s.count("s")# Count the number of "s"
#3


t = s.split() # Split the string using spaces and make a list 
t
#['this', 'is', 'a', 'string']

t = s.split(" is ") # Split the string using " is " and make a list out of it
t

t= s.strip() #remove trailing spaces
t
# 'this is a string'

s.upper()

#'THIS IS A STRING'

s.upper().strip() #can perform sequential operations

'WORD'.lower() #can perform operations directly on a literal string
#'word'

# ?can be used after a command for an explanation aswell as help()

