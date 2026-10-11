-- Generado por Oracle SQL Developer Data Modeler 24.3.0.240.1210
--   en:        2026-10-11 03:17:20 CLST
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE asociacion (
    id_asociacion     NUMBER(4) NOT NULL,
    nombre_asociacion VARCHAR2(100) NOT NULL,
    fecha_creacion    DATE NOT NULL,
    tipo_asociacion   VARCHAR2(1) NOT NULL
);

ALTER TABLE asociacion ADD CONSTRAINT asociacion_pk PRIMARY KEY ( id_asociacion );

CREATE TABLE club_futbol (
    id_club         NUMBER(5) NOT NULL,
    nombre_club     VARCHAR2(100) NOT NULL,
    patrimonio      NUMBER(15) NOT NULL,
    ubicacion_calle VARCHAR2(150) NOT NULL,
    tipo_club       VARCHAR2(20) NOT NULL
);

ALTER TABLE club_futbol ADD CONSTRAINT club_futbol_pk PRIMARY KEY ( id_club );

CREATE TABLE comuna (
    id_comuna        NUMBER(4) NOT NULL,
    id_region        NUMBER(3) NOT NULL,
    nombre           VARCHAR2(80) NOT NULL,
    region_id_region NUMBER(3) NOT NULL
);

ALTER TABLE comuna ADD CONSTRAINT comuna_pk PRIMARY KEY ( id_comuna );

CREATE TABLE escuela_futbol (
    id_escuela      NUMBER(5) NOT NULL,
    nombre_         VARCHAR2(100) NOT NULL,
    capacidad       NUMBER(6),
    fecha_fundacion DATE
);

ALTER TABLE escuela_futbol ADD CONSTRAINT escuela_futbol_pk PRIMARY KEY ( id_escuela );

CREATE TABLE historial_club (
    cod_trabajador         NUMBER(8) NOT NULL,
    id_club                NUMBER(5) NOT NULL,
    fecha_inicio           DATE NOT NULL,
    fecha_fin              DATE,
    jugador_cod_trabajador NUMBER(8) NOT NULL,
    club_futbol_id_club    NUMBER(5) NOT NULL
);

ALTER TABLE historial_club ADD CONSTRAINT historial_club_pk PRIMARY KEY ( cod_trabajador,
                                                                          id_club );

CREATE TABLE idioma (
    id_idioma     NUMBER(4) NOT NULL,
    nombre_idioma VARCHAR2(50) NOT NULL
);

ALTER TABLE idioma ADD CONSTRAINT idioma_pk PRIMARY KEY ( id_idioma );

CREATE TABLE jugador (
    cod_trabajador            NUMBER(8) NOT NULL,
    puesto                    VARCHAR2(40) NOT NULL,
    premios_acumulados        NUMBER(15) NOT NULL,
    año_fin                   NUMBER(4),
    id_escuela                NUMBER(5),
    id_asociacion             NUMBER(4) NOT NULL,
    trabajador_cod_trabajador NUMBER(8) NOT NULL,
    asociacion_id_asociacion  NUMBER(4) NOT NULL,
    escuela_futbol_id_escuela NUMBER(5) NOT NULL
);

CREATE UNIQUE INDEX jugador__idx ON
    jugador (
        trabajador_cod_trabajador
    ASC );

ALTER TABLE jugador ADD CONSTRAINT jugador_pk PRIMARY KEY ( cod_trabajador );

CREATE TABLE jugador_idioma (
    cod_trabajador         NUMBER(8) NOT NULL,
    id_idioma              NUMBER(4) NOT NULL,
    nivel_dominio          VARCHAR2(30) NOT NULL,
    jugador_cod_trabajador NUMBER(8) NOT NULL,
    idioma_id_idioma       NUMBER(4) NOT NULL
);

ALTER TABLE jugador_idioma ADD CONSTRAINT jugador_idioma_pk PRIMARY KEY ( cod_trabajador,
                                                                          id_idioma );

CREATE TABLE nacionalidad (
    id_nacion   NUMBER(3) NOT NULL,
    descripcion VARCHAR2(50) NOT NULL
);

ALTER TABLE nacionalidad ADD CONSTRAINT nacionalidad_pk PRIMARY KEY ( id_nacion );

CREATE TABLE personal_planta (
    cod_trabajador            NUMBER(8) NOT NULL,
    horas_trabajadas          NUMBER(7),
    valor_horaextra           NUMBER(10),
    trabajador_cod_trabajador NUMBER(8) NOT NULL
);

CREATE UNIQUE INDEX personal_planta__idx ON
    personal_planta (
        trabajador_cod_trabajador
    ASC );

ALTER TABLE personal_planta ADD CONSTRAINT personal_planta_pk PRIMARY KEY ( cod_trabajador );

CREATE TABLE region (
    id_region NUMBER(3) NOT NULL,
    nombre    VARCHAR2(80) NOT NULL
);

ALTER TABLE region ADD CONSTRAINT region_pk PRIMARY KEY ( id_region );

CREATE TABLE trabajador (
    cod_trabajador         NUMBER(8) NOT NULL,
    rut                    VARCHAR2(12) NOT NULL,
    nombres                VARCHAR2(100) NOT NULL,
    dv                     VARCHAR2(1) NOT NULL,
    apellidos              VARCHAR2(100) NOT NULL,
    sueldo_base            NUMBER(12) NOT NULL,
    fecha_nacimiento       DATE NOT NULL,
    genero                 VARCHAR2(20) NOT NULL,
    estado_civil           VARCHAR2(20) NOT NULL,
    telefono_movil         VARCHAR2(20),
    direccion              VARCHAR2(150) NOT NULL,
    id_comuna              NUMBER(4) NOT NULL,
    id_nacion              NUMBER(3) NOT NULL,
    comuna_id_comuna       NUMBER(4) NOT NULL,
    nacionalidad_id_nacion NUMBER(3) NOT NULL
);

ALTER TABLE trabajador ADD CONSTRAINT trabajador_pk PRIMARY KEY ( cod_trabajador );

ALTER TABLE comuna
    ADD CONSTRAINT comuna_region_fk FOREIGN KEY ( region_id_region )
        REFERENCES region ( id_region );

ALTER TABLE historial_club
    ADD CONSTRAINT historial_club_club_futbol_fk FOREIGN KEY ( club_futbol_id_club )
        REFERENCES club_futbol ( id_club );

ALTER TABLE historial_club
    ADD CONSTRAINT historial_club_jugador_fk FOREIGN KEY ( jugador_cod_trabajador )
        REFERENCES jugador ( cod_trabajador );

ALTER TABLE jugador
    ADD CONSTRAINT jugador_asociacion_fk FOREIGN KEY ( asociacion_id_asociacion )
        REFERENCES asociacion ( id_asociacion );

ALTER TABLE jugador
    ADD CONSTRAINT jugador_escuela_futbol_fk FOREIGN KEY ( escuela_futbol_id_escuela )
        REFERENCES escuela_futbol ( id_escuela );

ALTER TABLE jugador_idioma
    ADD CONSTRAINT jugador_idioma_idioma_fk FOREIGN KEY ( idioma_id_idioma )
        REFERENCES idioma ( id_idioma );

ALTER TABLE jugador_idioma
    ADD CONSTRAINT jugador_idioma_jugador_fk FOREIGN KEY ( jugador_cod_trabajador )
        REFERENCES jugador ( cod_trabajador );

ALTER TABLE jugador
    ADD CONSTRAINT jugador_trabajador_fk FOREIGN KEY ( trabajador_cod_trabajador )
        REFERENCES trabajador ( cod_trabajador );

ALTER TABLE personal_planta
    ADD CONSTRAINT personal_planta_trabajador_fk FOREIGN KEY ( trabajador_cod_trabajador )
        REFERENCES trabajador ( cod_trabajador );

ALTER TABLE trabajador
    ADD CONSTRAINT trabajador_comuna_fk FOREIGN KEY ( comuna_id_comuna )
        REFERENCES comuna ( id_comuna );

ALTER TABLE trabajador
    ADD CONSTRAINT trabajador_nacionalidad_fk FOREIGN KEY ( nacionalidad_id_nacion )
        REFERENCES nacionalidad ( id_nacion );



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            12
-- CREATE INDEX                             2
-- ALTER TABLE                             23
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
