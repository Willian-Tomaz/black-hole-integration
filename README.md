# Black Hole Integration

Este é um código em Julia que integra a equação de campo para um buraco negro BTZ.

## Como utilizar:
1. Instale o [Julia](https://julialang.org/downloads/).
2. Instale os seguintes pacotes dentro do Julia:
   - ArbFloats v0.3.2
   - ArbNumerics v1.2.5
   - DecFP v1.3.1
   - Plots v1.38.10
   - Readables v0.3.3
3. Execute o arquivo 2_integration.jl. Esse arquivo será responsável por executar o primeiro arquivo, 1_find_roots.jl, onde serão calculadas as raízes da equação (tort). O arquivo 2_integration.jl é responsável por integrar a equação (s).
4. Para encontrar os valores quasi-normais, execute o arquivo 3_qn_values.jl, onde serão calculados os valores da frequência fundamental pelo método Prony.
