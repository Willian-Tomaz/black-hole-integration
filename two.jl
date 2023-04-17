include("one.jl")
using Base


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
savefig("2_gráfico/grafico_4.png")
@info "Gráfico 4 gerado"

P = zeros(Float64, (Int((te-ts)/h) + 2, 1))
P2 = zeros(Float64, (Int((te-ts)/h) + 2, 1))

for i in 1:div(te - ts, h) + 1
    i = convert(Int, i)
    P[i] = V(tort[i])
    P2[i] = P2a(tort[i])
end

s = zeros(Float64, Int(div(te-ts, h)) + 6)


s[1] = 1 

kpp = 0
seg = div(length(s), 10)
len = length(P)

#Integration

kpp = 0
seg = 400

Fd = zeros(Float64, Int(div(te-ts,h))+6)
LFd = zeros(Float64, Int(div(te-ts,h))+6)

# Integration
kpp = 0
seg = 400




t = @elapsed begin
    for i in 0:k2 + k1 - 3
        i = floor(Int, i)
        var = s[1]
        s[1] = 1
    
        if i % seg == 0
            @info "$i"
        else
            global kpp += 1
        end
    
        for j in 2:i+2
            j = floor(Int, j)
            tmp = s[j]
            if j == i+2
                s[j] = 0
                global k1 = floor(Int, k1)
                global k2 = floor(Int, k2) 
                s[j] = (s[j-1] + s[j] - var*(1 - 2*h*P2[j+k2+k1-i-2]) - 2*h^2*(P[j+k2+k1-i-3]*s[j-1] + P[j+k2+k1-i-1]*s[j]))*(2*h*P2[j+k1+k2-i-2] + 1)^-1
            end
    
            var = tmp
            if j == i+2
                LFd[j-1] = log(s[j]^2)/2
                Fd[j-1] = s[j]
                kpp += 1
            end
        end
    end
end
t_for = round(t, digits=2)

@info "Tempo de execução (for): $t_for s"