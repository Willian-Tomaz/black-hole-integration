using Plots
using Printf
using DecFP
using DifferentialEquations
using DiffEqOperators

ch = 0.0
micro = 0.0
kp = 0.0
rp = 1.0
L = 1.0
 
function phi_(r)
    phi = (rp*ch)/r^2
    return phi
end


using DifferentialEquations, ForwardDiff

function V(r)
    phi = phi_(r)
    g = ((r^2 - rp^2)/L^2)
    return g/4 * (-(g/(4r^2)) + ForwardDiff.derivative(g, r)/2r + kp^2/r^2 + Micro^2) - phi^2/4
end


function P2a(r)
    return -im * phi_(r) / 2
end

result = V(2.0)
println(result)