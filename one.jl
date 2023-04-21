include("log.jl")
using Plots
using Printf
using DecFP
using DelimitedFiles
using Logging

using ArbNumerics, Readables

setprecision(BigFloat, 800)

Mp = big"250.0"
L = big"1.0"
rp = big"1.0"

function g(r)
    g = ( r^2 - rp^2 ) / L^2
    return g
end

function tor(r_)
    a = rp / r_
    res = L^2 * (  - atanh(a)/rp )
    return res
end

function arctanh(x)
    if abs2(x) < 1
        res = log( ( 1 + x ) / (1 - x)  )
    else
        res = sign(x) * log1p( ( 2 * abs(x) ) / (1 - abs2(x)) )
    end
    return 0.5*res
end
 
function tor_preciso(x) # atanh (1 + 10^⁻240)
    eps = 10.0^(-x)
    res = 0.5 * log(( 2 + eps )/eps)
    res2 = L^2 * (  - res/rp )
    return res2
end

x = range(rp, 10*rp, step=0.1)
y = []

for i in x
    a = tor(i)
    push!(y,a)
end
plot(x, y, origin = true, xlabel = "x", ylabel = "y", legend = false)
savefig("1_gráfico/grafico_1.png")

exp = Mp - 10
pk = 50
h = 1/1
ts = -2*pk
te = -h
v0 = -pk
vmax = 0
u0 = 0
umax = pk
k1 = (vmax -v0)/h
k2 = (umax -u0)/h
TortStart = v0 - umax
ma = 0
max = 0
min = tor_preciso(exp)
 
function tor_2(r_)
    a = rp / r_
    b = arctanh(BigFloat(a))
    res = L^2 * (-b / rp)
    return res
end

function valor_atanh(x)
    a = 1 / big(10)^x
    y = atanh(a)
    res = L^2 * (  - y/rp )
    return res
end

for i = 100:-1:2
    if -valor_atanh(i) < h 
        global max = 10.0^i
    else
        global ma = ma + 2.0
    end
end

data()

function find_root(f, a, b, precision)
    oldm = a
    n = a
    p = b
    m = (a + b)/2
    g = 10^(-precision)
    while abs(n - p) > g && oldm != m
        oldm = m
        val = f(m)
        if val > 0
            p = m
        elseif val < 0
            n = m
        else
            break
        end
        m = (n + p)/2
    end
    return m
end

t = @elapsed begin
    tort = [find_root(r -> tor_2(r) - test, rp + 10.0^-exp, max, Mp) for test in ts:h:te]
end
t_rounded = round(t, digits=2)

@info "Tempo de execução (tort): $t_rounded s"

writedlm("log/tort_julia.txt", tort)
plot(tort)
ylims!(0.9999, 1.003)
savefig("1_gráfico/grafico_2.png")

ucoord = [tor(tort[i]) for i in eachindex(tort)]
plot(ucoord)
hline!([0], lw=1, c=:black, ls=:dash)
vline!([0], lw=1, c=:black, ls=:dash)  
savefig("1_gráfico/grafico_3.png")