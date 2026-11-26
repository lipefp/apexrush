# Auditoria técnica — Apex Rush V20

**Data:** 26/11/2026  
**Base examinada:** `index.html` da tag `v20.0.0` (8.891 linhas).  
**Escopo:** boot, entrada de teclado, remapeamento, pit stop, colisão jogador–IA, reinício, HUD dinâmica e camadas de CSS.

> Esta auditoria é uma revisão estática do código. Achados que dependem de comportamento em tempo real estão marcados como hipótese a reproduzir, não como bug comprovado.

## Resumo

A V20 tem boas proteções no boot, no delta time e na colisão com as paredes. Porém, o remapeamento de teclas é de fato desconectado do caminho de entrada e a tecla `R` consegue disparar uma ação global enquanto o jogador está capturando uma tecla. A instrução de pit stop também não corresponde aos limites efetivos do código.

| Área | Avaliação | Prioridade |
|---|---|---|
| Boot / carregamento | Três CDNs, timeout por import e fallback de diagnóstico | Manter e testar |
| Remapeamento | Estado visual não alimenta `KEYMAP` nem os comandos extras | P0 |
| Atalhos durante remapeamento | `R` chega ao listener global e pode reiniciar a corrida | P0 |
| Texto do pit stop | Texto diz 100 km/h; limitador real é 80 km/h e a parada exige quase parar | P1 |
| Colisão jogador–IA | Teste discreto por posições do frame; sem swept collision | P2 / reproduzir |
| `perfScale` no reset | A escala adaptativa permanece entre corridas | Decisão de produto |
| Menu dinâmico | O menu moderno é montado por JS; não há fallback visual legado se a renderização falhar depois do boot | P1 / robustez |
| CSS da HUD | Regras de HUD distribuídas em camadas com `!important` | P2 / manutenção |

## Achados confirmados no código

### 1. Remapeamento de teclas não chega ao jogo — P0

- `KEYMAP` é um objeto literal declarado perto da linha 2556 e lido diretamente nos listeners globais de `keydown` e `keyup`.
- `remapKeys` é outro mapa, composto por `Set`s, criado a partir de `DEFAULT_KEYS` perto da linha 4497.
- `keyAction(code)` procura a ação em `remapKeys`, mas a busca no arquivo encontra apenas a declaração da função: não há chamada no fluxo normal de entrada.
- Ao capturar uma tecla, o handler atualiza `remapKeys`, mas não atualiza `KEYMAP`.
- Os comandos extras do volante (`B`, `N`, `V`, `X`) continuam comparando `e.code` com valores fixos em listener separado.
- Não foi encontrada persistência de `remapKeys` em `localStorage`.

**Correção recomendada:** unificar todas as fontes de entrada num único resolvedor de ações; ao remapear, atualizar o mapa efetivamente lido pelo jogo; definir conflito/duplicidade de teclas; persistir a configuração e oferecer restauração dos padrões.

### 2. Tecla `R` durante a captura de remapeamento — P0

- O handler de captura está em `document` com `capture: true` e chama `preventDefault()`, mas não interrompe a propagação.
- O listener principal em `window` processa `KeyR` com `startRace()` sem verificar `remapWaiting` ou o estado `ST_REMAP`.
- `preventDefault()` não impede que o mesmo evento continue propagando.

**Correção recomendada:** quando `remapWaiting` estiver ativo, chamar também `stopPropagation()` e `stopImmediatePropagation()` conforme necessário; adicionalmente, bloquear atalhos globais durante estados de captura, texto e menus. A correção deve ser testada com `R`, `Escape`, `Enter`, `F` e `C`.

### 3. Instrução de pit stop incompatível com as regras — P1

- A tela inicial diz para parar no box “abaixo de 100 km/h” (perto da linha 764).
- O limitador definido no código é `PIT_VMAX = 80 / 3.6` (perto da linha 1187), isto é, 80 km/h.
- O gatilho da troca exige `v < 3` m/s dentro da área do box (perto da linha 3020), aproximadamente 10,8 km/h.

**Correção recomendada:** esclarecer na instrução que o limitador da pitlane é 80 km/h e que o carro precisa parar quase completamente dentro da área marcada. Não alterar o gatilho de velocidade sem testar a mecânica, o posicionamento de garagem e a IA.

### 4. Colisão jogador–IA sem varredura contínua — P2 / reproduzir

- `collidePlayerAI()` faz uma broad-phase baseada na distância atual entre os centros e compara os círculos de colisão nas posições do frame atual.
- Não há teste explícito do segmento entre posição anterior e atual (*swept collision*).
- O loop limita `dt` a 0,05 s. Com `VMAX = 88 m/s`, um carro no limite pode percorrer até cerca de 4,4 m em um passo; a velocidade relativa pode ampliar a distância coberta entre dois veículos.

**Conclusão:** a ausência de swept collision está confirmada; o atravessamento em corrida real ainda precisa ser reproduzido. Antes de alterar a física, criar teste determinístico com FPS baixo, carros em aproximação e ângulos diferentes. Uma correção posterior pode usar swept circles/capsules ou substeps locais apenas na colisão.

### 5. `perfScale` não é redefinido por `resetRace()` — decisão de produto

- `perfScale` é inicializado globalmente e é alterado pelo Auto FPS.
- `setQuality()` redefine `perfScale` para 1.
- `resetRace()` não redefine esse valor.
- Assim, reiniciar uma corrida mantém a escala de resolução adaptada durante a corrida anterior.

**Conclusão:** comportamento confirmado, mas não necessariamente defeito. Manter a escala entre corridas evita que o Auto FPS repita a adaptação a cada largada. Recomenda-se documentar esse comportamento; zerar a escala somente ao trocar explicitamente o perfil gráfico ou oferecer um botão “recalibrar”.

## Risco adicional: menu dinâmico como ponto único de falha

- O CSS desativa `#title`, `#teamSelect`, `#garage` e `#finish` com `display:none!important`.
- O menu atual é `#apx`; `#apxNav` e `#apxPanel` começam vazios e são preenchidos por `apxRender()`.
- `apxSync()` chama a renderização no fluxo de UI.
- O overlay de boot e os handlers globais detectam falhas de inicialização, mas isso não constitui um fallback de menu legado para uma exceção posterior em `apxRender()`.

**Correção recomendada:** remover o `!important` do desligamento dos menus antigos e controlar a visibilidade por classe; manter um fallback mínimo de “Menu indisponível / Recarregar” se `apxNav` ou `apxPanel` não forem montados. Testar também erros lançados após o boot, não apenas falhas de import.

## Dívida técnica e acessibilidade

- Há camadas de CSS adicionadas em diferentes versões que sobrescrevem os mesmos IDs e propriedades com `!important`. Consolidar a HUD antes da release para reduzir regressões de cascata.
- `prefers-reduced-motion` aparece nas regras de CSS da HUD, mas os efeitos animados por JavaScript (por exemplo, shake e partículas) precisam de um gate equivalente.
- Adicionar estado `:focus-visible` consistente aos botões de menu, opções e controles de HUD.
- Não foi feita auditoria ortográfica completa.

## Pontos fortes confirmados

- Boot tenta três origens independentes para Three.js, com timeout por tentativa e proteção contra resolução dupla.
- `GLTFLoader` é opcional e a falha cai no tratamento de erro, mantendo a geometria procedural disponível.
- `resetRace()` limpa uma quantidade ampla de estados dinâmicos, incluindo tempos, pneus, danos, suspensão e estado das IAs.
- A colisão com paredes corrige a posição para dentro dos limites da pista.
- O delta time do loop é limitado a 0,05 s.
- Os controles de toque usam eventos de ponteiro individuais (`pointerdown`, `pointerup`, `pointercancel` e `pointerleave`).

## Plano de correção recomendado para V21

1. Unificar o remapeamento: `KEYMAP`, remap e comandos extras devem resolver pelo mesmo mapa.
2. Isolar os atalhos globais durante captura de tecla e demais estados de UI.
3. Corrigir a instrução do box para 80 km/h de limite e parada quase completa.
4. Criar um teste reproduzível de colisão em FPS baixo; só então implementar swept collision se o teste confirmar o problema.
5. Documentar a persistência de `perfScale` entre reinícios ou adicionar opção de recalibração.
6. Criar fallback visível para falha de renderização do menu dinâmico.
7. Consolidar CSS da HUD e cobrir `prefers-reduced-motion` nos efeitos JS.

## Casos de regressão prioritários

| ID | Teste | Resultado esperado |
|---|---|---|
| R01 | Remapear aceleração para `J` | `J` acelera; `W` deixa de ser a única tecla efetiva conforme a configuração |
| R02 | Pressionar `R` durante captura | `R` é capturada; a corrida não reinicia |
| R03 | Remapear comandos extras B/N/V/X | O novo mapa controla Boost/Mix/Rádio/Box |
| R04 | Recarregar o navegador depois de remapear | Mapeamento persiste, se essa for a decisão de produto |
| R05 | Entrar no pitlane a 95 km/h | Limitador reduz para 80 km/h; não ativa a troca em movimento |
| R06 | Parar quase completamente no box correto | Overlay e troca de pneus são acionados |
| R07 | Ultrapassar com FPS limitado | Não há atravessamento; se houver, reproduzir com seed e log determinísticos |
| R08 | Reiniciar depois de Auto FPS reduzir escala | Escala mantém o comportamento documentado ou recalibra por opção explícita |
| R09 | Forçar exceção em `apxRender()` depois do boot | Mensagem de recuperação continua acessível |
| R10 | Reduzir animações no sistema operacional | HUD, shake e partículas respeitam a preferência |

## Validação executada nesta revisão

- Arquivo examinado: `index.html` na tag `v20.0.0`, 8.891 linhas.
- `python3 scripts/validate-inline-js.py`: **2 blocos JavaScript inline passaram em `node --check`**.
- A validação acima verifica sintaxe; não certifica execução em navegador, WebGL, áudio, física, FPS ou dispositivos móveis.
