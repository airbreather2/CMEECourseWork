import subprocess

p = subprocess.Popen(["ls", "-l"], stdout=subprocess.PIPE)
stdout, stderr = p.communicate()

print(stdout.decode())


#call python itself from bash: ives output of boilerplate script (need to be in right directory)
s = subprocess.Popen(["python3", "boilerplate.py"], stdout=subprocess.PIPE, stderr=subprocess.PIPE) # A bit silly! 
stdout, stderr = p.communicate()

print(stdout.decode())

#to compile a latex doccuments
subprocess.os.system("pdflatex yourlatexdoc.tex")