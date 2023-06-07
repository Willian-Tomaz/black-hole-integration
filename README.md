# Integração do buraco negro BTZ


Este é um código em Julia para a integração numérica da equação de campo resolvida para um buraco negro BTZ.

Descrição:
-----------
O código implementa a integração numérica das equações de campo de Einstein para um buraco negro BTZ em 2+1 dimensões. Através do princípio da ação estacionária e da ação de Einstein-Hilbert, obtemos as equações de campo de Einstein. Para encontrar uma solução exata, utilizamos a seguinte função de lapso:

    f(r) = r^2/L^2 - M - Q^2 lnr

Onde:
- r representa a coordenada radial,
- L é o raio de curvatura anti-de Sitter (AdS), e
- M é a massa do buraco negro.

Aplicamos um esquema de discretização descrito por Konoplya e Zhidenko [1] para integrar a equação e, em seguida, utilizamos o método Prony, também descrito na mesma referência, para obter as frequências fundamentais.

## Como utilizar:
1. Instale o [Julia](https://julialang.org/downloads/).

2. Clone o repositório
3. Abra um terminal e navegue até a pasta onde o repositório foi clonado
4. Execute o comando `make install-deps` para instalar as dependências necessárias.
6. Para executar os scripts, execute o comando `make all`
7. Para limpar os arquivos gerados pela execução dos scripts, execute o comando `make clean`.

## Partes do código:

O código está estruturado em três principais partes:

1. **1_find_roots.jl**: Este script é responsável por encontrar as raízes da equação.

2. **2_integration.jl**: Este script é responsável por integrar a equação.

3. **3_qn_values.jl**: Utilizando o método Prony, este script encontra os modos quasinormais do buraco negro.

Para alterar os dados do buraco negro, você deverá editar o arquivo **dados.jl**, onde:
- Mp é a precisão.
- L é o raio Anti de Sitter.
- rp é o raio do horizonte de eventos.
- kp é o momento angular.
- h e pk representam a grade de integração.

Referência:
-----------
[1] Konoplya, R. A., & Zhidenko, A. (2011). Quasinormal modes of black holes: From astrophysics to string theory. Reviews of Modern Physics, 83(3), 793. doi:10.1103/RevModPhys.83.793
