# Fluxo de desenvolvimento e versões

## Regra principal

`main` deve conter somente versões aprovadas como estáveis. Mudanças novas entram em `develop` ou em branches `feature/*`. Não substituir a última release estável antes de validar a nova.

## Ciclo de cada versão

1. Registrar o problema ou objetivo e os passos para reproduzi-lo.
2. Criar branch para a mudança.
3. Fazer a alteração mínima que resolva o objetivo.
4. Executar validação estática e comparar funções centrais de simulação quando aplicável.
5. Testar no navegador: menu, carregamento dos carros, largada, corrida, pausas, câmeras e encerramento.
6. Testar cenários relevantes de áudio, chuva, rodas/pneus e desempenho.
7. Atualizar `CHANGELOG.md` e marcar claramente limitações conhecidas.
8. Integrar em `develop`; após aprovação, promover para `main` e criar tag.

## Convenção de branches

- `main`: versão estável.
- `develop`: próxima versão em integração.
- `feature/nome-curto`: recurso novo.
- `fix/nome-curto`: correção de bug.
- `perf/nome-curto`: otimização medida.

## Convenção de commits

Preferir mensagens objetivas, por exemplo:

- `fix: impedir desaparecimento das rodas em curvas`
- `perf: reduzir custo de partículas na chuva`
- `feat: adicionar painel de telemetria compacto`
- `docs: registrar homologação da V21`

## Release

Toda tag deve corresponder ao código exato testado. Registrar navegador, resolução, GPU, configurações gráficas, FPS/frame time observado e bugs conhecidos. Não chamar uma versão de estável com base apenas em validação de sintaxe.
