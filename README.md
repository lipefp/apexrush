# Apex Rush

Projeto de jogo de corrida 3D desenvolvido em HTML, CSS e JavaScript com Three.js.

**Baseline do repositório:** V20 — Stability Edition  
**Estado:** desenvolvimento e homologação; ainda não é uma release de produção.

## Objetivos do projeto

- Preservar a dirigibilidade e a simulação enquanto evoluímos modelos, HUD, áudio e efeitos.
- Corrigir problemas de rodas, pneus, modelos e carregamento antes de acrescentar complexidade.
- Medir desempenho em condições reproduzíveis, em vez de assumir ganhos sem teste no hardware-alvo.
- Manter histórico Git e nunca sobrescrever a última versão estável.
- Preparar publicação Dockerizada na Oracle Cloud somente depois da homologação.

## Executar localmente

O jogo usa módulos ES e import maps. Sirva a pasta por HTTP em vez de abrir o HTML diretamente como `file://`.

Com Python 3:

```bash
python3 -m http.server 8080
```

Abra `http://localhost:8080` no navegador.

## Diagnóstico

Na V20, o monitor técnico pode ser aberto com `F10` durante a execução. Ele é útil para registrar FPS, tempos de frame, contadores de renderização, estado do áudio/modelos e erros observados pelo jogo.

Para validar a sintaxe dos scripts inline com Node.js:

```bash
python3 scripts/validate-inline-js.py
```

Essa validação verifica sintaxe JavaScript; não substitui teste no navegador, teste de WebGL, testes de áudio ou homologação da física.

## Organização

```text
index.html             Baseline executável V20
assets/models/         Modelos 3D extraídos e versionados futuramente
assets/audio/          Áudio extraído e versionado futuramente
assets/textures/       Texturas extraídas e versionadas futuramente
docs/                  Arquitetura, processo, critérios de release e plano de deploy
deploy/                Documentação de preparação para hospedagem
scripts/               Validações locais
```

O arquivo V20 ainda concentra boa parte do projeto em um HTML grande. A separação de módulos e assets será feita gradualmente, com testes de regressão e sem uma reestruturação arriscada de uma só vez.

## Fluxo Git

- `main`: última versão estável aprovada.
- `develop`: integração das próximas mudanças.
- `feature/<assunto>`: mudanças isoladas, quando necessário.
- Tags `vX.Y.Z`: marcos reproduzíveis.

Toda entrega deve registrar o que mudou, o que foi testado e o que ainda depende de validação manual. Consulte `docs/DEVELOPMENT_WORKFLOW.md`.

## Próxima etapa técnica

Consultar `ROADMAP.md` e `docs/RELEASE_CHECKLIST.md`. Docker/Oracle não é o próximo passo imediato: primeiro vamos estabilizar carros e pneus, validar física, áudio, efeitos e desempenho; depois empacotar e testar as dependências locais.
