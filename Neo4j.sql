//Crear Nodos
// Usuarios
CREATE (u1:User {name: 'Alice', age: 30, location: 'Medellín'})
CREATE (u2:User {name: 'Bob', age: 25, location: 'Bogotá'})

// Películas
CREATE (p1:Movie {title: 'Inception', year: 2010, genre: 'Sci-Fi'})
CREATE (p2:Movie {title: 'The Matrix', year: 1999, genre: 'Action'})

// Series
CREATE (s1:Series {title: 'Stranger Things', seasons: 4, genre: 'Sci-Fi'})
CREATE (s2:Series {title: 'Breaking Bad', seasons: 5, genre: 'Drama'})

// Suscripciones
CREATE (sub1:Subscription {type: 'Basic', price: 8.99})
CREATE (sub2:Subscription {type: 'Premium', price: 15.99})

// Perfiles
CREATE (pr1:Profile {name: 'Alice Profile', preferences: 'Sci-Fi, Action'})
CREATE (pr2:Profile {name: 'Bob Profile', preferences: 'Drama, Thriller'})

//Crear Relaciones
// Relación de usuarios con suscripciones
CREATE (u1)-[:HAS_SUBSCRIPTION]->(sub1)
CREATE (u2)-[:HAS_SUBSCRIPTION]->(sub2)

// Relación de usuarios con perfiles
CREATE (u1)-[:HAS_PROFILE]->(pr1)
CREATE (u2)-[:HAS_PROFILE]->(pr2)

// Relación de perfiles con películas y series vistas
CREATE (pr1)-[:WATCHED]->(p1)
CREATE (pr1)-[:WATCHED]->(s1)
CREATE (pr2)-[:WATCHED]->(p2)
CREATE (pr2)-[:WATCHED]->(s2)

// Relación de películas y series con géneros
CREATE (p1)-[:BELONGS_TO]->(:Genre {name: 'Sci-Fi'})
CREATE (p2)-[:BELONGS_TO]->(:Genre {name: 'Action'})
CREATE (s1)-[:BELONGS_TO]->(:Genre {name: 'Sci-Fi'})
CREATE (s2)-[:BELONGS_TO]->(:Genre {name: 'Drama'})

// Relación de usuarios con geolocalización
CREATE (u1)-[:LOCATED_IN]->(:Location {city: 'Medellín', country: 'Colombia'})
CREATE (u2)-[:LOCATED_IN]->(:Location {city: 'Bogotá', country: 'Colombia'})

Consultas de Ejemplo
Para obtener todas las películas vistas por un usuario específico:

MATCH (u:User {name: 'Alice'})-[:HAS_PROFILE]->(pr:Profile)-[:WATCHED]->(m:Movie)
RETURN m.title

Para obtener todas las series vistas por un usuario específico:

MATCH (u:User {name: 'Bob'})-[:HAS_PROFILE]->(pr:Profile)-[:WATCHED]->(s:Series)
RETURN s.title

Para obtener la suscripción de un usuario:

MATCH (u:User {name: 'Alice'})-[:HAS_SUBSCRIPTION]->(sub:Subscription)
RETURN sub.type, sub.price