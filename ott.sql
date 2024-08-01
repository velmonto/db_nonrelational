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

-- Tabla de suscripciones de usuarios
CREATE TABLE SuscripcionesUsuarios (
    UsuarioID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    SuscripcionID INT NOT NULL,
    FechaInicio DATE NOT NULL,
    FechaFin DATE NOT NULL,
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