# Apex Rush

Jogo de corrida de Fórmula 1 em 3D que roda no navegador, feito com HTML, CSS, JavaScript e [Three.js](https://threejs.org/).

**Jogar no navegador:** https://lipefp.github.io/apexrush/

![Menu do Apex Rush](docs/images/menu.jpg)

**Versão atual:** V40 (Desgaste individual dos pneus). O jogo está em desenvolvimento e homologação; ainda não é uma release final.

## Recursos

- Corrida contra 11 carros controlados pela IA, com classificação (Q1, Q2 e Q3) definindo o grid.
- Dez circuitos: dois fictícios e oito com traçado real (Xangai, Interlagos, Monza, Spa-Francorchamps, Silverstone, Red Bull Ring, Zandvoort e Montreal).
- Pneus macio, médio, duro, intermediário e de chuva, com temperatura e desgaste individuais em cada uma das quatro rodas e faixa colorida do composto.
- Câmbio automático de 8 marchas com troca manual, discos de freio que esquentam e marcas de travamento.
- Pit stop com pitlane, limitador de velocidade e equipe de box animada.
- DRS, ERS, dano na asa dianteira, safety car e clima variável.
- Câmeras de perseguição, T-cam e cockpit, com HUD configurável por câmera.
- Campeonato com pontuação da F1 e tabela de pilotos e equipes.
- Monitor técnico de desempenho (`F10`).

## Controles

| Ação | Teclas |
|---|---|
| Acelerar | `W` ou `↑` |
| Frear e ré | `S` ou `↓` |
| Esterçar | `A` / `D` ou `←` / `→` |
| Subir / reduzir marcha | `Q` / `E` (câmbio automático com intervenção manual) |
| Boost (segurar) | `Espaço` |
| DRS | `F` |
| Mapa do motor (MGU-K) | `Z` |
| Chamar o box | `X` |
| Câmera | `C` |
| Telemetria | `V` |
| Freio de mão | `Shift` |
| Pausa | `P` |
| Som liga/desliga | `M` |
| Iniciar / reiniciar corrida (menu e resultado) | `R` ou `Enter` |
| Monitor técnico | `F10` |

As teclas podem ser trocadas em Configurações → Controles.

Também aceita gamepad e controles por toque.

## Executar localmente

O jogo usa módulos ES e import maps, então precisa ser servido por HTTP (abrir o arquivo direto como `file://` não funciona).

```bash
python3 -m http.server 8080
```

Depois abra `http://localhost:8080`.

## Organização

```text
index.html             Jogo completo (V40)
assets/                Modelos, áudio e texturas extraídos no futuro
docs/                  Histórico de versões, auditoria, processo e plano de deploy
deploy/                Preparação para hospedagem
scripts/               Validação local
```

Hoje o `index.html` concentra o jogo inteiro, com modelos e sons embutidos. A separação em módulos e arquivos de assets está no [roadmap](ROADMAP.md) e será feita aos poucos, com testes de regressão.

## Validação

O GitHub Actions confere a sintaxe dos scripts a cada push. Para rodar a mesma checagem localmente:

```bash
python3 scripts/validate-inline-js.py
```

A checagem cobre sintaxe JavaScript. Física, áudio, WebGL e desempenho são testados no navegador, seguindo o [checklist de release](docs/RELEASE_CHECKLIST.md).

## Estado e problemas conhecidos

Os problemas abertos estão nas [Issues](https://github.com/lipefp/apexrush/issues). A auditoria da V20, que originou as correções da V21 e da V24, está em [`docs/AUDITORIA_V20.md`](docs/AUDITORIA_V20.md) e [`docs/REVISAO_INDEPENDENTE_V20.md`](docs/REVISAO_INDEPENDENTE_V20.md).

## Fluxo de desenvolvimento

- `main`: última versão estável.
- `develop`: integração das próximas mudanças.
- `feature/<assunto>`: mudanças isoladas.
- Tags `vX.Y.Z`: versões arquivadas. O histórico de cada uma está em [`docs/VERSION_HISTORY.md`](docs/VERSION_HISTORY.md).

Detalhes em [`docs/DEVELOPMENT_WORKFLOW.md`](docs/DEVELOPMENT_WORKFLOW.md).

## Créditos

Modelos, sons e traçados de terceiros estão listados em [`CREDITS.md`](CREDITS.md).

## Direitos

© 2026 Felipe Diniz. Todos os direitos reservados. O código está público para consulta, mas não há licença de uso, cópia ou redistribuição. Os recursos de terceiros seguem as licenças dos seus autores.
