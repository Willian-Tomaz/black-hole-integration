using Plots
using Printf

Mp = 250
L = 1
rp = 1

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
 


function tor_preciso(x)
    eps = 10.0^(-x)
    res = 0.5 * log(( 2 + eps )/eps)
    res2 = L^2 * (  - res/rp )
    return res2
end


x = range(rp, 10*rp, step=0.1)
y = []
#=
for i in x
    a = tor(i)
    push!(y,a)
end

plot(x, y, origin = true, xlabel = "x", ylabel = "y", legend = false)

savefig("grafico.png")
=#
exp = Mp - 10
pk = 50
h = 1/100
ts = -2*pk
te = -h
v0 = -pk
vmax = 0
u0 = 0
umax = pk
k1 = (vmax -v0)/h
k2 = (umax -v0)/h
ma = 0
TortStart = v0 - umax
ma = 0
min = tor_preciso(exp)


function tor_2(r_)
    a = rp / r_
    b = arctanh(BigFloat(a))
    res = L^2 * (-b / rp)
    return res
end



for i = 100:-2:2
    ts1 = 10^i
    if -tor_2(ts1) < h
        global max = ts1
        global ma = ma + 2
    end
end

println("ma:", ma)
println("max:", max)
