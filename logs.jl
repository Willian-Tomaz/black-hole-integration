using Printf

function data()
    for item in ["Mp: $(Mp)", 
                 "L: $(L)", 
                 "rp: $(rp)", 
                 "exp: $(exp)", 
                 "pk: $(pk)", 
                 "grid: $(h)", 
                 "ts: $(ts)", 
                 "te: $(te)", 
                 "v0: $(v0)", 
                 "vmax: $(vmax)", 
                 "k1: $(k1)", 
                 "k2: $(k2)", 
                 "TortStart: $(TortStart)", 
                 "ma: $(ma)", 
                 "max: $(max)", 
                 "min: $(@sprintf("%.10f", min))"]
        @info item
        sleep(0.3)
    end
end


function save_vec(v, filename="")
    a = filename
    if filename == ""
        @warn "Precisa definir o nome do arquivo"
    else

        filename = "logs/$filename.txt"
        writedlm(filename, v)
        @info "Vetor $a salvo"
    end
end
