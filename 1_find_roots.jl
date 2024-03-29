include("logs.jl")
include("dados.jl")

setprecision(BigFloat, 250; base=10)

function g(r)
    g = BigFloat(( r^2 - rp^2 ) / L^2)
    return g
end

function arctanh(x)
    if abs2(x) < 1
        res = BigFloat(log( ( 1 + x ) / (1 - x)  ))
    else
        res = BigFloat(sign(x) * log1p( ( 2 * abs(x) ) / (1 - abs2(x)) ))
    end
    return 0.5*res
end

function tor_2(r)
 
    a = BigFloat( rp / r )
    b = BigFloat(arctanh(a))
    res = BigFloat(L^2 * (- b /  BigFloat(rp)))
    return res
end

function valor_atanh(x)
    a = 1 / big(10)^x
    y = arctanh(a)
    res = BigFloat(  L^2 * (- y/rp ))
    return res
end

function tor_preciso(x) # atanh (1 + 10^⁻240)
    eps = 10.0^(-x)
    res = 0.5 * BigFloat(log(( 2 + eps )/eps))
    a = BigFloat(rp)
    res2 = BigFloat(L^2 * (  - res/a ))
    return res2
end

x = range(rp, 10rp, step=0.1)
y = [tor_2(i) for i in x]
plot(x, y; xlabel="x", ylabel="y", legend=false, origin=true)
savefig("graficos/grafico_1.pdf")

min = tor_preciso(exp)
 
for i = 100:-1:2
    if -valor_atanh(i) < h 
        global max = 10.0^i
    else
        global ma = ma + 2.0
    end
end

data()

function find_root(f, a, b, precision)
    oldm = BigFloat(a)
    n = BigFloat(a)
    p = BigFloat(b)
    m = (n + p) / big(2)
    epsilon = big(10)^(-precision)

    while abs(f(m)) > epsilon && oldm != m
        oldm = m
        val = f(m)
        if val > 0
            p = m
        elseif val < 0
            n = m
        else
            break
        end
        m = BigFloat(n + p) / BigFloat(2.0)
    end
    return m
 
end


tort = @showprogress 1 "Calculating roots" [find_root(r -> tor_2(r) - test, rp + 10.0^-exp, max, Mp) for test in ts:h:te]

plot(tort, st=:scatter)
savefig("graficos/grafico_2.pdf")

ucoord = [tor_2(tort[i]) for i in eachindex(tort)]
 
plot(ucoord, st=:scatter)
hline!([0], lw=1, c=:black, ls=:dash)
vline!([0], lw=1, c=:black, ls=:dash)  
savefig("graficos/grafico_3.pdf")

save_vec(tort, "tort")

open("logs/tort.jls", "w") do io
    serialize(io, tort)
end