using Serialization
using Printf
 
s = open("logs/s.jls", "r") do io
    deserialize(io)
end

h = 1 // 10 # definir h novamente
a1 = 500 # ponto inicial
a2 = 1000 # ponto final
Nn = a2 - a1 + 1

Fii = zeros(BigFloat, Nn+1)
for i = a1:a2+1
    Fii[i-a1+1] = real(s[i])
end

v11 = sum([Fii[i]^2 for i = 2:Nn-1])
v33 = sum([Fii[i]^2 for i = 1:Nn-2])
v22 = sum([Fii[i]*Fii[i+1] for i = 1:Nn-2])

De = v11*v33 - v22^2
v1 = v33/De
v3 = v11/De
v2 = -v22/De

alpha1 = -sum([Fii[i+2]*(v1*Fii[i+1] + v2*Fii[i]) for i = 1:Nn-2])
alpha2 = -sum([Fii[i+2]*(v2*Fii[i+1] + v3*Fii[i]) for i = 1:Nn-2])

A1 = -alpha1/2
A2 = abs(sqrt(alpha1^2 - 4*alpha2))/2
Cc = sqrt(A1^2 + A2^2)
Th = acos(A1/Cc)
wi = log(Cc)/(2*h)
wr = Th/(2*h)
ww = round(Complex(wr, wi), sigdigits=7)

@info "ww: $(@sprintf("%.7f", wr)) $(@sprintf("%.7f", wi)) i  "
