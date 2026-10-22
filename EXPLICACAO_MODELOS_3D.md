# Simulação 3D da comporta e do reservatório

## O que se queria obter

O objetivo é representar, em 3D:

- a comporta deformável;
- a água inicialmente represada;
- a abertura/deformação da comporta;
- a saída da água pelo vão criado.

## Modelo ICFD original: fluido com malha contínua

O primeiro modelo usava ICFD. Nesse método, a água é representada por uma **malha de elementos de volume**. Por isso, no pós-processamento, o fluido aparece como uma região contínua e lisa, preenchida por cores de pressão ou velocidade.

Esse modelo não completou a análise porque a deformação da comporta altera a região do fluido próxima a ela. Com isso, os elementos da malha de volume do fluido ficam excessivamente distorcidos, muito finos ou podem se inverter. O LS-DYNA interrompe então a solução com a mensagem:

```text
ICFD ERROR: Volume mesh error
```

Isso não significa que a ideia física esteja errada. Significa que, para esse movimento da comporta, seria necessário um procedimento de remalhamento ICFD mais robusto e uma geometria/malha de fluido preparada especificamente para grandes deformações.

## Modelo atual: água em SPH

O modelo que está rodando usa **SPH (Smoothed Particle Hydrodynamics)** para a água e elementos sólidos 3D para a comporta.

No SPH, a água não é uma malha contínua: ela é composta por partículas. Cada ponto visível no LS-PrePost representa uma pequena parcela de água. As partículas interagem entre si, com as paredes fixas e com a comporta deformável.

Essa formulação é mais adequada para o caso atual porque a água pode sair pelo vão e sofrer grandes mudanças de forma sem precisar distorcer uma malha de fluido.

## Por que a água aparece como pontinhos?

Os pontinhos são as partículas SPH. No resultado atual, o espaçamento entre partículas é aproximadamente **5 mm**. Por isso há espaços visuais entre elas, principalmente quando a água se espalha após sair da comporta.

Isso é uma característica da representação SPH, não indica que a água deixou de existir naquela região.

Para uma aparência mais contínua há duas alternativas:

1. Aumentar apenas o tamanho de exibição das partículas no LS-PrePost. Isso melhora a visualização, sem alterar o cálculo.
2. Diminuir o espaçamento das partículas no modelo, por exemplo de 5 mm para 2,5 mm. Isso deixa o fluido mais detalhado, mas aproximadamente quadruplica a quantidade de partículas na seção e aumenta bastante o tempo de processamento.

## Comparação resumida

| Característica | ICFD com malha | SPH atual |
|---|---|---|
| Representação da água | Volume contínuo com elementos | Partículas |
| Aparência no pós-processamento | Campo liso, preenchido | Pontos coloridos |
| Grandes deformações e saída de água | Pode exigir remalhamento | Naturalmente suportadas |
| Situação neste projeto | Interrompeu por erro de malha de volume | Completou a análise |
| Comporta deformável | Sim, mas a malha do fluido falhou | Sim, acoplada às partículas SPH |

## Resultado obtido

O arquivo de entrada da versão funcional é:

```text
i_3D_sph_gate_coupled.k
```

Ele usa:

- `mesh_struc_3D_refinedZ.k`: comporta sólida 3D deformável;
- `mesh_sph_container_3d.k`: paredes fixas do reservatório/canal;
- `water_sph_volume.k`: partículas SPH que representam a água.

Nos resultados `dam5_sph_gate_coupled_v5.d3plot` (e arquivos `d3plot01`, `d3plot02`), é possível observar a comporta deformando e as partículas de água saindo do reservatório.

## Observação para comparar com o modelo 2D

Para uma comparação justa, use o mesmo instante de tempo e compare:

- deslocamento horizontal da ponta livre da comporta;
- velocidade da água perto da abertura;
- pressão média próxima à comporta, quando o histórico de pressão SPH for gravado;
- evolução da forma do jato e do nível de água.

Em SPH, valores individuais de uma única partícula podem oscilar. Para pressão e velocidade, uma média de várias partículas próximas ao mesmo ponto é mais representativa do que usar apenas uma partícula.
