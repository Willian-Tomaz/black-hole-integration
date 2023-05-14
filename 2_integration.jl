include("logs.jl")
include("dados.jl")

tort = open("logs/tort.jls", "r") do io
    deserialize(io)
end

setprecision(BigFloat, 300; base=10)

Mp = BigFloat(Mp)
L = BigFloat(L)
 
function phi_(r)
    phi = BigFloat((rp*ch)/r^2)
    return phi
end

function derivada_g(r)
    res = (2*r)/L^2
    return res
end

function V(r)
    phi = phi_(r)
    g = BigFloat((r^2 - rp^2) / L^2)
    return BigFloat(g/4 * (-(g/(4r^2)) + derivada_g(r)/2r + kp^2/r^2 + mu^2) - phi^2/4)
end

function P2a(r)
    return -im * phi_(r) / 2
end

function fch(r)
    res1 = big((L^2 * log(Complex(1 - r/rp)) ) / ( 2 *rp ))
    res2 = big(( L^2 * log(Complex(1 + r/rp)) ) / (2 * rp))
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
savefig("graficos/grafico_4.pdf")

P = zeros(BigFloat, (Int((te-ts)/h) + 2, 1))
P2 = zeros(ArbComplex, (Int((te-ts)/h) + 2, 1))

for i in 1:div(te - ts, h) + 1
    i = convert(Int, i)     
    P[i] = BigFloat( V(tort[i])  )
    P2[i] =  P2a(tort[i])
end

save_vec(P, "P")

Fd = zeros(BigFloat, Int(div(te-ts,h))+6)
LFd = zeros(BigFloat, Int(div(te-ts,h))+6)
s = zeros(BigFloat, Int(div(te-ts, h)) + 6)

s[1] = big"1.0" 

len = length(P)

kpp = 0

@showprogress 1 "Calculating s" for i = 1:k2 + k1 - 4
    i = Int(i)
    var = s[1]
    s[1] = 1.0

    map(j -> begin
            if j == i +2
                s[j] = 0
            end
            tmp = s[j]
            global k1 = floor(Int, k1)
            global k2 = floor(Int, k2)
            p1 = BigFloat(P[j+k2+k1-i-3])
            p2 = 0.0
            p3 = BigFloat(P[j+k2+k1-i-1])

            s[j] = BigFloat((s[j-1] + s[j] - var * (1 - 2h*p2) - 2h^2 * (p1*s[j-1] + p3*s[j])) * ((2h*p2 + 1)^(-1)))

            var = tmp

            if j == i+2
                LFd[j-1] = BigFloat(log(s[j]^2)/2)
                Fd[j-1] = s[j]

            else
                global kpp += 1
            end
        end, 2:i+2)
end
 
save_vec(s, "s")
v1 = length(LFd)


plot(real(LFd[1:v1]))
savefig("graficos/grafico_5.pdf")

scatter(1:v1, real(LFd[1:v1]), marker=:circle, markersize=2, color=:black,
        xlabel="Índice", ylabel="Valor de LFd", title="Gráfico de LFd")
savefig("graficos/grafico_6.pdf")

open("logs/s.jls", "w") do io
    serialize(io, s)
end