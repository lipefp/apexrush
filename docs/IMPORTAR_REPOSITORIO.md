# Importar o histórico completo para o GitHub

O GitHub `lipefp/apexrush` foi criado com um commit inicial contendo apenas um README mínimo. O pacote local possui o histórico reconstruído dos snapshots disponíveis (V8 a V20), duas branches (`main` e `develop`) e tags de versão.

## Caminho recomendado

1. Extraia `Apex-Rush-Repository-V20.zip` em uma pasta local.
2. Abra um terminal dentro da pasta `Apex-Rush`.
3. Confira o histórico antes de publicar:

   ```bash
   git status --short --branch
   git log --oneline --decorate --graph --all
   git tag --list --sort=version:refname
   ```

4. Execute o script de publicação:

   ```bash
   ./scripts/publish-to-github.sh
   ```

5. Quando solicitado, autentique-se com Git Credential Manager ou GitHub CLI. Nunca coloque um token dentro do script, do repositório ou de um arquivo versionado.

## O que o script faz

- Configura `origin` para `https://github.com/lipefp/apexrush.git`, se ainda não existir.
- Busca o estado remoto antes de publicar.
- Atualiza `main` apenas se ela ainda apontar exatamente para o commit inicial conferido (`d310d5b1593176d25f8ed8e759568f55b00ea5f2`). A operação usa `--force-with-lease`, não `--force` aberto.
- Cria `develop` somente se ela ainda não existir. Se já existir com conteúdo diferente, o script para sem sobrescrever.
- Envia todas as tags sem forçar atualização de tags existentes.

Se a `main` remota tiver mudado, o script aborta por segurança. Nesse caso, faça fetch e revise as diferenças manualmente.

## Verificações após o push

```bash
git ls-remote --heads origin
git ls-remote --tags origin
```

No GitHub, confirme as branches `main` e `develop`, as tags `v8.0.0` até `v20.0.0` e o conteúdo de `index.html`.

## Nota sobre o histórico

O histórico recuperado começa na V8 porque os HTMLs anteriores não estavam disponíveis no conjunto de arquivos desta conversa. As tags representam snapshots reais disponíveis, não reconstruções inventadas de versões ausentes.
