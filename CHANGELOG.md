# Changelog

O histórico completo dos snapshots disponíveis está em [`docs/VERSION_HISTORY.md`](docs/VERSION_HISTORY.md). Cada versão arquivada possui uma tag Git e seu próprio `index.html`.

## [20.0.0] — 2026-11-26

### Adicionado
- Monitor técnico de execução acessível por `F10`.
- Indicadores de desempenho e estado de recursos para apoiar diagnóstico.
- Carregamento de amostras de áudio com isolamento de falhas e fallback procedural, conforme o comportamento documentado da V20.
- Estado de carregamento dos modelos para facilitar a investigação de falhas visuais.

### Mantido
- Base de simulação existente, sem alteração intencional das rotinas centrais de pilotagem nesta entrega.
- Melhorias acumuladas nas versões anteriores de HUD, volante, carros, efeitos e desempenho.

### Observações
- A validação estática não certifica FPS real nem funcionamento em todos os navegadores/GPU.
- A V20 é baseline de desenvolvimento, não release final de produção.

## Repository bootstrap (26 Nov 2026)

- Added a guarded GitHub import script that checks the remote main SHA before updating it.
- Added instructions to publish the reconstructed history, `develop` branch, and version tags.
- Added a GitHub Actions workflow for inline JavaScript syntax validation.
