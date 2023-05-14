using ProgressMeter
using Serialization
using Plots
using DelimitedFiles
using Logging
using ArbNumerics, Readables
using Printf

setprecision(BigFloat, 250; base=10)


Mp = BigFloat("250.0")
L = BigFloat("1.0")
rp = 1

exp = Mp - 10
pk = 40
h = 1//20
ts = -2*pk
te = -h
v0 = -pk
vmax = 0
u0 = 0
umax = pk
k1 = (vmax -v0)//h
k2 = (umax -u0)//h
TortStart = v0 - umax
ma = 0
max = 0

ch = big"0.0"
mu = big"0.0"
kp = big"2.0"