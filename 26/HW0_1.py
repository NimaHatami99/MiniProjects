import math
def f(x):
    return math.sin(math.pow(x,2))
sum=0
for i in range(-3*200,4*200):
    #print(i/200,end=',')
    m=i/200+(1/200)/2
    sum+=f(m)
integral = sum * (1/200)
print("The value of integral is: ",integral)