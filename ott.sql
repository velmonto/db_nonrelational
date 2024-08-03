-- Creación de la base de datos
CREATE DATABASE OTT_Platform;
USE OTT_Platform;

-- Tabla de paises
CREATE TABLE Paises(
	PaisID INT(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
	NombrePais VARCHAR(50) NOT NULL,
	Descripcion VARCHAR(100) NOT NULL
);

-- Tabla de usuarios
CREATE TABLE Usuarios (
    UsuarioID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Contraseña VARCHAR(255) NOT NULL,
    FechaNacimiento DATE NOT NULL,
    FechaRegistro DATE NOT NULL,
	PaisID INT NOT NULL,
	FOREIGN KEY (PaisID) REFERENCES Paises(PaisID)
);

-- Tabla de administradores
CREATE TABLE Administradores (
    AdminID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Contraseña VARCHAR(255) NOT NULL,
    FechaRegistro DATE NOT NULL
);

-- Tabla de sesiones de usuarios
CREATE TABLE SesionesUsuarios (
    SesionID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    UsuarioID INT NOT NULL,
    Token VARCHAR(255) NOT NULL,
    FechaInicio DATE NOT NULL,
    FechaFin DATE NOT NULL,
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID)
);

-- Tabla de sesiones de administradores
CREATE TABLE SesionesAdministradores (
    SesionID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    AdminID INT NOT NULL,
    Token VARCHAR(255) NOT NULL,
    FechaInicio DATE NOT NULL,
    FechaFin DATE NOT NULL,
    FOREIGN KEY (AdminID) REFERENCES Administradores(AdminID)
);

-- Tabla de suscripciones
CREATE TABLE Suscripciones (
    SuscripcionID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    Tipo VARCHAR(50) NOT NULL,
    Precio DECIMAL(10,2) NOT NULL,
    Descripcion TEXT NOT NULL
);

-- Tabla de Medios de pago
CREATE TABLE MediosPago(
	MedioPagoID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
	NombreMedioPago VARCHAR(100) NOT NULL,
	Descripcion VARCHAR(100) NOT NULL
);

-- Tabla de suscripciones de usuarios
CREATE TABLE SuscripcionesUsuarios (
    UsuarioID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    SuscripcionID INT NOT NULL,
    FechaInicio DATE NOT NULL,
    FechaFin DATE NOT NULL,
	MedioPagoID INT NOT NULL,
	FOREIGN KEY (MedioPagoID) REFERENCES MediosPago(MedioPagoID),
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID),
    FOREIGN KEY (SuscripcionID) REFERENCES Suscripciones(SuscripcionID)
);

-- Tabla de categorías
CREATE TABLE Categorias (
    CategoriaID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    Descripcion TEXT NOT NULL
);

-- Tabla de películas
CREATE TABLE Peliculas (
    PeliculaID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    Titulo VARCHAR(255) NOT NULL,
    Descripcion TEXT NOT NULL,
    FechaEstreno DATE NOT NULL,
    Duracion INT NOT NULL,
    Clasificacion VARCHAR(10) NOT NULL,
    CategoriaID INT NOT NULL,
    AdminID INT NOT NULL,
    FOREIGN KEY (CategoriaID) REFERENCES Categorias(CategoriaID),
    FOREIGN KEY (AdminID) REFERENCES Administradores(AdminID)
);

-- Tabla de series
CREATE TABLE Series (
    SerieID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    Titulo VARCHAR(255) NOT NULL,
    Descripcion TEXT NOT NULL,
    FechaEstreno DATE NOT NULL,
    Clasificacion VARCHAR(10) NOT NULL,
    CategoriaID INT NOT NULL,
    AdminID INT NOT NULL,
    FOREIGN KEY (CategoriaID) REFERENCES Categorias(CategoriaID),
    FOREIGN KEY (AdminID) REFERENCES Administradores(AdminID)
);

-- Tabla de temporadas
CREATE TABLE Temporadas (
    TemporadaID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    SerieID INT NOT NULL,
    NumeroTemporada INT NOT NULL,
    FechaEstreno DATE NOT NULL,
    FOREIGN KEY (SerieID) REFERENCES Series(SerieID)
);

-- Tabla de episodios
CREATE TABLE Episodios (
    EpisodioID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    TemporadaID INT NOT NULL,
    NumeroEpisodio INT NOT NULL,
    Titulo VARCHAR(255) NOT NULL,
    Descripcion TEXT NOT NULL,
    Duracion INT NOT NULL,
    FechaEstreno DATE NOT NULL,
    FOREIGN KEY (TemporadaID) REFERENCES Temporadas(TemporadaID)
);

-- Tabla de reproducciones
CREATE TABLE Reproducciones (
    ReproduccionID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    UsuarioID INT NOT NULL,
    PeliculaID INT NOT NULL,
    EpisodioID INT NOT NULL,
    FechaReproduccion DATE NOT NULL,
    DuracionReproduccion INT NOT NULL,
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID),
    FOREIGN KEY (PeliculaID) REFERENCES Peliculas(PeliculaID),
    FOREIGN KEY (EpisodioID) REFERENCES Episodios(EpisodioID)
);


-- Tabla intermedia entre paises y peliculas
CREATE TABLE Pais_Peliculas_Series(
	PaisID INT NOT NULL,
	PeliculaID INT,
	SerieID INT,
    FOREIGN KEY (PeliculaID) REFERENCES Peliculas(PeliculaID),
    FOREIGN KEY (PaisID) REFERENCES Paises(PaisID),
	FOREIGN KEY (SerieID) REFERENCES Series(SerieID)
);

-- Insercion de los datos de las tablas
INSERT INTO Paises (NombrePais, Descripcion) VALUES
('Estados Unidos', 'País de América del Norte'),
('México', 'País de América del Norte'),
('España', 'País de Europa Occidental'),
('Colombia', 'País de América del Sur'),
('Argentina', 'País de América del Sur'),
('Brasil', 'País de América del Sur'),
('Chile', 'País de América del Sur'),
('Perú', 'País de América del Sur'),
('Francia', 'País de Europa Occidental'),
('Italia', 'País de Europa Occidental'),
('Alemania', 'País de Europa Central');

INSERT INTO Usuarios (Nombre, Apellido, Email, Contraseña, FechaNacimiento, FechaRegistro, PaisID) VALUES
('Andres', 'Tamayo', 'andres.tamayo@gmail.com', 'contraseña123', '2000-08-01', '2024-01-01', 1),
('Juan Camilo', 'Vargas', 'juan.vargas@gmail.com', 'contraseña123', '2003-08-01', '2024-02-15', 2),
('Cristian', 'Rojo', 'cristian.rojo@gmail.com', 'contraseña123', '1995-08-01', '2024-03-10', 3),
('Daniel', 'Velmonto', 'daniel.velmonto@gmail.com', 'contraseña123', '1997-08-01', '2024-04-05', 4),
('Laura', 'García', 'laura.garcia@gmail.com', 'contraseña123', '1990-05-15', '2024-05-01', 4), 
('Miguel', 'Martínez', 'miguel.martinez@gmail.com', 'contraseña123', '1985-11-23', '2024-06-01', 4), 
('Ana', 'Mendoza', 'ana.mendoza@gmail.com', 'contraseña123', '1992-03-12', '2024-07-01', 2), 
('Luis', 'Pérez', 'luis.perez@gmail.com', 'contraseña123', '1988-09-30', '2024-07-15', 1), 
('Sofía', 'Hernández', 'sofia.hernandez@gmail.com', 'contraseña123', '1995-12-05', '2024-07-20', 4),
('Valeria', 'Gómez', 'valeria.gomez@gmail.com', 'contraseña123', '1993-07-22', '2024-08-01', 4), 
('Andrés', 'Santos', 'andres.santos@gmail.com', 'contraseña123', '1989-04-18', '2024-08-05', 4), 
('Camila', 'Castro', 'camila.castro@gmail.com', 'contraseña123', '1998-10-09', '2024-08-10', 2),
('Maria', 'Lopez', 'maria.lopez@gmail.com', 'contraseña123', '1991-02-11', '2024-05-01', 11), 
('Jose', 'Fernandez', 'jose.fernandez@gmail.com', 'contraseña123', '1983-11-19', '2024-06-01', 6), 
('Lucia', 'Diaz', 'lucia.diaz@gmail.com', 'contraseña123', '1987-04-17', '2024-07-01', 7), 
('Pablo', 'Reyes', 'pablo.reyes@gmail.com', 'contraseña123', '1990-01-09', '2024-07-15', 7), 
('Carla', 'Sanchez', 'carla.sanchez@gmail.com', 'contraseña123', '1995-09-21', '2024-07-20', 9), 
('David', 'Mora', 'david.mora@gmail.com', 'contraseña123', '1988-12-12', '2024-08-01', 10),
('Santiago', 'Perez', 'santiago.perez@gmail.com', 'contraseña123', '1992-08-08', '2024-08-05', 11); 

INSERT INTO Administradores (Nombre, Apellido, Email, Contraseña, FechaRegistro) VALUES
('Carlos', 'Gómez', 'carlos.gomez@gmail.com', 'adminpass123', '2024-01-01'),
('María', 'Rodríguez', 'maria.rodriguez@gmail.com', 'adminpass123', '2024-02-01');

INSERT INTO SesionesUsuarios (UsuarioID, Token, FechaInicio, FechaFin) VALUES
(1, 'token123', '2024-07-01', '2024-07-31'),
(2, 'token456', '2024-07-05', '2024-07-31'),
(3, 'token789', '2024-07-10', '2024-07-31'),
(4, 'token101', '2024-07-15', '2024-07-31');

INSERT INTO SesionesAdministradores (AdminID, Token, FechaInicio, FechaFin) VALUES
(1, 'admintoken123', '2024-07-01', '2024-07-31'),
(2, 'admintoken456', '2024-07-05', '2024-07-31');

INSERT INTO Suscripciones (Tipo, Precio, Descripcion) VALUES
('Mensual', 39900, 'Suscripción mensual con acceso limitado'),
('Semestral', 199900, 'Suscripción semestral con acceso ilimitado'),
('Anual', 379900, 'Suscripción anual con acceso ilimitado');

INSERT INTO MediosPago (NombreMedioPago, Descripcion) VALUES
('Tarjeta de Crédito', 'Pago con tarjeta de crédito'),
('PayPal', 'Pago con PayPal'),
('PSE', 'Pago por PSE');

INSERT INTO SuscripcionesUsuarios (UsuarioID, SuscripcionID, FechaInicio, FechaFin, MedioPagoID) VALUES
(1, 1, '2024-07-01', '2024-08-01', 1),
(2, 2, '2024-07-05', '2025-01-05', 2),
(3, 3, '2024-07-10', '2025-07-10', 3),
(4, 1, '2024-07-15', '2024-08-15', 1),
(13, 2, '2024-07-01', '2025-01-01', 1), 
(14, 3, '2024-07-10', '2025-07-10', 2),
(15, 1, '2024-07-15', '2024-08-15', 3), 
(16, 2, '2024-07-20', '2025-01-20', 1), 
(17, 1, '2024-07-25', '2024-08-25', 2),
(31, 2, '2024-08-01', '2025-02-01', 1),
(32, 3, '2024-08-10', '2025-08-10', 2), 
(33, 1, '2024-08-15', '2024-09-15', 3), 
(34, 2, '2024-08-20', '2025-02-20', 1), 
(35, 3, '2024-08-25', '2025-08-25', 2), 
(36, 1, '2024-09-01', '2024-10-01', 3), 
(37, 2, '2024-09-05', '2025-03-05', 1); 

INSERT INTO Categorias (Nombre, Descripcion) VALUES
('Acción', 'Películas y series de acción'),
('Comedia', 'Películas y series de comedia'),
('Drama', 'Películas y series de drama'),
('Ciencia Ficción', 'Películas y series de ciencia ficción');

INSERT INTO Peliculas (Titulo, Descripcion, FechaEstreno, Duracion, Clasificacion, CategoriaID, AdminID) VALUES
('Matrix', 'Una película llena de acción y ciencia ficción', '1999-03-31', 136, 'R', 4, 1),
('El Señor de los Anillos: La Comunidad del Anillo', 'Una épica aventura de fantasía', '2001-12-19', 178, 'PG-13', 1, 2),
('Titanic', 'Una historia de amor y tragedia', '1997-12-19', 195, 'PG-13', 3, 1),
('Avengers: Endgame', 'Superhéroes luchando contra el mal', '2019-04-26', 181, 'PG-13', 1, 2);

INSERT INTO Series (Titulo, Descripcion, FechaEstreno, Clasificacion, CategoriaID, AdminID) VALUES
('Breaking Bad', 'Un profesor de química convertido en fabricante de metanfetaminas', '2008-01-20', 'TV-MA', 3, 1),
('Friends', 'Un grupo de amigos viviendo en Nueva York', '1994-09-22', 'TV-PG', 2, 2),
('Stranger Things', 'Un grupo de niños descubriendo misterios y fenómenos sobrenaturales', '2016-07-15', 'TV-14', 4, 1),
('Game of Thrones', 'Familias nobles luchando por el control del Trono de Hierro', '2011-04-17', 'TV-MA', 1, 2);

INSERT INTO Temporadas (SerieID, NumeroTemporada, FechaEstreno) VALUES
(1, 1, '2008-01-20'),
(2, 1, '1994-09-22'),
(3, 1, '2016-07-15'),
(4, 1, '2011-04-17');

INSERT INTO Episodios (TemporadaID, NumeroEpisodio, Titulo, Descripcion, Duracion, FechaEstreno) VALUES
(1, 1, 'Pilot', 'El comienzo de todo', 58, '2008-01-20'),
(2, 1, 'The One Where Monica Gets a Roommate', 'Rachel se une al grupo', 22, '1994-09-22'),
(3, 1, 'Chapter One: The Vanishing of Will Byers', 'Will desaparece', 47, '2016-07-15'),
(4, 1, 'Winter Is Coming', 'La llegada del invierno', 62, '2011-04-17');

INSERT INTO Reproducciones (UsuarioID, PeliculaID, EpisodioID, FechaReproduccion, DuracionReproduccion) VALUES
(1, 1, 2, '2024-07-01', 136),
(2, 1, 1, '2024-07-05', 58),
(3, 3, 1, '2024-07-10', 195),
(4, 1, 4, '2024-07-15', 62);

-- Insercion de datos en la tabla de pais y peliculas
INSERT INTO Pais_Peliculas_Series (PaisId, PeliculaID, SerieID) VALUES
(1, 1, 1),
(1, 2, NULL),
(1, 3, NULL),
(1, 4, NULL),
(2, 1, 2),
(3, 1, 2),
(4, 1, 2);

-- CRUD
-- CREATE
INSERT INTO Usuarios (Nombre, Apellido, Email, Contraseña, FechaNacimiento, FechaRegistro, PaisID)
VALUES ('Juan Guillermo', 'Florez', 'juangui.florez@gmail.com', 'contraseña123', '1997-08-01', '2024-05-27', 4);

-- READ
SELECT * FROM Usuarios;
SELECT * FROM Usuarios WHERE UsuarioID = 10;

-- UPDATE
UPDATE Usuarios
SET Email = 'florez.juangui@gmail.com', Contraseña = 'contraseña456'
WHERE UsuarioID = 10;

-- DELETE
DELETE FROM Usuarios WHERE UsuarioID = 10;

-- LEFT JOIN y RIGHT JOIN
-- Usuarios y suscripciones asociadas
SELECT U.Nombre, U.Apellido, S.Tipo, S.Precio
FROM Usuarios U
LEFT JOIN SuscripcionesUsuarios SU ON U.UsuarioID = SU.UsuarioID
LEFT JOIN Suscripciones S ON SU.SuscripcionID = S.SuscripcionID;

-- Medios de pago y suscripciones de los usuarios
SELECT M.NombreMedioPago, U.Nombre, U.Apellido
FROM MediosPago M
RIGHT JOIN SuscripcionesUsuarios SU ON M.MedioPagoID = SU.MedioPagoID
RIGHT JOIN Usuarios U ON SU.UsuarioID = U.UsuarioID;

-- HAVING
-- Numero de usuarios por pais y se filtra con el HAVING paises que tienen mas de un usuario
SELECT P.NombrePais, COUNT(U.UsuarioID) AS NumeroUsuarios
FROM Usuarios U
JOIN Paises P ON U.PaisID = P.PaisID
GROUP BY P.NombrePais
HAVING COUNT(U.UsuarioID) > 1;

-- Cursor para recorrer la tabla Peliculas 
DELIMITER //

DROP PROCEDURE IF EXISTS pelicula_procedure//
CREATE PROCEDURE pelicula_procedure()
BEGIN

  DECLARE var_id INTEGER;
  DECLARE var_titulo VARCHAR(255);
  DECLARE var_descripcion VARCHAR(255);
  DECLARE var_duracion INTEGER DEFAULT 0;

  DECLARE cursor1 CURSOR FOR SELECT PeliculaID, Titulo, Descripcion, Duracion FROM Peliculas;

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET var_duracion = 1;

  OPEN cursor1;

  bucle: LOOP

    FETCH cursor1 INTO var_id, var_titulo, var_duracion, var_duracion;

    IF var_duracion = 1 THEN
      LEAVE bucle;
    END IF;

    UPDATE peliculas SET Duracion = var_duracion + 10 WHERE PeliculaID = var_id;

    SELECT
      var_titulo AS  'titulo',
      var_duracion AS 'Anterior',
      Duracion AS 'Incremento'
      FROM Peliculas WHERE PeliculaID = var_id;


  END LOOP bucle;
  CLOSE cursor1;

END//
DELIMITER ;

-- Trigger para insertar en la tabla paises despues de insertar en usuarios
CREATE TRIGGER `disparador_usuarios` AFTER INSERT ON `usuarios` FOR EACH ROW INSERT INTO Paises (NombrePais, Descripcion) VALUES ('Estados Unidos', 'País de América del Norte');

-- Consulta de geolocalizacion
SELECT * FROM usuarios where 