# Revisão independente da auditoria V20

**Data:** 26/11/2026  
**Arquivo verificado:** `index.html` na tag `v20.0.0` (8.891 linhas).  
**Método:** leitura direta das regiões completas citadas pela auditoria, busca de call sites e validação estática dos scripts inline.

## Resultado executivo

A auditoria fornecida é consistente com o código completo nos principais achados. Dois itens são bugs confirmados no fluxo atual (remapeamento e captura de `R`); o texto do box é objetivamente incompleto; a ausência de colisão varrida é confirmada, mas tunneling ainda precisa ser reproduzido; a persistência de `perfScale` entre corridas existe, mas pode ser uma decisão intencional de Auto FPS. O risco do menu dinâmico é válido e merece fallback próprio.

## Conferência item a item

| Item | Resultado independente | Evidência / observação |
|---|---|---|
| Boot com 3 CDNs e timeout | Confirmado | `CDN` e `importWithTimeout()` aparecem no módulo principal; `settled` impede resolução dupla. |
| GLTFLoader opcional | Confirmado | Import em `try/catch`; falha é tratada como opcional. |
| Remapeamento cosmético | **Confirmado — P0** | `KEYMAP` é fixo e consumido nos listeners de teclado. `keyAction(code)` só tem a declaração como ocorrência; a captura modifica `remapKeys`, não `KEYMAP`. Os comandos B/N/V/X usam códigos fixos. |
| `R` interrompe a captura | **Confirmado — P0** | Listener de captura em `document` usa `capture: true` e chama `preventDefault()`, mas não para a propagação. O listener de `window` recebe `KeyR` e chama `startRace()` sem guarda de estado/captura. |
| Instrução de pit stop | **Confirmado — P1** | O texto menciona abaixo de 100 km/h; `PIT_VMAX = 80 / 3.6` limita a pitlane a 80 km/h; o gatilho em `v < 3` m/s exige quase parar (menos de 10,8 km/h). |
| `PIT_VMAX` versus `PIT_S0/S1` | **Não há contradição no HTML completo** | O arquivo contém os dois conjuntos. `PIT_S0=60` e `PIT_S1=80` definem a zona longitudinal do box; `PIT_VMAX=80/3.6` é o limite de velocidade. Confundir esses nomes em uma extração parcial seria incorreto. |
| Colisão carro-carro sem swept collision | **Ausência confirmada; impacto hipotético** | `collidePlayerAI()` testa posições do frame atual e usa broad-phase por distância atual. Não há varredura contínua explícita. O clamp de `dt` é 0,05 s; a 88 m/s, o deslocamento de um veículo pode chegar a 4,4 m por passo. Reproduzir antes de mexer na física. |
| `perfScale` no reset | **Comportamento confirmado; decisão de produto** | `resetRace()` não redefine `perfScale`; `setQuality()` redefine, mas `startRace()` chama `resetRace()` sem chamar `setQuality()`. Manter a escala adaptada entre corridas pode ser desejável para evitar recalibração repetitiva. |
| Menu dinâmico como ponto único de falha | **Risco válido — P1 de robustez** | CSS desliga os menus antigos com `display:none!important`. `#apxNav` e `#apxPanel` começam vazios e são preenchidos por `apxRender()`. O overlay de boot cobre falhas antes do boot ficar pronto, mas não é fallback de menu para uma exceção posterior em `apxRender()`. |
| CSS da HUD em camadas | Confirmado | Há estilos adicionais `apxV15FocusHUD` e `apxV16HudResponsive` além da camada base, com regras sobrepostas e `!important`. |
| `dt` limitado | Confirmado | No loop, `dt` é limitado a 0,05 s. |

## Decisões recomendadas para V21

1. Corrigir o remapeamento com um resolvedor único para teclado principal e comandos extras; decidir e documentar regras para teclas duplicadas.
2. Bloquear atalhos globais quando `remapWaiting` estiver ativo e impedir `R`/`Escape` de dispararem ações concorrentes durante captura.
3. Persistir remapeamentos com validação e botão para restaurar padrões.
4. Atualizar a instrução do pit stop para explicar o limite de 80 km/h na pitlane e a necessidade de parar quase completamente dentro da marcação.
5. Criar uma reprodução determinística de colisão com FPS baixo. Só implementar swept collision ou substeps locais se o cenário demonstrar tunneling.
6. Manter `perfScale` entre reinícios, a menos que testes mostrem problema; adicionar uma ação explícita de recalibração se necessário.
7. Criar fallback visível e acionável caso o menu dinâmico falhe após o boot.
8. Consolidar as camadas CSS da HUD numa folha coerente quando houver cobertura de regressão.

## Validação executada

Com `index.html` completo da baseline V20:

```text
OK: 2 bloco(s) JavaScript inline passaram no node --check.
Observação: isso valida sintaxe, não execução no navegador/WebGL.
```

A validação estática não comprova FPS, estabilidade de WebGL, áudio, comportamento físico ou compatibilidade entre navegadores. Os testes funcionais devem seguir a tabela de regressão de `AUDITORIA_V20.md`.
