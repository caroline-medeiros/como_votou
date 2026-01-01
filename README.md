# 🏛️ Como Votou? (WIP)

![Status](https://img.shields.io/badge/Status-Em_Desenvolvimento-yellow) ![Stack](https://img.shields.io/badge/Stack-Fullstack-blue)

> **Nota:** Este projeto está em desenvolvimento ativo.

## 📄 Sobre o Projeto

O **Como Votou?** é uma plataforma de transparência política que visa democratizar o acesso às informações legislativas brasileiras. O objetivo é transformar dados complexos e burocráticos da Câmara dos Deputados em uma interface visual, intuitiva e engajadora, inspirada em plataformas de streaming como a Netflix.

A ideia central é traduzir o "juridiquês" (ex: "Requerimento nº 4923...") em manchetes jornalísticas claras (ex: "Fim da Escala 6x1"), permitindo que qualquer cidadão entenda o que está sendo votado e como seu deputado se posicionou.

## 🚀 Tecnologias Utilizadas

O projeto foi construído utilizando uma arquitetura desacoplada (API REST + Client SPA):

### Front-end
- **Framework:** [Next.js 14+](https://nextjs.org/) (App Router)
- **Linguagem:** TypeScript
- **Estilização:** Emotion (Styled Components)
- **Design Pattern:** Component Folder Pattern
- **Destaques:** Server Components, Layouts Responsivos, Design System próprio.

### Back-end
- **Framework:** [Ruby on Rails 7](https://rubyonrails.org/) (API Mode)
- **Banco de Dados:** PostgreSQL
- **Funcionalidades:** API RESTful, Serialização de JSON aninhado, Tratamento de dados legislativos.

## ✨ Funcionalidades (Atuais)

- [x] **Listagem Visual:** Interface inspirada em catálogos de streaming.
- [x] **Hero Section:** Destaque para a votação mais relevante ou polêmica do momento.
- [x] **Placar de Votação:** Contagem visual de votos (Sim, Não, Abstenção) em tempo real.
- [x] **Detalhes do Deputado:** Card com foto, nome, partido e voto individual.
- [x] **Tradução Editorial:** Sistema que permite exibir títulos amigáveis e resumos explicativos ao invés das ementas oficiais.

## 🗺️ Roadmap (Próximos Passos)

- [ ] Integração com IA (LLM) para gerar resumos automáticos das ementas.
- [ ] Filtros avançados por Partido e Estado.
- [ ] Busca textual por temas.
- [ ] Deploy em ambiente Cloud (AWS/Vercel).

## 📦 Como Rodar o Projeto

### Pré-requisitos
- Node.js
- Ruby & Rails
- PostgreSQL

### 1. Back-end (Rails)

```bash
# Clone o repositório e entre na pasta da API
cd api

# Instale as dependências
bundle install

# Configure o banco de dados
rails db:create db:migrate

# Rode o servidor
rails s
