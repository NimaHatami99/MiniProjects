import math
n=int(input("Please, enter an integer: "))
########### The Function ###########
def isprime(x):
    if x==1:
        return 0
    if (x==4) | (x==6) | (x==8) | (x==9):
        return 0
    for i in range(2,math.floor(math.pow(x,0.5))):
        if x % i == 0:
            return 0
    return 1
####################################
if isprime(n)==0:
    print("This isn't a prime number.")
else:
    print("This is a prime number.")