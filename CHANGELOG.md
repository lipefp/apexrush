# Changelog

O histórico completo dos snapshots disponíveis está em [`docs/VERSION_HISTORY.md`](docs/VERSION_HISTORY.md). Cada versão arquivada possui uma tag Git e seu próprio `index.html`.

## [38.0.0] — 2026-11-27

### Adicionado
- Câmbio automático de 8 marchas com intervenção manual (`Q` sobe, `E` reduz), blip de acelerador na redução e freio-motor.
- Faixa colorida do composto em cada roda, que perde intensidade com o desgaste.
- Discos de freio que brilham com a temperatura; marcas e fumaça de travamento nas rodas dianteiras com ABS desligado.
- Flexão visual de cada pneu em curva, frenagem e zebra (só visual; não altera aderência).
- Escolha do composto no painel do pit stop.

### Alterado
- Safety car encerra quando o incidente está limpo e o pelotão formou fila; só carro parado no asfalto ou na zebra aciona.
- Perfis de relevo suavizados para evitar rampas fortes.
- Controles: `Espaço` boost, `F` DRS, `Z` mapa do motor, `X` box, `V` telemetria.

### Removido
- Voz do engenheiro e painel de rádio.

## [29.0.0]

### Adicionado
- Faixas de escape pintadas em verde e branco nas zonas de curva.
- Detalhes do carro: inserções de carbono nos sidepods, filete na asa dianteira, porca central, furos do disco e parafusos do aro.

## [26.0.0]

### Corrigido
- A IA só defende a posição quando está emparelhada com o jogador; antes abandonava a linha com o jogador ainda no vácuo.
- Removida a rotina que empurrava a IA para fora da trajetória quando o jogador vinha mais rápido.

## [24.0.0]

### Corrigido
- Menus antigos ficam disponíveis como reserva se o menu Apex não iniciar.
- Detecção de muro da IA usa a posição lateral do jogador na pista.
- Safety car não fica preso quando não há mais líder na pista.

## [21.0.0]

### Corrigido
- Remapeamento de teclas passa a valer na corrida (entrada unificada por `keyAction`).
- A tecla `R` não reinicia mais a corrida durante a captura de remapeamento.
- Instrução do pit stop corrigida para 80 km/h.

## [20.0.0] — 2026-11-26

### Adicionado
- Monitor técnico de execução acessível por `F10`.
- Indicadores de desempenho e estado de recursos para apoiar diagnóstico.
- Carregamento de amostras de áudio com isolamento de falhas e fallback procedural, conforme o comportamento documentado da V20.
- Estado de carregamento dos modelos para facilitar a investigação de falhas visuais.

### Mantido
- Base de simulação existente, sem alteração intencional das rotinas centrais de pilotagem nesta versão.
- Melhorias acumuladas nas versões anteriores de HUD, volante, carros, efeitos e desempenho.

### Observações
- A validação estática não certifica FPS real nem funcionamento em todos os navegadores/GPU.
- A V20 é baseline de desenvolvimento, não release final de produção.

## Repositório no GitHub (26/11/2026)

- Histórico das versões V8 a V20 publicado com branches `main` e `develop`.
- Validação de sintaxe JavaScript no GitHub Actions a cada push.
- README com controles, captura de tela e link para jogar; créditos de terceiros em `CREDITS.md`.

## Auditoria V20 (26/11/2026)

- Arquivada a auditoria técnica da V20 e uma segunda revisão sobre o HTML completo.
- Confirmados como P0: remapeamento desconectado do mapa de entrada e conflito da tecla `R` durante a captura.
- Confirmada instrução incompleta do pit stop: limite de pitlane de 80 km/h e parada quase completa (`v < 3 m/s`) na zona de troca.
- Colisão sem swept test registrada como risco a reproduzir antes de qualquer ajuste físico.
- Persistência de `perfScale` entre reinícios documentada como decisão de produto, não como defeito automático.
- Menu dinâmico sem fallback pós-boot registrado como risco de robustez.
