// Desafio DIO - Grafo de Conhecimento de Streaming
// Criação de 10 Usuários, 5 Filmes, 5 Séries e Relacionamentos (Total de 42 Nós e 32 Relacionamentos)

// 1. Definição de Constraints (Unicidade para IDs)
CREATE CONSTRAINT user_id_unique IF NOT EXISTS FOR (u:User) REQUIRE u.userId IS UNIQUE;
CREATE CONSTRAINT movie_id_unique IF NOT EXISTS FOR (m:Movie) REQUIRE m.movieId IS UNIQUE;
CREATE CONSTRAINT series_id_unique IF NOT EXISTS FOR (s:Series) REQUIRE s.seriesId IS UNIQUE;
CREATE CONSTRAINT actor_id_unique IF NOT EXISTS FOR (a:Actor) REQUIRE a.actorId IS UNIQUE;
CREATE CONSTRAINT director_id_unique IF NOT EXISTS FOR (d:Director) REQUIRE d.directorId IS UNIQUE;
CREATE CONSTRAINT genre_name_unique IF NOT EXISTS FOR (g:Genre) REQUIRE g.name IS UNIQUE;

// 2. Criação dos Nós (Entidades)

// Usuários (10)
MERGE (u1:User {userId: 'u1', name: 'Alice'})
MERGE (u2:User {userId: 'u2', name: 'Bruno'})
MERGE (u3:User {userId: 'u3', name: 'Carla'})
MERGE (u4:User {userId: 'u4', name: 'David'})
MERGE (u5:User {userId: 'u5', name: 'Eva'})
MERGE (u6:User {userId: 'u6', name: 'Felipe'})
MERGE (u7:User {userId: 'u7', name: 'Gisele'})
MERGE (u8:User {userId: 'u8', name: 'Hugo'})
MERGE (u9:User {userId: 'u9', name: 'Isabela'})
MERGE (u10:User {userId: 'u10', name: 'Joao'});

// Gêneros (4)
MERGE (g_sf:Genre {name: 'Sci-Fi'})
MERGE (g_dr:Genre {name: 'Drama'})
MERGE (g_ac:Genre {name: 'Action'})
MERGE (g_co:Genre {name: 'Comedy'});

// Atores (5)
MERGE (a1:Actor {actorId: 'a1', name: 'Chris Evans'})
MERGE (a2:Actor {actorId: 'a2', name: 'Scarlett J.'})
MERGE (a3:Actor {actorId: 'a3', name: 'Tom Hanks'})
MERGE (a4:Actor {actorId: 'a4', name: 'Jenna Ortega'})
MERGE (a5:Actor {actorId: 'a5', name: 'Pedro Pascal'});

// Diretores (4)
MERGE (d1:Director {directorId: 'd1', name: 'C. Nolan'})
MERGE (d2:Director {directorId: 'd2', name: 'S. Spielberg'})
MERGE (d3:Director {directorId: 'd3', name: 'Greta G.'})
MERGE (d4:Director {directorId: 'd4', name: 'Tim Burton'});

// Filmes (5)
MERGE (m1:Movie {movieId: 'm1', title: 'O Vingador'})
MERGE (m2:Movie {movieId: 'm2', title: 'Resgate Espacial'})
MERGE (m3:Movie {movieId: 'm3', title: 'Tempo Perdido'})
MERGE (m4:Movie {movieId: 'm4', title: 'A Piada Final'})
MERGE (m5:Movie {movieId: 'm5', title: 'O Último Soldado'});

// Séries (5)
MERGE (s1:Series {seriesId: 's1', title: 'A Casa de Papel'})
MERGE (s2:Series {seriesId: 's2', title: 'Mandalorianos'})
MERGE (s3:Series {seriesId: 's3', title: 'Wandinha'})
MERGE (s4:Series {seriesId: 's4', title: 'Chernobyl'})
MERGE (s5:Series {seriesId: 's5', title: 'Succession'});


// 3. Criação dos Relacionamentos

// Define os nós necessários para as conexões de produção/gênero (Bloco B)
MATCH (m1:Movie {movieId: 'm1'}), (m2:Movie {movieId: 'm2'}), (m3:Movie {movieId: 'm3'}), (m4:Movie {movieId: 'm4'})
MATCH (s1:Series {seriesId: 's1'}), (s2:Series {seriesId: 's2'}), (s3:Series {seriesId: 's3'}), (s4:Series {seriesId: 's4'})
MATCH (g_sf:Genre {name: 'Sci-Fi'}), (g_dr:Genre {name: 'Drama'}), (g_ac:Genre {name: 'Action'}), (g_co:Genre {name: 'Comedy'})
MATCH (a1:Actor {actorId: 'a1'}), (a2:Actor {actorId: 'a2'}), (a3:Actor {actorId: 'a3'}), (a4:Actor {actorId: 'a4'}), (a5:Actor {actorId: 'a5'})
MATCH (d1:Director {directorId: 'd1'}), (d2:Director {directorId: 'd2'}), (d4:Director {directorId: 'd4'})

// ACTED_IN (7)
MERGE (a1)-[:ACTED_IN]->(m1) MERGE (a2)-[:ACTED_IN]->(m1) MERGE (a3)-[:ACTED_IN]->(m3) 
MERGE (a4)-[:ACTED_IN]->(s3) MERGE (a5)-[:ACTED_IN]->(s2) MERGE (a5)-[:ACTED_IN]->(s1)
MERGE (a4)-[:ACTED_IN]->(m3);

// DIRECTED (3)
MERGE (d1)-[:DIRECTED]->(m1) MERGE (d2)-[:DIRECTED]->(m3) MERGE (d4)-[:DIRECTED]->(s3);

// IN_GENRE (7)
MERGE (m1)-[:IN_GENRE]->(g_ac) MERGE (m2)-[:IN_GENRE]->(g_sf) MERGE (m3)-[:IN_GENRE]->(g_dr) 
MERGE (m4)-[:IN_GENRE]->(g_co) MERGE (s2)-[:IN_GENRE]->(g_sf) MERGE (s3)-[:IN_GENRE]->(g_co) 
MERGE (s4)-[:IN_GENRE]->(g_dr);

// Define os nós necessários para as conexões de visualização (WATCHED) (Bloco C)
MATCH (u1:User {userId: 'u1'}), (u2:User {userId: 'u2'}), (u3:User {userId: 'u3'}), (u4:User {userId: 'u4'}), (u5:User {userId: 'u5'}), (u6:User {userId: 'u6'}), (u7:User {userId: 'u7'}), (u8:User {userId: 'u8'}), (u9:User {userId: 'u9'}), (u10:User {userId: 'u10'})
MATCH (m1:Movie {movieId: 'm1'}), (m2:Movie {movieId: 'm2'}), (m3:Movie {movieId: 'm3'}), (m4:Movie {movieId: 'm4'}), (m5:Movie {movieId: 'm5'})
MATCH (s1:Series {seriesId: 's1'}), (s2:Series {seriesId: 's2'}), (s3:Series {seriesId: 's3'}), (s4:Series {seriesId: 's4'}), (s5:Series {seriesId: 's5'})

// WATCHED (15)
MERGE (u1)-[:WATCHED {rating: 5}]->(m1) MERGE (u1)-[:WATCHED {rating: 4}]->(m2) 
MERGE (u2)-[:WATCHED {rating: 5}]->(m1) MERGE (u3)-[:WATCHED {rating: 3}]->(m3) 
MERGE (u4)-[:WATCHED {rating: 4}]->(m4) MERGE (u5)-[:WATCHED {rating: 2}]->(s1) 
MERGE (u6)-[:WATCHED {rating: 5}]->(s2) MERGE (u7)-[:WATCHED {rating: 4}]->(s3) 
MERGE (u8)-[:WATCHED {rating: 5}]->(s4) MERGE (u9)-[:WATCHED {rating: 3}]->(s5) 
MERGE (u10)-[:WATCHED {rating: 4}]->(m5) MERGE (u2)-[:WATCHED {rating: 5}]->(s2) 
MERGE (u6)-[:WATCHED {rating: 3}]->(m2) MERGE (u4)-[:WATCHED {rating: 4}]->(s3) 
MERGE (u5)-[:WATCHED {rating: 5}]->(s4);

RETURN 'Grafo de Streaming Criado e Populado com Sucesso! (42 Nós, 32 Relacionamentos)' AS Status;