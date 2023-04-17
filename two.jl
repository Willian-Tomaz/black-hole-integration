include("one.jl")
using Plots
using Printf
using DecFP

ch = 0.0
mu = 0.0
kp = 0.0

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
    i = convert(Int, i)
    P[i] = V(tort[i])
    P2[i] = P2a(tort[i])
end

s = zeros(Int, Int(div(te-ts,h))+6)
s[1] = 1 

kpp = 0
seg = div(length(s), 10)
len = length(P)

#Integration

kpp = 0
seg = 400

Fd = zeros(Int, Int(div(te-ts,h))+6)
LFd = zeros(Int, Int(div(te-ts,h))+6)

@time for i = 0:k2 + k1 - 3
    var = s[1]
    s[1] = 1
    if trunc(Int, i/seg) == i/seg
        println(i)
    else
        global kpp += 1
    end
    for j = 2:i+2
        j = convert(Int, j)
        tmp = s[j]
        if j == i+2
            s[j] = 0
        else
            println("\naqui 1 ?\n")
            s[j] = ((s[j-1] + s[j] - var*(1 - 2h*P2[j+k2+k1-i-2])) -
                    2h^2*(P[j+k2+k1-i-3]*s[j-1] + P[j+k2+k1-i-1]*s[j]))/
                    ((2h*P2[j+k1+k2-i-2] + 1))
            println("\naqui 2 ?\n")        
            s[j] = round(s[j], digits= 15 )  # arredonda o resultado para a precisão definida por Mp
        end
        var = tmp
        if j == i+2
            if (s[j]) == 0
                LFd[j-1] = 0 #editar
            else
                LFd[j-1] = log(s[j]^2)/2
                Fd[j-1] = s[j]
                global kpp += 1
            end
        end
    end
end
