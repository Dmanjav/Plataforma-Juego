/***********************************************************************************************
INSTRUCCIONES EN SQL SERVER 
***********************************************************************************************/

CREATE DATABASE GameCTC

USE GameCTC

CREATE TABLE Cuenta
    (
		emailTutor VARCHAR(30),
        nombre VARCHAR(30),
        contraseña VARCHAR(30),
        fechaNacimiento DATE,
        telefono BIGINT,
        pais VARCHAR(58),

        CONSTRAINT Cuenta_PK PRIMARY KEY (emailTutor)
    );

CREATE TABLE Jugador 
    (
		IDJugador VARCHAR (30),
		emailTutor VARCHAR (30),
		nivelesJugados INT,
		horasJugadas BIGINT,
		gamerTag VARCHAR (30),
		nivelInvolucramiento INT,
	
		CONSTRAINT Jugador_PK PRIMARY KEY (IDJugador)
		FOREIGN KEY correos_FK REFERENCES Cuenta(emailTutor)
	);
	
CREATE TABLE Jugador_partida 
	(
		IDPartida int,
		IDNivel int,
		IDJugador VARCHAR (30),
		puntuacion BIGINT,
		fechaJuego date,
		cronometro BIGINT,
		Coleccionable1 BIT,
		Coleccionable2 BIT,
		Coleccionable3 BIT,
		Coleccionable4 BIT,
		Coleccionable5 BIT,

		CONSTRAINT jug_part_pk PRIMARY KEY (IDPartida)
		FOREIGN KEY (IDNivel) REFERENCES Nivel(IDNivel)
		FOREIGN KEY (IDJugador) REFERENCES Jugador(IDJugador)
	)

CREATE TABLE Nivel 
	(
		IDNivel INT,
		itemCheck BIT,
		Nombre VARCHAR (30),
		Coleccionable1 BIT,
		Coleccionable2 BIT,
		Coleccionable3 BIT,
		Coleccionable4 BIT,
		Coleccionable5 BIT,
		
		CONSTRAINT Nivel_PK PRIMARY KEY (IDNivel)
	);

Use GameCTC;
GO;

INSERT INTO Cuenta (emailTutor, nombre, contraseña, fechaNacimiento, telefono, pais)
VALUES 
    ('usuario1@tec.mx','Ana García', 'contra1', '1998-01-23', '5512345678', 'México'),
    ('usuario2@tec.mx','Carla Ortiz', 'contra2', '1997-02-13', '5523456789', 'Argentina'),
    ('usuario3@tec.mx','Diego Jiménez', 'contr3', '1996-03-05', '5534567890', 'Brasil'),
    ('usuario4@tec.mx','Natalia Martínez', 'contra4', '1995-04-24', '5545678901', 'Chile'),
    ('usuario5@tec.mx','Pablo López', 'contra5', '1994-05-17', '5556789012', 'Colombia'),
    ('usuario6@tec.mx','Marta Ruiz', 'contra6', '1993-06-01', '5567890123', 'Costa Rica'),
    ('usuario7@tec.mx','Daniel Sánchez', 'contra7', '1992-07-18', '5578901234', 'Cuba'),
    ('usuario8@tec.mx','Isabel García', 'contra8', '1991-08-06', '5589012345', 'República Dominicana'),
    ('usuario9@tec.mx','Guillermo Martínez', 'contra9', '1990-09-29', '5590123456', 'Ecuador'),
    ('usuario10@tec.mx','Andrea Torres', 'contra10', '1989-10-14', '5511123456', 'El Salvador'),
    ('usuario11@tec.mx','Álvaro Pérez', 'contra11', '1988-11-07', '5522234567', 'Guatemala'),
    ('usuario12@tec.mx','Raúl Ortiz', 'contra12', '1987-12-25', '5533345678', 'Honduras'),
    ('usuario13@tec.mx', 'Sofía Hernández', 'contra13', '1986-01-15', '5544456789', 'Jamaica'),
    ('usuario14@tec.mx','Juan López', 'contra14', '1985-02-19', '5555567890', 'México'),
    ('usuario15@tec.mx','Victoria Fernández', 'contra15', '1984-03-10', '5566678901', 'Nicaragua'),
    ('usuario16@tec.mx','Laura García', 'contra16', '1983-04-27', '5577789012', 'Panamá'),
    ('usuario17@tec.mx','Jesús García', 'contra17', '1982-05-08', '5588890123', 'Paraguay'),
    ('usuario18@tec.mx','Adrián Sánchez', 'contra18', '1981-06-03', '5599901234', 'Perú'),
    ('usuario19@tec.mx','Alicia Gómez', 'contra19', '1980-07-22', '5510012345', 'Puerto Rico'),
    ('usuario20@tec.mx','Sonia Torres', 'contra20', '1979-08-31', '5521123456', 'República Dominicana'),
    ('usuario21@tec.mx','David González', 'contra21', '2000-08-12', 'a42344234', 'mexico', '1234567890'),
    ('usuario22@tec.mx','Elena González', 'contra22', '2001-02-15', 'b12345678', 'mexico', '0987654321'),
    ('usuario23@tec.mx','Juan Perez', 'contra23', '1999-11-30', 'c23456789', 'mexico', '5555555555'),
    ('usuario24@tec.mx','Marisol Martínez', 'contra24', '1998-07-18', 'd34567890', 'mexico', '1111111111'),
    ('usuario25@tec.mx','Fernando Fernández', 'contra25', '2002-04-22', 'e45678901', 'mexico', '2222222222'),
    ('usuario26@tec.mx','Lucía Rodríguez', 'contra26', '2003-01-07', 'f56789012', 'mexico', '3333333333'),
    ('usuario27@tec.mx','Sergio Pérez', 'contra27', '1997-10-12', 'g67890123', 'mexico', '4444444444'),
    ('usuario28@tec.mx','Verónica López', 'contra28', '1996-06-29', 'h78901234', 'mexico', '9999999999'),
    ('usuario29@tec.mx','Francisco Martínez', 'contra29', '2004-03-08', 'i89012345', 'mexico', '8888888888'),
    ('usuario30@tec.mx','Miguel Pérez', 'contra30', '2005-12-01', 'j90123456', 'mexico', '7777777777');

Insert into Jugador (IDJugador, nivelesJugados, horasJugadas, gamerTag, nivelInvolucramiento)
VALUES
    ('jugador1', 1, 1, 'random1', 2),
    ('jugador2', 2, 2, 'random2', 4),
    ('jugador3', 3, 3, 'random3', 6),
    ('jugador4', 4, 5, 'random4', 8),
    ('jugador5', 5, 10, 'random5', 10),
    ('jugador6', 1, 0, 'random6', 2),
    ('jugador7', 2, 1, 'random7', 4),
    ('jugador8', 3, 2, 'random8', 6),
    ('jugador9', 4, 3, 'random9', 8),
    ('jugador10', 5, 5, 'random10', 10),
    ('jugador11', 1, 1, 'random11', 2),
    ('jugador12', 2, 2, 'random12', 4),
    ('jugador13', 3, 3, 'random13', 6),
    ('jugador14', 4, 5, 'random14', 8),
    ('jugador15', 5, 10, 'random15', 10),
    ('jugador16', 1, 0, 'random16', 2),
    ('jugador17', 2, 1, 'random17', 4),
    ('jugador18', 3, 2, 'random18', 6),
    ('jugador19', 4, 3, 'random19', 8),
    ('jugador20', 5, 5, 'random20', 10),
    ('jugador21', 1, 1, 'random21', 2),
    ('jugador22', 2, 2, 'random22', 4),
    ('jugador23', 3, 3, 'random23', 6),
    ('jugador24', 4, 5, 'random24', 8),
    ('jugador25', 5, 10, 'random25', 10),
    ('jugador26', 1, 0, 'random26', 2),
    ('jugador27', 2, 1, 'random27', 4),
    ('jugador28', 3, 2, 'random28', 6),
    ('jugador29', 4, 3, 'random29', 8),
    ('jugador30', 5, 5, 'random30', 10);

Insert into Nivel (IDNivel, itemCheck, nombre, Coleccionable1, Coleccionable2, Coleccionable3, Coleccionable4, Coleccionable5)
VALUES
    (1, 0, 'Level 1', 'false', 'false', 'false', 'false', 'false'),
	(2, 0, 'Level 2', 'false', 'false', 'false', 'false', 'false'),
	(3, 1, 'Level 3', 'false', 'false', 'false', 'false', 'false'),
    (4, 0, 'Level 4', 'false', 'false', 'false', 'false', 'false'),
	(5, 0, 'Level 5', 'false', 'false', 'false', 'false', 'false'),
    
Insert into Jugador_partida (IDPartida, IDNivel, puntuacion, fechaJuego, cronometro, Coleccionable2, Coleccionable2, Coleccionable3, Coleccionable4, Coleccionable5)

VALUES 
    (1, 1, 300000, '2023-01-01', 1000),
    (2, 2, 500000, '2023-02-06', 5000),
    (3, 3, 230000, '2023-03-09', 4000),
    (4, 4, 500000, '2023-04-13', 3000),
    (5, 5, 810000, '2023-05-18', 2000),
    (6, 2, 270000, '2023-06-23', 5000),
    (7, 4, 350000, '2023-07-28', 3000),
    (8, 1, 500000, '2023-08-31', 1000),
    (9, 3, 400000, '2023-10-05', 2000),
    (10, 5, 500000, '2023-11-09', 4000),
    (11, 5, 100000, '2023-12-14', 5000),
    (12, 4, 550000, '2024-01-19', 1000),
    (13, 2, 305000, '2024-02-23', 4000),
    (14, 3, 515000, '2024-03-28', 2000),
    (15, 1, 334000, '2024-05-02', 4000),
    (16, 1, 100000, '2024-06-06', 3000),
    (17, 1, 300000, '2024-07-11', 5000),
    (18, 4, 400300, '2024-08-15', 2000),
    (19, 3, 205000, '2024-09-19', 1000),
    (20, 2, 150000, '2024-10-24', 1000),
    (21, 1, 301000, '2024-11-28', 2000),
    (22, 5, 509000, '2024-12-31', 3000),
    (23, 2, 307000, '2025-02-04', 4000),
    (24, 3, 503000, '2025-03-10', 5000),
    (25, 2, 660000, '2025-04-14', 3000),
    (26, 1, 900000, '2025-05-19', 2000),
    (27, 1, 200000, '2025-06-24', 5000),
    (28, 3, 100140, '2025-07-29', 1000),
    (29, 4, 300230, '2025-09-02', 3000),
    (30, 5, 304300, '2025-10-07', 4000);