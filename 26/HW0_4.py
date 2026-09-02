import numpy as np
import matplotlib.pyplot as plt
import math
def F():
    n=int(input("Please enter the polynomial's degree s.t. an.x^n+an-1.x^n-1 + ... +a0 and an!=0. n= "))
    if n<0:
        print("invalid input. please enter a positive integer or zero.")
        CO=F()
        return CO
    a=[]
    print("please enter coefficients from an to a0.")
    for i in range(n+1):
        j=float(input("please enter a coefficient: "))
        a.append(j)
    CO=np.array(a)
    return CO
COF=F()
print("The coefficients of the function:",COF,sep='\n')
def DF(x):
    n=x.size-1
    if n==0:
        DCO=np.array([0])
        return DCO
    b=[]
    for i in range(n):
        b.append((n-i)*x[i])
    DCO=np.array(b)
    return DCO
DCOF=DF(COF)
print("The coefficients of function's derivative:",DCOF,sep='\n')
def make_poly(x,t):
    n=x.size-1
    y=0
    for i in range(n+1):
        y += x[n-i] * t**i
    return y
t=np.arange(0,10,0.001)
f=make_poly(COF,t)
df=make_poly(DCOF,t)
plt.plot(t,f,c='b',linewidth=5,label='V(t)')
plt.plot(t,df,'g--',label="V'(t)")
plt.xlabel("---------> t(s)")
plt.ylabel("---------> V(mv)")
plt.title("function and derivative")
plt.legend()
plt.grid()
plt.show()
