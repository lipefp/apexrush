# Plano de publicação — Oracle Cloud Always Free

A publicação fica bloqueada até a conclusão da homologação descrita em `RELEASE_CHECKLIST.md`.

## Pré-requisitos

- Separar e fixar as dependências hoje carregadas por CDN.
- Confirmar a procedência e as licenças de todos os assets.
- Garantir que a aplicação funcione sem acesso a CDNs externas.
- Definir política de cache para HTML, módulos, modelos, texturas e áudio.
- Definir domínio, HTTPS, logs, health check e rollback.

## Docker (fase futura)

A imagem deve servir os arquivos estáticos por um servidor web enxuto, sem executar o jogo no servidor. O processamento 3D continua no navegador do jogador. A arquitetura concreta será escolhida depois de confirmar a arquitetura da instância Oracle e os requisitos de tráfego.

## Segurança e operação

- Não incluir tokens, chaves SSH, senhas ou arquivos `.env` no Git.
- Usar HTTPS e cabeçalhos de segurança adequados.
- Executar o container sem privilégios e com filesystem somente leitura quando possível.
- Manter cópia da versão anterior e procedimento documentado de rollback.
- Monitorar disponibilidade e erros HTTP após publicar.

Este documento é planejamento; ainda não representa uma configuração de produção validada.
