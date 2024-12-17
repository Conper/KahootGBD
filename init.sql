CREATE TABLE PROFESORES (
	ID INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	Nombre VARCHAR(64) NOT NULL,
	Mail VARCHAR(255) NOT NULL
);

CREATE TABLE ALUMNOS (
	ID_Alumno INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	Avatar VARCHAR(128) NOT NULL DEFAULT 'anonymous',
	Nombre VARCHAR(64) NOT NULL,
	Puntos INT NOT NULL DEFAULT 0
);

CREATE TABLE JUEGOS (
	ID_Juego INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	PIN INT NOT NULL DEFAULT 000000,
	Fecha DATE NOT NULL DEFAULT CURRENT_DATE,
	Titulo VARCHAR(255) NOT NULL,
	Descripcion VARCHAR(255) NOT NULL,
	ID_Creador INT NOT NULL,
	CONSTRAINT fk_creador FOREIGN KEY (ID_Creador)
		REFERENCES PROFESORES(ID) ON DELETE CASCADE,
	CONSTRAINT pin6 CHECK (PIN >= 100000 AND PIN <=999999)
);

CREATE TABLE PREGUNTAS (
	ID_Pregunta INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	ID_Juego INT NOT NULL,
	Titulo VARCHAR(255) NOT NULL,
	Puntos INT NOT NULL DEFAULT 750,
	CONSTRAINT fk_id_juego FOREIGN KEY (ID_Juego)
		REFERENCES JUEGOS(ID_Juego) ON DELETE CASCADE
);

CREATE TABLE OPCIONES (
	ID_Pregunta INT NOT NULL,
	Opcion INT NOT NULL,
	Texto VARCHAR(255) NOT NULL,
	Correcta BOOLEAN NOT NULL,
	PRIMARY KEY (ID_Pregunta, Opcion),
	CONSTRAINT fk_id_pregunta FOREIGN KEY (ID_Pregunta)
		REFERENCES PREGUNTAS(ID_Pregunta) ON DELETE CASCADE
);


CREATE TABLE RESPUESTAS (
	ID_Respuesta INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	ID_Alumno INT NOT NULL,
	ID_Pregunta INT NOT NULL,
	Respuesta INT NOT NULL,
	Acierto BOOLEAN NOT NULL,
	-- Puntos_obt INT NOT NULL DEFAULT 750, Aquí nos sirve si es en función del tiempo (Por ahora nada de eso)
	CONSTRAINT fk_alum_resp FOREIGN KEY (ID_Alumno)
		REFERENCES ALUMNOS(ID_Alumno) ON DELETE CASCADE,
	CONSTRAINT fk_preg_resp FOREIGN KEY (ID_Pregunta)
		REFERENCES PREGUNTAS(ID_Pregunta) ON DELETE CASCADE
);


INSERT INTO PROFESORES (Nombre, Mail)
	VALUES 	('Carlos Valls', 'carlosv@gmail.com'),
		('Isabel Fernández', 'isabfern@gmail.com'),
		('Javier Revert', 'javrevgom@gmail.com'),
		('Chema Alonso', 'josmaralo@gmail.com');

INSERT INTO ALUMNOS (Avatar, Nombre, Puntos)
        VALUES 	(DEFAULT, 'Pablo Martí', DEFAULT),
               	('Perro', 'Ana Rodríguez', DEFAULT),
               	('Gato', 'Luis Pérez', DEFAULT),
               	(DEFAULT, 'Marta López', DEFAULT),
               	('Tigre', 'Jorge Martínez', DEFAULT),
               	('León', 'Laura Sánchez', DEFAULT),
               	('Ágila', 'José Díaz', DEFAULT);

INSERT INTO JUEGOS (PIN, Fecha, Descripcion, Titulo, ID_Creador)
        VALUES  ('192842', '2023-11-28', 'Test 1r Trimestre ISO para alumnos de 1ASIR', 'ISO U1-5', '3'),
                ('384720', '2024-02-15', 'Evaluación de Planificación y Administración de Redes', 'Redes U2', '2'),
                ('876245', '2024-05-10', 'Prueba de conceptos de seguridad informática', 'Seguridad U1-2', '4'),
                ('990124', '2024-01-25', 'Examen sobre fundamentos de bases de datos relacionales', 'GBD U1-3', '1');

INSERT INTO PREGUNTAS (ID_Juego, Titulo, Puntos)
	VALUES  ('1', '¿Con que comando puedes crear una carpeta?', DEFAULT),
		('1', '¿Cómo cambiaríamos al usuario JC?', DEFAULT),
		('2', '¿Qué dispositivo se utiliza para segmentar una red en subredes?', DEFAULT),
		('2', '¿Qué protocolo se utiliza para la asignación dinámica de direcciones IP en una red?', DEFAULT);

INSERT INTO OPCIONES (ID_Pregunta, Opcion, Texto, Correcta)
	VALUES  -- Juego 1 --

		-- Pregunta 1 --
		('1', '1', 'cd', FALSE),
		('1', '2', 'mkdir', TRUE),
		('1', '3', 'ps aux', FALSE),
		('1', '4', 'cat', FALSE),

		-- Pregunta 2 --
		('2', '1', 'nano JC', FALSE),
                ('2', '2', 'grep JC', TRUE),
                ('2', '3', 'su JC', TRUE),
                ('2', '4', 'john JC', FALSE),

		-- Juego 2 --

                -- Pregunta 1 --
                ('3', '1', 'Switch', FALSE),
                ('3', '2', 'Firewall', FALSE),
                ('3', '3', 'PC', FALSE),
                ('3', '4', 'Router', TRUE),

                -- Pregunta 2 --
                ('4', '1', 'DHCP', TRUE),
                ('4', '2', 'HTTP', FALSE),
                ('4', '3', 'FTP', TRUE),
                ('4', '4', 'SMTP', FALSE);

