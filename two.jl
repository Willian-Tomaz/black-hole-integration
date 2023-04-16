include("one.jl")
using Plots
using Printf
using DecFP

Mp = 250
ch = 0.0
mu = 0.0
kp = 0.0
rp = 1.0
L = 1.0
exp = Mp - 10
pk = 50.0
h = 1.0/100.0
ts = -2.0*pk
te = -h
v0 = -pk
vmax = 0.0
u0 = 0.0
umax = pk
k1 = (vmax -v0)/h
k2 = (umax -v0)/h
TortStart = v0 - umax
ma = 0.0
max = 0.0

function phi_(r)
    phi = (rp*ch)/r^2
    return phi
end

function derivada_g(r)
    res = (2*r)/L^2
    return res
end

function V(r)
    phi = phi_(r)
    g = (r^2 - rp^2) / L^2
    return g/4 * (-(g/(4r^2)) + derivada_g(r)/2r + kp^2/r^2 + mu^2) - phi^2/4
end


function P2a(r)
    return -im * phi_(r) / 2
end

function fch(r)
    res1 = (L^2 * log(Complex(1 - r/rp)) ) / ( 2 *rp )
    res2 = ( L^2 * log(Complex(1 + r/rp)) ) / (2 * rp)
    res =  res1 - res2
    return real(res)
end

x = range(rp, 10*rp, step=0.1)
y = []

for i in x
    a = V(i)
    push!(y,a)
end

plot(r -> V(r), rp, 10rp, xlabel="r", ylabel="V(r)", title="Gráfico de V(r)")
savefig("gráfico_2/grafico_1.png")

P = zeros(Float64, (Int((te-ts)/h) + 2, 1))


P2 = zeros(Float64, (Int((te-ts)/h) + 2, 1))

for i in 1:div(te - ts, h) + 1
    P[i] = V[tort[i]]
    end

