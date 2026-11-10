-- Base de Datos I - Unidad 4 - Ej19: Crowdfunding
-- Script portable (SQLite / MySQL). En SQLite activar antes: PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS APORTE;
DROP TABLE IF EXISTS RECOMPENSA;
DROP TABLE IF EXISTS PROYECTO;
DROP TABLE IF EXISTS USUARIO;

CREATE TABLE USUARIO (
    id_usuario INT PRIMARY KEY,
    nombre_usuario VARCHAR(50),
    email_usuario VARCHAR(50) UNIQUE,
    pais VARCHAR(50),
    datos_cobro_pago VARCHAR(100),
    fecha_registro DATE
);

CREATE TABLE PROYECTO (
    id_proyecto INT PRIMARY KEY,
    id_creador INT,
    codigo_proyecto VARCHAR(50) UNIQUE,
    titulo_proyecto VARCHAR(50),
    categoria VARCHAR(100),
    descripcion VARCHAR(100),
    objetivo_financiero INT,
    fecha_inicio_campana DATE,
    fecha_cierre DATE,
    monto_recaudado DECIMAL(12,2),
    estado_financiacion VARCHAR(100),
    FOREIGN KEY (id_creador) REFERENCES USUARIO(id_usuario)
);

CREATE TABLE RECOMPENSA (
    id_recompensa INT PRIMARY KEY,
    id_proyecto INT,
    titulo_recompensa VARCHAR(50),
    descripcion_recompensa VARCHAR(100),
    valor_minimo DECIMAL(12,2),
    unidades_disponibles INT,
    unidades_reclamadas INT,
    FOREIGN KEY (id_proyecto) REFERENCES PROYECTO(id_proyecto)
);

CREATE TABLE APORTE (
    id_aporte INT PRIMARY KEY,
    id_inversor INT,
    id_proyecto INT,
    id_recompensa INT,
    fecha_hora_aporte DATE,
    monto_aportado DECIMAL(12,2),
    estado_aporte VARCHAR(100),
    FOREIGN KEY (id_inversor) REFERENCES USUARIO(id_usuario),
    FOREIGN KEY (id_proyecto) REFERENCES PROYECTO(id_proyecto),
    FOREIGN KEY (id_recompensa) REFERENCES RECOMPENSA(id_recompensa)
);

-- Datos de USUARIO
INSERT INTO USUARIO (id_usuario, nombre_usuario, email_usuario, pais, fecha_registro) VALUES (1, 'Agustina', 'agus@mail.com', 'Argentina', '2026-01-10');
INSERT INTO USUARIO (id_usuario, nombre_usuario, email_usuario, pais, fecha_registro) VALUES (2, 'Bautista', 'bauti@mail.com', 'Uruguay', '2026-01-22');
INSERT INTO USUARIO (id_usuario, nombre_usuario, email_usuario, pais, fecha_registro) VALUES (3, 'Cecilia', 'ceci@mail.com', 'Chile', '2026-02-03');
INSERT INTO USUARIO (id_usuario, nombre_usuario, email_usuario, pais, fecha_registro) VALUES (4, 'Emilia', 'emi@mail.com', 'México', '2026-03-01');

-- Datos de PROYECTO
INSERT INTO PROYECTO (id_proyecto, id_creador, codigo_proyecto, titulo_proyecto, objetivo_financiero) VALUES (1, 1, 'PRY-A01', 'Café de especialidad', 500000);
INSERT INTO PROYECTO (id_proyecto, id_creador, codigo_proyecto, titulo_proyecto, objetivo_financiero) VALUES (2, 2, 'PRY-A03', 'Documental Patagonia', 1200000);
INSERT INTO PROYECTO (id_proyecto, id_creador, codigo_proyecto, titulo_proyecto, objetivo_financiero) VALUES (3, 3, 'PRY-A04', 'Huerta urbana', 150000);
INSERT INTO PROYECTO (id_proyecto, id_creador, codigo_proyecto, titulo_proyecto, objetivo_financiero) VALUES (4, 4, 'PRY-A05', 'App de reciclaje', 800000);

-- Datos de RECOMPENSA
INSERT INTO RECOMPENSA (id_recompensa, id_proyecto, titulo_recompensa, valor_minimo, unidades_disponibles) VALUES (1, 1, 'Agradecimiento', 1000, 100);
INSERT INTO RECOMPENSA (id_recompensa, id_proyecto, titulo_recompensa, valor_minimo, unidades_disponibles) VALUES (2, 1, 'Pack de café 250g', 8000, 50);
INSERT INTO RECOMPENSA (id_recompensa, id_proyecto, titulo_recompensa, valor_minimo, unidades_disponibles) VALUES (3, 2, 'Entrada al estreno', 10000, 40);
INSERT INTO RECOMPENSA (id_recompensa, id_proyecto, titulo_recompensa, valor_minimo, unidades_disponibles) VALUES (4, 3, 'Kit de semillas', 5000, 200);

-- Datos de APORTE
INSERT INTO APORTE (id_aporte, id_inversor, id_proyecto, id_recompensa, monto_aportado) VALUES (1, 2, 1, 1, 1000);
INSERT INTO APORTE (id_aporte, id_inversor, id_proyecto, id_recompensa, monto_aportado) VALUES (2, 3, 1, 2, 8000);
INSERT INTO APORTE (id_aporte, id_inversor, id_proyecto, id_recompensa, monto_aportado) VALUES (3, 1, 2, NULL, 20000);
INSERT INTO APORTE (id_aporte, id_inversor, id_proyecto, id_recompensa, monto_aportado) VALUES (4, 2, 3, 4, 5000);
