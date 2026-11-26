# Histórico de versões arquivadas

Este repositório contém snapshots HTML reais recuperados dos artefatos desta conversa. Cada tag aponta para o `index.html` correspondente àquela versão. O histórico disponível começa na V8; fontes anteriores não estavam disponíveis no conjunto de arquivos recuperado.

| Tag | Marco registrado na entrega |
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

As descrições são resumos dos marcos de entrega. Para verificar uma implementação, compare o código de duas tags. A V11.0.0 está arquivada como snapshot histórico; a V11.1.0 é o hotfix posterior.

## Como abrir uma versão específica

```bash
git checkout v16.0.0
```

Para voltar ao desenvolvimento atual:

```bash
git checkout main
```
