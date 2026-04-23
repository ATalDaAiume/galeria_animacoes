![Atividade](https://img.shields.io/badge/Atividade-Flutter-blue)
![Dart](https://img.shields.io/badge/Linguagem-Dart-00b4ab)

# 🛍️ Galeria de Produtos Animada
> Resolução de Atividade Prática — Aula 9 | Análise e Desenvolvimento de Sistemas | 5ª Fase

**Aluna:** Eloize Aiume de Liz Pereira | **Turma:** 5ª Fase — Análise e Desenvolvimento de Sistemas (2026/1)

Repositório criado para armazenar o projeto completo da atividade prática da Aula 9 da disciplina de **Desenvolvimento para Dispositivos Móveis**, da Faculdade Senac Joinville.

---

## 📚 Descrição do Aplicativo e seu Objetivo

Este aplicativo é uma **Galeria de Produtos** interativa construída inteiramente em Flutter. O objetivo principal da aplicação é aplicar e demonstrar o domínio sobre os conceitos de animações avançadas em UI e componentes customizados no Flutter.

O projeto cumpre todos os requisitos exigidos pela atividade, focando na criação de uma interface fluida, responsiva e visualmente atrativa, combinando animações para guiar a atenção do utilizador e melhorar a experiência (UX), sem a necessidade de um backend externo.

---

## 📸 Capturas de Tela (Screenshots)

Abaixo estão as demonstrações do aplicativo a funcionar e das suas transições animadas:

| 📱 Galeria | ✨ Card Expandido | 🔍 Detalhes |
| :---: | :---: | :---: |
| <img src="https://i.postimg.cc/Gm1srfRK/Galeria.png" width="250"> | <img src="https://i.postimg.cc/VkB0NFsX/Card_Expandido.png" width="250"> | <img src="https://i.postimg.cc/4xThZ0GB/Detalhes.png" width="250"> |

---

## ✨ Funcionalidades e Animações Implementadas

Conforme exigido pelos critérios de avaliação, as seguintes funcionalidades e animações foram aplicadas:

- [x] **1. Animação Implícita:** Implementada no card de produto na tela inicial. Ao tocar no card, ele expande suavemente o seu tamanho e altera a espessura da borda, utilizando o widget `AnimatedContainer` com uma duração de 300ms e curva `Curves.easeInOut`.
- [x] **2. Animação Explícita:** Implementada na Tela de Detalhes na tag de "SUPER OFERTA!". Utiliza um `AnimationController`, `Tween<double>` e `CurvedAnimation` (com efeito `elasticOut`) para criar uma animação de pulsação (escala) contínua e eficiente via `AnimatedBuilder`. O método `dispose()` foi adequadamente utilizado.
- [x] **3. Hero Animation:** Criação de uma transição contínua do ícone do produto. O ícone "voa" da tela de galeria (origem) para a tela de detalhes (destino) utilizando uma tag única vinculada ao ID do produto.
- [x] **4. Material Design 3:** Habilitado globalmente no `ThemeData` com `useMaterial3: true` e paleta gerada através de `ColorScheme.fromSeed()`. Foi utilizado o componente atualizado `FilledButton` para o botão de voltar.
- [x] **5. Widget Customizado Reutilizável:** Criação da classe `ProdutoCard`, que atua como um widget componentizado, recebendo parâmetros via construtor (`id`, `titulo`, `corBase`, `icone`) e reutilizado em múltiplos lugares na listagem principal da tela.
- [x] **🌟 Requisito Bônus (CustomPainter):** Implementado o `FundoGeometricoPainter` na tela de detalhes. A classe estende `CustomPainter` e utiliza o método `canvas.drawCircle` para desenhar formas geométricas decorativas ao fundo, com o método `shouldRepaint()` gerido corretamente.

---

## 🛠️ Tecnologias Utilizadas
- Framework Flutter
- Linguagem Dart
- IDE: VS Code
