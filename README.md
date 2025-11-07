# 🎬 Grafo de Conhecimento para Sistema de Recomendação de Streaming

Este repositório contém o projeto de modelagem e população de um Grafo de Conhecimento utilizando Neo4j AuraDB e a linguagem Cypher. O objetivo é simular um backend de recomendação para uma plataforma de streaming.

## 🎯 Requisitos do Projeto
O grafo foi construído para atender aos seguintes critérios:
- **Nós (Nodes):** Pelo menos 5 tipos de nós (User, Movie, Series, Actor, Director, Genre).
- **Dados:** Pelo menos 10 Usuários e 10 Conteúdos (Filmes/Séries) populados.
- **Relacionamentos:** Relações com propriedades (ex: `WATCHED` com `rating`).

## ⚙️ Modelo de Dados (Esquema Conceitual)

O grafo possui a seguinte estrutura central:
- `(User) -[:WATCHED {rating: 1-5}]-> (Movie/Series)`
- `(Actor) -[:ACTED_IN]-> (Movie/Series)`
- `(Director) -[:DIRECTED]-> (Movie/Series)`
- `(Movie/Series) -[:IN_GENRE]-> (Genre)`

**Diagrama:**

<img width="730" height="1122" alt="visualisation" src="https://github.com/user-attachments/assets/192d024e-02f3-4936-8b41-1d4588b0e0ed" />


## 📝 Arquivo Principal

O arquivo `grafo_streaming_dio.cypher` contém o script completo, incluindo:
1. **Definição de Constraints** (Chaves únicas e índices)
2. **Criação de 42 Nós** (10 Users, 10 Conteúdos, 5 Actors, 4 Directors, 4 Genres)
3. **Criação de 32 Relacionamentos** (Incluindo 15 relacionamentos `:WATCHED` com notas).

## 🔗 Link para o Projeto no Neo4j AuraDB

A instância do banco de dados Neo4j AuraDB está ativa e pode ser acessada através do link:
**https://console-preview.neo4j.io/tools/query**

---
