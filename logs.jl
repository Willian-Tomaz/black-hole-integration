using Printf

function data()
    @info "Mp: $(Mp)"
    @info "L: $(L)"
    @info "rp: $(rp)"
    @info "exp: $(exp)"
    @info "pk: $(pk)"
    @info "grid: $(h)"
    @info "ts: $(ts)"
    @info "te: $(te)"
    @info "v0: $(v0)"
    @info "vmax: $(vmax)"
    @info "k1: $(k1)"
    @info "k2: $(k2)"
    @info "TortStart: $(TortStart)"
    @info "ma: $(ma)"
    @info "max: $(max)"
    @info "min: $(@sprintf("%.10f", min))"
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
