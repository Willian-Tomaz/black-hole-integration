using Serialization
using Printf
using LinearAlgebra

using Roots

s = open("logs/s.jls", "r") do io
    deserialize(io)
end

h = 1 // 10 # definir h novamente

using LinearAlgebra
const inc = 500
const fin = 1000
const p = 2

lista1 = [(i - inc)*h => s[i] for i in inc:1:fin]

function prony_exp1(data, T, p)  
    N = length(data)
    X = [data[j-i+1] for j in (p+1):N, i in 1:p]
    x = [data[j] for j in (p+1):N]
    y = -inv(X'X) * (X'x)
    @info "1"
    #erro no z
    z = find_zero(zz -> zz^p + sum([(zz^(n-1))*y[p-n+1] for n in 1:p]), 1)
    @info "z: $z"
    @info "len(z): $(length(z))"
    @info "2"
    w = zeros(p)
    @info "len(w): $(length(w))"
    @info "3"
    for ii in 1:p
        @info "for"
        @info "len w: $(length(w))"
        w[ii] = z[ii]
    end
    @info "fora do for"
    for ii in p/2:-1:1
        println(w[2ii-1])
    end
end

h = 1.0 # ou o valor desejado para h
s = [value for (_, value) in lista1]
prony_exp1(s, h, p)

