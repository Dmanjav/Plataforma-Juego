/***********************************************************************************************
INSTRUCCIONES EN SQL SERVER 
***********************************************************************************************/

CREATE DATABASE GameCTC

USE GameCTC

CREATE TABLE Cuenta
    (
		emailTutor VARCHAR(30) NOT NULL,
        nombre VARCHAR(30) NOT NULL,
        contraseña VARCHAR(30) NOT NULL,
        fechaNacimiento DATE NOT NULL,
        telefono BIGINT NOT NULL,
        pais VARCHAR(58) NOT NULL,
        adminCuenta BIT NOT NULL,

        CONSTRAINT Cuenta_PK PRIMARY KEY (emailTutor)
    );

CREATE TABLE Jugador 
    (
		IDJugador VARCHAR (30) NOT NULL,
		emailTutor VARCHAR (30) NOT NULL,
		nivelesJugados INT NOT NULL,
		horasJugadas BIGINT NOT NULL,
		gamerTag VARCHAR (30) NOT NULL,
		nivelInvolucramiento INT NOT NULL,
	
		CONSTRAINT Jugador_PK PRIMARY KEY (IDJugador),
		CONSTRAINT Correos_FK FOREIGN KEY (emailTutor) REFERENCES Cuenta(emailTutor)
	);

CREATE TABLE Nivel 
	(
		IDNivel INT NOT NULL,
		Nombre VARCHAR (30) NOT NULL,
		Coleccionable1 BIT NOT NULL,
		Coleccionable2 BIT NOT NULL,
		Coleccionable3 BIT NOT NULL,
		Coleccionable4 BIT NOT NULL,
		Coleccionable5 BIT NOT NULL,
		
		CONSTRAINT Nivel_PK PRIMARY KEY (IDNivel)
	);
CREATE TABLE Jugador_partida 
	(
		IDPartida INT NOT NULL,
		IDNivel INT NOT NULL,
		IDJugador VARCHAR (30) NOT NULL,
		puntuacion BIGINT NOT NULL,
		fechaJuego DATE NOT NULL,
		cronometro BIGINT NOT NULL,
		Coleccionable1 BIT NOT NULL,
		Coleccionable2 BIT NOT NULL,
		Coleccionable3 BIT NOT NULL,
		Coleccionable4 BIT NOT NULL,
		Coleccionable5 BIT NOT NULL,

		CONSTRAINT jug_part_pk PRIMARY KEY (IDPartida),
		CONSTRAINT jug_part_fk1 FOREIGN KEY (IDNivel) REFERENCES Nivel(IDNivel),
		CONSTRAINT jug_part_fk2 FOREIGN KEY (IDJugador) REFERENCES Jugador(IDJugador)
	)



Use GameCTC;
GO;

INSERT INTO Cuenta (emailTutor, nombre, contraseña, fechaNacimiento, telefono, pais, adminCuenta)
VALUES 
    ('adminManja@tec.mx','Manja', 'contradmin1', '1990-05-02', '7772185572', 'México', 'true'),
    ('usuario1@tec.mx','Ana García', 'contra1', '1998-01-23', '5512345678', 'México', 'false'),
    ('usuario2@tec.mx','Carla Ortiz', 'contra2', '1997-02-13', '5523456789', 'Argentina', 'false'),
    ('usuario3@tec.mx','Diego Jiménez', 'contr3', '1996-03-05', '5534567890', 'Brasil', 'false'),
    ('usuario4@tec.mx','Natalia Martínez', 'contra4', '1995-04-24', '5545678901', 'Chile', 'false'),
    ('usuario5@tec.mx','Pablo Spínola', 'contra5', '1994-05-17', '5556789012', 'Colombia', 'false'),
    ('usuario6@tec.mx','Marta Ruiz', 'contra6', '1993-06-01', '5567890123', 'Costa Rica', 'false'),
    ('usuario7@tec.mx','Daniela Sánchez', 'contra7', '1992-07-18', '5578901234', 'Cuba', 'false'),
    ('usuario8@tec.mx','Isabel García', 'contra8', '1991-08-06', '5589012345', 'República Dominicana', 'false'),
    ('usuario9@tec.mx','Guillermo Martínez', 'contra9', '1990-09-29', '5590123456', 'Ecuador', 'false'),
    ('usuario10@tec.mx','Andrea Torres', 'contra10', '1989-10-14', '5511123456', 'El Salvador', 'false'),
    ('usuario11@tec.mx','Álvaro Pérez', 'contra11', '1988-11-07', '5522234567', 'Guatemala', 'false'),
    ('usuario12@tec.mx','Raúl Ortiz', 'contra12', '1987-12-25', '5533345678', 'Honduras', 'false'),
    ('usuario13@tec.mx', 'Sofía Hernández', 'contra13', '1986-01-15', '5544456789', 'Jamaica', 'false'),
    ('usuario14@tec.mx','Juan López', 'contra14', '1985-02-19', '5555567890', 'México', 'false'),
    ('usuario15@tec.mx','Victoria Fernández', 'contra15', '1984-03-10', '5566678901', 'Nicaragua', 'false'),
    ('usuario16@tec.mx','Laura García', 'contra16', '1983-04-27', '5577789012', 'Panamá', 'false'),
    ('usuario17@tec.mx','Jesús García', 'contra17', '1982-05-08', '5588890123', 'Paraguay', 'false'),
    ('usuario18@tec.mx','Adrián Sánchez', 'contra18', '1981-06-03', '5599901234', 'Perú', 'false'),
    ('usuario19@tec.mx','Alicia Gómez', 'contra19', '1980-07-22', '5510012345', 'Puerto Rico', 'false'),
    ('usuario20@tec.mx','Sonia Torres', 'contra20', '1979-08-31', '5521123456', 'República Dominicana', 'false'),
    ('usuario21@tec.mx','David González', 'contra21', '2000-08-12', '42344234', 'México', 'false'),
    ('usuario22@tec.mx','Elena González', 'contra22', '2001-02-15', '12345678', 'México', 'false'),
    ('usuario23@tec.mx','Juan Perez', 'contra23', '1999-11-30', '23456789', 'México', 'false'),
    ('usuario24@tec.mx','Marisol Martínez', 'contra24', '1998-07-18', '34567890', 'México', 'false'),
    ('usuario25@tec.mx','Fernando Fernández', 'contra25', '2002-04-22', '45678901', 'México', 'false'),
    ('usuario26@tec.mx','Lucía Rodríguez', 'contra26', '2003-01-07', '56789012', 'México', 'false'),
    ('usuario27@tec.mx','Sergio Pérez', 'contra27', '1997-10-12', '67890123', 'México', 'false'),
    ('usuario28@tec.mx','Verónica López', 'contra28', '1996-06-29', '78901234', 'México', 'false'),
    ('usuario29@tec.mx','Francisco Martínez', 'contra29', '2004-03-08', '89012345', 'México', 'false'),
    ('usuario30@tec.mx','Miguel Pérez', 'contra30', '2005-12-01', '90123456', 'México', 'false');

Insert into Jugador (IDJugador, emailTutor, nivelesJugados, horasJugadas, gamerTag, nivelInvolucramiento)
VALUES
    ('jugador1', 'usuario1@tec.mx', 1, 1, 'random1', 2),
    ('jugador2', 'usuario2@tec.mx', 2, 2, 'random2', 4),
    ('jugador3', 'usuario3@tec.mx', 3, 3, 'random3', 6),
    ('jugador4', 'usuario4@tec.mx', 4, 5, 'random4', 8),
    ('jugador5', 'usuario5@tec.mx', 5, 10, 'random5', 10),
    ('jugador6', 'usuario6@tec.mx', 1, 0, 'random6', 2),
    ('jugador7', 'usuario7@tec.mx', 2, 1, 'random7', 4),
    ('jugador8', 'usuario8@tec.mx', 3, 2, 'random8', 6),
    ('jugador9', 'usuario9@tec.mx', 4, 3, 'random9', 8),
    ('jugador10', 'usuario10@tec.mx', 5, 5, 'random10', 10),
    ('jugador11', 'usuario11@tec.mx', 1, 1, 'random11', 2),
    ('jugador12', 'usuario12@tec.mx', 2, 2, 'random12', 4),
    ('jugador13', 'usuario13@tec.mx', 3, 3, 'random13', 6),
    ('jugador14', 'usuario14@tec.mx', 4, 5, 'random14', 8),
    ('jugador15', 'usuario15@tec.mx', 5, 10, 'random15', 10),
    ('jugador16', 'usuario16@tec.mx', 1, 0, 'random16', 2),
    ('jugador17', 'usuario17@tec.mx', 2, 1, 'random17', 4),
    ('jugador18', 'usuario18@tec.mx', 3, 2, 'random18', 6),
    ('jugador19', 'usuario19@tec.mx', 4, 3, 'random19', 8),
    ('jugador20', 'usuario20@tec.mx', 5, 5, 'random20', 10),
    ('jugador21', 'usuario21@tec.mx', 1, 1, 'random21', 2),
    ('jugador22', 'usuario22@tec.mx', 2, 2, 'random22', 4),
    ('jugador23', 'usuario23@tec.mx', 3, 3, 'random23', 6),
    ('jugador24', 'usuario24@tec.mx', 4, 5, 'random24', 8),
    ('jugador25', 'usuario25@tec.mx', 5, 10, 'random25', 10),
    ('jugador26', 'usuario26@tec.mx', 1, 0, 'random26', 2),
    ('jugador27', 'usuario27@tec.mx', 2, 1, 'random27', 4),
    ('jugador28', 'usuario28@tec.mx', 3, 2, 'random28', 6),
    ('jugador29', 'usuario29@tec.mx', 4, 3, 'random29', 8),
    ('jugador30', 'usuario30@tec.mx', 5, 5, 'random30', 10);

Insert into Nivel (IDNivel, nombre, Coleccionable1, Coleccionable2, Coleccionable3, Coleccionable4, Coleccionable5)
VALUES
    (1, 'Level 1', 'false', 'false', 'false', 'false', 'false'),
	(2, 'Level 2', 'false', 'false', 'false', 'false', 'false'),
	(3, 'Level 3', 'false', 'false', 'false', 'false', 'false'),
    (4, 'Level 4', 'false', 'false', 'false', 'false', 'false'),
	(5, 'Level 5', 'false', 'false', 'false', 'false', 'false')

Insert into Jugador_partida (IDPartida, IDNivel, IDJugador, puntuacion, fechaJuego, cronometro, Coleccionable1, Coleccionable2, Coleccionable3, Coleccionable4, Coleccionable5)
VALUES 
    (1, 1, 'jugador1', 300000, '2023-01-01', 1000, 'true', 'true', 'true', 'false', 'true'),
    (2, 2, 'jugador7', 500000, '2023-02-06', 5000, 'true', 'true', 'true', 'true', 'true'),
    (3, 3, 'jugador24', 230000, '2023-03-09', 4000, 'false', 'false', 'true', 'false', 'false'),
    (4, 4, 'jugador14', 500000, '2023-04-13', 3000, 'false', 'true', 'true', 'true', 'false'),
    (5, 5, 'jugador26', 810000, '2023-05-18', 2000, 'true', 'true', 'false', 'true', 'false'),
    (6, 2, 'jugador19', 270000, '2023-06-23', 5000, 'false', 'true', 'true', 'false', 'true'),
    (7, 4, 'jugador15', 350000, '2023-07-28', 3000, 'false', 'true', 'false', 'false', 'true'),
    (8, 1, 'jugador7',  500000, '2023-08-31', 1000, 'true', 'false', 'true', 'false', 'true'),
    (9, 3, 'jugador14',  400000, '2023-10-05', 2000, 'true', 'true', 'false', 'true', 'true'),
    (10, 5, 'jugador24',  500000, '2023-11-09', 4000, 'false', 'false', 'true', 'true', 'false'),
    (11, 5, 'jugador21',  100000, '2023-12-14', 5000, 'true', 'true', 'true', 'true', 'true'),
    (12, 4, 'jugador14',  550000, '2024-01-19', 1000, 'false', 'true', 'false', 'false', 'true'),
    (13, 2, 'jugador5',  305000, '2024-02-23', 4000, 'true', 'false', 'true', 'false', 'false'), 
    (14, 3, 'jugador10',  515000, '2024-03-28', 2000, 'false', 'true', 'true', 'true', 'false'),
    (15, 1, 'jugador4',  334000, '2024-05-02', 4000, 'false', 'true', 'false', 'true', 'true'),
    (16, 1, 'jugador18',  100000, '2024-06-06', 3000, 'false', 'true', 'true', 'false', 'false'),
    (17, 1, 'jugador13',  300000, '2024-07-11', 5000, 'false', 'false', 'false', 'false', 'false'),
    (18, 4, 'jugador23',  400300, '2024-08-15', 2000, 'false', 'true', 'true', 'false', 'true'),
    (19, 3, 'jugador20',  205000, '2024-09-19', 1000, 'true', 'true', 'true', 'false', 'false'),
    (20, 2, 'jugador7',  150000, '2024-10-24', 1000, 'true', 'true', 'true', 'true', 'true'),
    (21, 1, 'jugador11',  301000, '2024-11-28', 2000, 'false', 'true', 'true', 'false', 'true'),
    (22, 5, 'jugador30',  509000, '2024-12-31', 3000, 'true', 'false', 'true', 'false', 'true'),
    (23, 2, 'jugador23',  307000, '2025-02-04', 4000,  'false', 'true', 'true', 'false', 'true'),
    (24, 3, 'jugador3',  503000, '2025-03-10', 5000, 'true', 'false', 'true', 'false', 'false'),
    (25, 2, 'jugador12',  660000, '2025-04-14', 3000,  'false', 'true', 'true', 'false', 'false'),
    (26, 1, 'jugador10',  900000, '2025-05-19', 2000,  'false', 'true', 'false', 'false', 'true'),
    (27, 1, 'jugador12',  200000, '2025-06-24', 5000, 'false', 'true', 'true', 'true', 'false'),
    (28, 3, 'jugador27',  100140, '2025-07-29', 1000, 'false', 'false', 'false', 'false', 'false'),
    (29, 4, 'jugador19',  300230, '2025-09-02', 3000, 'false', 'true', 'true', 'false', 'true'),
    (30, 5, 'jugador23',  304300, '2025-10-07', 4000, 'true', 'true', 'true', 'true', 'true');