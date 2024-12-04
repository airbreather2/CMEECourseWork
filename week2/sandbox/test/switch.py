count = 18

for i in range(0, 19):
    if count >= 1:
        count -= 1  # Corrected decrement operator
        print(str(count) +  " shots left bruh")
    elif count == 0:
        print("Reloading..")
        break  # Remove this line or place it inside a loop condition if needed
  