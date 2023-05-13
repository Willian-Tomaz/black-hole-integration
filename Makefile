JULIA = julia
JULIA_FLAGS =

all: find_roots integration qn_values

find_roots: 1_find_roots.jl
	$(JULIA) $(JULIA_FLAGS) 1_find_roots.jl

integration: 2_integration.jl
	$(JULIA) $(JULIA_FLAGS) 2_integration.jl

qn_values: 3_qn_values.jl
	$(JULIA) $(JULIA_FLAGS) 3_qn_values.jl

clean:
	rm -f logs/*.txt
	rm -f logs/*.jls
	rm -f graficos/*.pdf

install_deps:
	$(JULIA) -e 'using Pkg; Pkg.add(["ProgressMeter", "Serialization", "Plots", "DelimitedFiles", "Logging", "ArbNumerics", "Readables", "Printf"])'
