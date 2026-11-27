# Histórico de versões arquivadas

Este repositório contém os arquivos HTML reais de cada versão. Cada tag aponta para o `index.html` correspondente àquela versão. O histórico começa na V8; as versões anteriores e as intermediárias que não estão na tabela (como V22, V23 e V30 a V37) não foram preservadas.

| Tag | O que mudou |
|---|---|
| `v8.0.0` | Base de largada/RPM usada como ponto de partida do ciclo recuperado |
| `v9.0.0` | Refinamento dos modelos 3D |
| `v10.0.0` | Animações mecânicas, suspensão e aerodinâmica visual |
| `v11.0.0` | Dinâmica visual em alta velocidade; snapshot predecessor ao hotfix |
| `v11.1.0` | Hotfix de inicialização/menu e sequência de luzes |
| `v12.0.0` | Efeitos de velocidade e ambiente |
| `v13.0.0` | Spray em pista molhada e efeitos térmicos de freio |
| `v14.0.0` | Telemetria e feedback de pilotagem |
| `v15.0.0` | HUD focada e refinamento visual da resposta de frenagem |
| `v16.0.0` | HUD configurável por câmera e correções de estabilidade das rodas |
| `v17.0.0` | Preservação de grupos de materiais dos pneus/rodas |
| `v18.0.0` | Display digital do volante |
| `v19.0.0` | Otimizações de renderização e Auto FPS |
| `v20.0.0` | Monitor de diagnóstico, estado de áudio e carregamento de modelos |
| `v21.0.0` | Remapeamento ligado ao jogo, tecla R na captura e texto do pit stop |
| `v24.0.0` | Menu reserva, detecção de muro da IA e trava do safety car |
| `v26.0.0` | Defesa da IA contra o jogador só quando emparelhada |
| `v29.0.0` | Faixas de escape e detalhes do carro e das rodas |
| `v38.0.0` | Câmbio com troca manual, efeitos de freio, faixa do composto e flexão dos pneus |

As descrições resumem cada versão. Para verificar uma implementação, compare o código de duas tags. A V11.0.0 está arquivada como snapshot histórico; a V11.1.0 é o hotfix posterior.

## Como abrir uma versão específica

```bash
git checkout v16.0.0
```

Para voltar ao desenvolvimento atual:

```bash
git checkout main
```
