# Changelog

O histórico completo dos snapshots disponíveis está em [`docs/VERSION_HISTORY.md`](docs/VERSION_HISTORY.md). Cada versão arquivada possui uma tag Git e seu próprio `index.html`.

## [38.0.0] — 2026-11-27 · Deformação dos pneus

O arquivo da V38 é o primeiro preservado depois da V29. Ele reúne as mudanças das versões V30 a V37, listadas abaixo pela versão em que entraram.

### V38 — Deformação dos pneus
- Deformação visual dos pneus em curva, frenagem, aceleração, zebras e derrapagens, sem efeito direto na física.

### V37 — Safety car e pneus
- Revisão do ciclo do safety car: agrupamento do pelotão e retorno à bandeira verde quando o incidente está limpo.
- Só carro parado no asfalto ou na zebra aciona o safety car.
- Aparência do composto sincronizada após a troca nos boxes; escolha do composto no painel do pit.

### V36 — Dinâmica visual de frenagem
- Mergulho da dianteira, compressão da suspensão dianteira e alívio da traseira na frenagem.
- Marcas de travamento e fumaça nas rodas dianteiras com ABS desligado.

### V35 — Temperatura dos freios
- Discos de freio com brilho conforme a temperatura, resfriamento gradual e diferença entre os eixos.

### V34 — Identidade visual dos pneus
- Faixa lateral colorida por composto (macio, médio, duro, intermediário e chuva), sincronizada entre jogador e IA e desbotando com o desgaste.

### V33 — Pilotagem e pistas
- Relevo das pistas suavizado para reduzir ondulações e rampas fortes.
- Ajustes no câmbio automático, preservando a direção já aprovada.

### V32 — Rev matching
- Blip de acelerador nas reduções válidas e som do motor ajustado à marcha e à rotação.

### V31 — Controles e áudio
- Controles reorganizados: WASD para pilotar, `Q` sobe e `E` reduz marcha, `Espaço` boost, `F` DRS, `Z` mapa do motor, `X` box, `V` telemetria.
- Voz do locutor e painel de rádio removidos.

### V30 — Câmbio sequencial
- Câmbio sequencial de 8 marchas, automático por padrão, com intervenção manual e freio-motor.

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
