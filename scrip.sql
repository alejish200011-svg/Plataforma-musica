-- Creación de la base de datos para la plataforma de música
CREATE DATABASE plataforma_musica;
USE plataforma_musica;

-- Tabla para guardar la info de los grupos musicales
CREATE TABLE grupo (
    id_grupo INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    fecha_cre DATE,
    componente TEXT
);

-- Tabla para los álbumes (aquí va la llave foránea para conectarlo con su grupo)
CREATE TABLE album (
    id_album INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150),
    num_canciones INT,
    fecha_pub DATE,
    id_grupo INT,
    FOREIGN KEY (id_grupo) REFERENCES grupo(id_grupo)
);

-- Tabla principal de canciones
CREATE TABLE cancion (
    id_cancion INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150),
    publica BOOLEAN
);

-- Tabla intermedia para saber qué canciones contiene cada álbum (relación N:M)
CREATE TABLE contiene (
    id_album INT,
    id_cancion INT,
    PRIMARY KEY (id_album, id_cancion),
    FOREIGN KEY (id_album) REFERENCES album(id_album),
    FOREIGN KEY (id_cancion) REFERENCES cancion(id_cancion)
);

-- Tabla para registrar los usuarios de la plataforma
CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    correo VARCHAR(100),
    url VARCHAR(255),
    fecha_alta DATE
);

-- Tabla para los usuarios que tienen cuenta registrada
CREATE TABLE registrado (
    id_registrado INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    cuota DECIMAL(10,2),
    fecha_fin DATE,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

-- Tabla intermedia para los streams o reproducciones de las canciones
CREATE TABLE stream (
    id_cancion INT,
    id_usuario INT,
    fecha DATETIME,
    PRIMARY KEY (id_cancion, id_usuario, fecha),
    FOREIGN KEY (id_cancion) REFERENCES cancion(id_cancion),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

-- Tabla intermedia para las descargas de los usuarios registrados
CREATE TABLE descarga (
    id_cancion INT,
    id_registrado INT,
    fecha DATETIME,
    n_veces INT,
    PRIMARY KEY (id_cancion, id_registrado, fecha),
    FOREIGN KEY (id_cancion) REFERENCES cancion(id_cancion),
    FOREIGN KEY (id_registrado) REFERENCES registrado(id_registrado)
);
