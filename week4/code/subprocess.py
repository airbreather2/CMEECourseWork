

import subprocess

#two mainw ways to run subprocess, run and popen
#popen give more direct control


p = subprocess.Popen(["echo", "I'm talkin' to you, bash!"], stdout=subprocess.PIPE, stderr=subprocess.PIPE)

stdout, stderr = p.communicate()
#stout is the output from the process "spawned" by you command, this is a sequence of bytes(which you will need to decode)
#stderr is the error code(checks if process ran sucessfully or not) pipe creates a new pipe to the output of the "child process".

stdout 
print(stdout.decode()) # encode and print

#universal_newlines = True : returns these outputs as encoded texts

p = subprocess.Popen(["ls", "-l"], stdout=subprocess.PIPE)
stdout, stderr = p.communicate()

print(stdout.decode())


#When you need to run an external program or script that's separate from the current Python code.
#When you want to capture both the output and errors for logging or debugging purposes.
#When you need to manage long-running processes asynchronously or in parallel.
