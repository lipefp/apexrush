#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/lipefp/apexrush.git"
EXPECTED_INITIAL_MAIN="d310d5b1593176d25f8ed8e759568f55b00ea5f2"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

if ! command -v git >/dev/null 2>&1; then
  echo "ERRO: Git não foi encontrado. Instale o Git e tente novamente." >&2
  exit 1
fi

if ! git remote get-url origin >/dev/null 2>&1; then
  git remote add origin "$REPO_URL"
else
  CURRENT_URL="$(git remote get-url origin)"
  if [[ "$CURRENT_URL" != "$REPO_URL" ]]; then
    echo "ERRO: o remote origin aponta para $CURRENT_URL, não para $REPO_URL." >&2
    echo "Revise o remote manualmente; o script não vai substituí-lo." >&2
    exit 2
  fi
fi

echo "Buscando o estado atual do GitHub..."
git fetch origin --tags
REMOTE_MAIN="$(git rev-parse refs/remotes/origin/main)"
LOCAL_MAIN="$(git rev-parse refs/heads/main)"

if [[ "$REMOTE_MAIN" == "$LOCAL_MAIN" ]]; then
  echo "main já está sincronizada."
elif [[ "$REMOTE_MAIN" == "$EXPECTED_INITIAL_MAIN" ]]; then
  echo "A main remota ainda é o commit inicial mínimo conhecido."
  echo "Atualizando main com force-with-lease protegido pelo SHA exato..."
  git push --force-with-lease="refs/heads/main:${EXPECTED_INITIAL_MAIN}" origin refs/heads/main:refs/heads/main
else
  echo "ERRO: a main remota mudou desde a última conferência." >&2
  echo "Esperado: $EXPECTED_INITIAL_MAIN" >&2
  echo "Encontrado: $REMOTE_MAIN" >&2
  echo "Nada foi sobrescrito. Faça uma revisão/integração manual antes de publicar." >&2
  exit 3
fi

LOCAL_DEVELOP="$(git rev-parse refs/heads/develop)"
if git ls-remote --exit-code --heads origin develop >/dev/null 2>&1; then
  REMOTE_DEVELOP="$(git ls-remote --heads origin refs/heads/develop | awk '{print $1}')"
  if [[ "$REMOTE_DEVELOP" == "$LOCAL_DEVELOP" ]]; then
    echo "develop já está sincronizada."
  else
    echo "ERRO: já existe uma develop remota diferente. Nenhuma sobrescrita será feita." >&2
    echo "Remota: $REMOTE_DEVELOP" >&2
    echo "Local:  $LOCAL_DEVELOP" >&2
    exit 4
  fi
else
  echo "Publicando a branch develop..."
  git push origin refs/heads/develop:refs/heads/develop
fi

echo "Publicando tags de versão..."
git push origin --tags

echo
echo "Concluído. Verifique https://github.com/lipefp/apexrush e confirme main, develop e tags."
