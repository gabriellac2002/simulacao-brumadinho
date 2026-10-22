# Comparação de pressão: referência 2D × modelo SPH 3D

## Base da comparação

- Referência: exemplo 2D **Dam break with Elastic Gate**.
- Instante mostrado na referência: `t = 0,0832 s`.
- Resultado 3D: média de cinco partículas SPH próximas à comporta, distribuídas pela espessura em Z para cada altura.
- O arquivo `sphout` grava a tensão média. Para fluido, a pressão física em compressão foi calculada como `p = -(sig_xx + sig_yy + sig_zz)/3`.
- O instante disponível mais próximo no resultado 3D é `t = 0,083999 s` (diferença de 0,000799 s).

## Médias 3D obtidas junto à comporta

| Altura aproximada | Partículas na média | Pressão média (Pa) | Faixa entre partículas (Pa) |
|---|---:|---:|---:|
| `y ≈ 0,015 m` | 5 | 135,0 | 18,0 a 471,4 |
| `y ≈ 0,045 m` | 5 | 205,7 | 86,4 a 334,6 |
| `y ≈ 0,075 m` | 5 | 48,7 | 25,7 a 65,4 |
| `y ≈ 0,105 m` | 5 | 10,3 | 1,1 a 15,1 |

## Conclusão

A referência 2D mostra aproximadamente `-50 a 900 Pa`, com um gradiente hidrostático suave e pressão alta na base do reservatório. O modelo SPH 3D atual apresenta a tendência geral de pressão menor nas regiões altas, porém as médias próximas à comporta são muito menores e apresentam oscilação entre partículas.

Portanto, o modelo atual é adequado para demonstrar qualitativamente a deformação 3D da comporta e a saída da água, mas **ainda não está calibrado para validar quantitativamente o mapa de pressão do caso ICFD 2D**.

## Por que os resultados diferem

1. O exemplo de referência usa ICFD com campo contínuo; este modelo usa SPH, que mede valores em partículas móveis.
2. A água SPH foi iniciada com pressão aproximadamente nula. O equilíbrio hidrostático precisa se formar durante a simulação e pode oscilar.
3. A geometria e a deformação da comporta não são idênticas às do exemplo 2D.
4. A média de cinco partículas reduz ruído, mas não transforma a leitura em uma sonda fixa no espaço.

## Próximo refinamento necessário para validação de pressão

Para aproximar quantitativamente o perfil 2D, o modelo SPH deve ser recalibrado com condição inicial hidrostática, parâmetros de compressibilidade/SPH e malha de partículas refinados. Depois, a comparação deve usar médias espaciais em regiões fixas junto à comporta, no mesmo instante de tempo.
