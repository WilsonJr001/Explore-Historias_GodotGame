# Explore Histórias

Um jogo de exploração 2D desenvolvido na **Godot Engine** (4.6). O objetivo do projeto é criar uma experiência
imersiva e simples, onde o jogador explora um mundo em pixel art e interage com NPCs e objetos.

## 🚀 Sobre o Projeto

**Explore Histórias** é um projeto autoral focado em exploração, interação e movimentação 2D. O jogador controla
um personagem top-down que pode se mover, coletar itens e enfrentar inimigos simples enquanto descobre pequenas
histórias espalhadas pelo mapa.

### Funcionalidades principais
- Movimentação top-down com animações (idle/walk).
- Sistema de interação com objetos coletáveis.
- Inimigos simples com detecção, perseguição e ataque (ex.: Rato).
- Suporte a TileSets e TileMaps para construção das cenas.

## 🗂 Estrutura do Repositório
- Cenas/: arquivos .tscn do Godot (Player, Mundo, Rato, Árvores, HUD, Menu, etc.).
- Codigos/: scripts GDScript (.gd) que implementam a lógica do jogo.
- Imagens/: sprites, tilesets e assets visuais.
- Musicas/: efeitos sonoros e trilha ambiente.
- Fonts/: fontes usadas no HUD/menus.

Exemplos de arquivos importantes:
- Cenas/Player.tscn — nó do jogador
- Cenas/Mundo.tscn — cena principal (instances de árvores, pedras, inimigos)
- Cenas/Rato.tscn — inimigo "Rato"
- Codigos/player.gd — movimentação e animações do jogador
- Codigos/rato.gd — lógica do inimigo Rato (perseguir, atacar, animações)

## 👾 Inimigos
Lista de inimigos implementados no momento:
- Rato — inimigo básico que detecta o jogador, persegue e ataca quando próximo. Implementa animações de correr
  e atacar, mira na posição dos pés do jogador e tem fallback para garantir término da animação de ataque.

## 🎨 Assets e Créditos (detalhado)
Os recursos visuais e sonoros deste projeto foram obtidos em sua maioria de recursos gratuitos e bibliotecas de
assets. Créditos aos autores originais:
- TileSet e Tilemap: Pixel Lands Forest (trislin) — https://trislin.itch.io/pixel-lands-forest
- Sprites do Player: FREE Adventurer / Top-down adventurer packs (xzany, outros) — links originais no repositório
- Sprites de inimigo: Free Enemy Pixel Pack for Top-Down Defense — usado para o Rato
- Sons: coin sound pack e efeitos menores obtidos de pacotes gratuitos
- Fonte: Antiquity / Antiquity-print (usada no HUD)

Observação: os assets estão organizados em pastas dentro de Imagens/ e Musicas/. Ex.:
- Imagens/FREE_Adventurer 2D Pixel Art/… (sprites do jogador)
- Imagens/Free-Enemy-Pixel-Pack-for-Top-Down-Defense/… (sprites do inimigo Rato)
- Imagens/Pixel Lands Forest Demo/… (objetos e árvores)
- Fonts/antiquity-print.ttf
- Musicas/ (efeitos de coin, ambiente de floresta)

Se algum asset não estiver listado aqui e você gostaria que fosse atribuído/creditado, abra uma issue ou altere o
arquivo README diretamente.

## 📝 Changelog (alterações recentes)
As entradas abaixo refletem mudanças feitas durante o desenvolvimento local mais recente:

- 2026-04-16 — Correções e melhorias no inimigo "Rato":
  - Corrigido problema de y-sorting (Rato agora usa AnimatedSprite2D com y_sort_enabled e é instanciado dentro de
    um YSort no Mundo) para renderizar corretamente em relação a árvores e objetos.
  - Implementadas animações completas do Rato (run_side, run_up, run_down, attack_side, attack_up, attack_down).
  - Adicionado sistema de ataque: Rato persegue o jogador, inicia ataque quando está dentro de attack_distance.
  - Rato agora mira na posição dos pés do jogador (usa CollisionShape2D ou AnimatedSprite2D como fallback).
  - Fallback Timer adicionado para garantir término de estado de ataque caso o sinal animation_finished não seja
    disparado (evita travamento no estado de ataque).
  - Ajustes finos: distância de ataque exposta como export (attack_distance), velocidade (SPEED) configurável no
    script, comportamento de idle quando o jogador sai do alcance.

> Observação técnica: se alguma animação de ataque estiver configurada como loop no SpriteFrames, o Rato pode nunca
sair do estado de ataque — verifique as flags de loop nas animações (deve ser loop = false para os ataques).

## 🔧 Como Executar o Projeto
1. Instale a Godot Engine (versão 4.6 recomendada).
2. Clone este repositório:
```bash
git clone https://github.com/WilsonJr001/Explore-Historias_GodotGame.git
cd Explore-Historias_GodotGame
```
3. Abra o projeto na Godot (menu "Import" / abrir project.godot ou abrir a pasta do projeto).
4. Abra a cena `Cenas/Mundo.tscn` e pressione Play para testar.

Dicas de debug rápido:
- Verifique se `Autoloads` (PlayerHud, Message) estão configurados em Project Settings (arquivo project.godot contém
  referências de autoload atuais).
- Se sprites não aparecerem com a profundidade correta, verifique se os nós estão filhos de um `YSort` ou se a
  propriedade `y_sort_enabled` está ativada no `AnimatedSprite2D`.

## 🤝 Contribuição
- Fork, branch e pull requests são bem-vindos.
- Abra uma issue descrevendo o bug ou a feature desejada antes de começar implementações maiores.

---

Se quiser, atualizo este README com o inventário exato de arquivos de `Imagens/` e `Musicas/` (uma lista completa), ou
posso adicionar uma seção "Testes" detalhando como testar o comportamento do Rato (detecção, ataque, idle, etc.).
