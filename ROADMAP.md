# Roadmap do Apex Rush

## Fase A — Estabilização funcional

- [ ] Pneus e rodas permanecem visíveis em todas as câmeras, velocidades, curvas e condições de pista.
- [ ] Modelos de jogador e adversários carregam sem falhas; fallback é previsível e diagnosticável.
- [ ] Sem erros JavaScript recorrentes durante menu, largada, corrida, pausa, box e encerramento.
- [ ] HUD por câmera mantém preferências, escala e posições corretas em diferentes resoluções.

## Fase B — Homologação de gameplay

- [ ] Frenagem progressiva e previsível, sem sensação de travamento indevido.
- [ ] Aceleração, câmbio, aderência, suspensão, colisões e IA testados em cenários repetíveis.
- [ ] Efeitos visuais não alteram a simulação e possuem fallback quando recursos gráficos falham.
- [ ] Sons de motor, pneus, transmissão, ambiente e rádio avaliados em diferentes situações.
- [ ] Testes de corridas completas, reinícios, mudanças de câmera e configurações.

## Fase C — Performance

- [ ] Coletar baseline de FPS e frame time em hardware-alvo.
- [ ] Medir cenas comparáveis: menu, largada com todos os carros, corrida, chuva e efeitos máximos.
- [ ] Identificar gargalos de CPU, GPU, memória, draw calls e carregamento de assets.
- [ ] Definir metas de desempenho após medir o hardware-alvo; não declarar 60 FPS estáveis sem medições.

## Fase D — Preparação para produção

- [ ] Separar módulos JavaScript, CSS, modelos, texturas e áudio gradualmente.
- [ ] Fixar versões e hospedar localmente as dependências necessárias (incluindo Three.js e addons).
- [ ] Verificar licenças e procedência dos modelos, sons, fontes e demais assets.
- [ ] Testar funcionamento sem dependência de CDN externa.
- [ ] Criar build/release reproduzível e checklist de rollback.

## Fase E — Oracle Cloud / Docker

- [ ] Confirmar arquitetura, recursos e limites da instância Always Free disponível.
- [ ] Definir servidor estático/reverse proxy, cache e compressão apropriados.
- [ ] Criar imagem Docker enxuta e executar como usuário não privilegiado.
- [ ] Configurar HTTPS, domínio, logs, health check e política de atualização.
- [ ] Testar em ambiente de homologação antes de apontar o domínio público.
