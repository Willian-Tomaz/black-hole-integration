import matplotlib.pyplot as plt
import numpy as np
import math
from mpmath import mp

def g (r, rp, L):
  g = (r**2 - (rp)**2)/(L**2)
  
  return g

def tor(r):
  tot = (L**2 * ( - ((mp.atanh(rp/r))) / rp   ))
  return tot

Mp = 250
L = 1
rp = 1
exp = Mp - 10
pk = 50
h = 1/100
ts = - 2*pk
te = -h
v0 = -pk
vmax = 0
u0 = 0
umax = pk
ma = 0
TortStart = v0 - umax
k1 = (vmax-v0) / h
k2 = (umax - u0) / h
min = tor(rp+10**-exp)


x= np.arange(rp,10 * rp,0.1)
y = []
for i in x:
  a = tor(i)
  y.append(a)

plt.plot(x, y)
 
x = 240
eps = 10**(-x)  # e.g. eps = 1e-240
res = -0.5 * math.log((2 + eps)/eps)
print(res)


ts1 = 10**1
ma = 0
while True:
    max = ts1
    ts1 = i 
    ma = ma + 2
    print("ma 1: ", ma)
    break
 