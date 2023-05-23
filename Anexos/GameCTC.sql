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
		IDJugador INT NOT NULL, 
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
		IDjugador INT NOT NULL,
		Nombre VARCHAR (30) NOT NULL,
		Coleccionable1 BIT NOT NULL,
		Coleccionable2 BIT NOT NULL,
		Coleccionable3 BIT NOT NULL,
		Coleccionable4 BIT NOT NULL,
		Coleccionable5 BIT NOT NULL,
		
		CONSTRAINT Nivel_PK PRIMARY KEY (IDNivel),
		CONSTRAINT Player_FK FOREIGN KEY (IDJugador) REFERENCES Jugador(IDJugador)
	);
CREATE TABLE Jugador_partida 
	(
		IDPartida INT NOT NULL ,
		IDNivel INT NOT NULL,
		IDJugador INT NOT NULL,
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
	);



Use GameCTC

