include("one.jl")
using Base

ch = big"0.0"
mu = big"0.0"
kp = big"0.0"

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

P = zeros(BigFloat, (Int((te-ts)/h) + 2, 1))
P2 = zeros(Float64, (Int((te-ts)/h) + 2, 1))


for i in 1:div(te - ts, h) + 1
    i = convert(Int, i)     
    P[i] = big(V(tort[i]))
    P2[i] = P2a(tort[i])
end


save_vec(P, "P_julia")
save_vec(P2, "P2_julia")

s = zeros(BigFloat, Int(div(te-ts, h)) + 6)
@info "Comprimento s: $(length(s))"

s[1] = big"1.0" 


seg = div(length(s), 10)
len = length(P)

#Integration
kpp = 0
seg = 400

Fd = zeros(BigFloat, Int(div(te-ts,h))+6)
LFd = zeros(BigFloat, Int(div(te-ts,h))+6)

t = @elapsed begin
    for i in 0: k2 + k1 - 4
        i = floor(Int, i)
        var = big(s[1])
        
        s[1] = big"1.0"
        if i % seg == 0
            @info "$i"
        end

        for j in 2:i+2
            j = floor(Int, j)
            tmp = big(s[j])
            
            global k1 = floor(Int, k1)
            global k2 = floor(Int, k2) 

                 
            s[j] = big(s[j-1] + s[j] - var * (1 - 2h*P2[j+k2+k1-i-2]) - (2h^2 * (P[j+k2+k1-i-3]*s[j-1] + P[j+k2+k1-i-1]*s[j]))) * ((2h*P2[j+k1+k2-i-2] + 1)^(-1))

            var = tmp
            LFd[j-1] = log(s[j]^2)/2
            Fd[j-1] = s[j]
            if j == i+2
                global kpp += 1
            end
        end
    end
end


t_for = round(t, digits=2)
@info "Tempo de execução (for): $t_for s"

v1 = length(LFd)
@info "Comprimento LFd: $(v1)"

plot(real(LFd[1:v1]))
savefig("2_gráfico/grafico_5.pdf")


scatter(1:v1, real(LFd[1:v1]), markersize=1)
savefig("2_gráfico/grafico_6.pdf")


@info "Comprimento s: $(length(s))"
@info "Comprimento P: $(length(P))"
@info "Comprimento P2: $(length(P2))"

save_vec(s, "s_julia")
save_vec(LFd, "LFd_julia")
save_vec(Fd, "Fd_julia")

 