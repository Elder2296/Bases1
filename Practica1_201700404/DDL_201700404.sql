
-- Generado por Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   en:        2023-08-25 11:06:08 CST
--   sitio:      Oracle Database 21c
--   tipo:      Oracle Database 21c



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE biblioteca (
    ponderacion               INTEGER,
    fecha_ponderacion         DATE,
    detalle_compra_detalle_id INTEGER NOT NULL
);

COMMENT ON COLUMN biblioteca.ponderacion IS
    'ponderacion entre 1-5';

COMMENT ON COLUMN biblioteca.fecha_ponderacion IS
    'guarda la fecha que se le dio una ponderacion el usuario';

CREATE UNIQUE INDEX biblioteca__idx ON
    biblioteca (
        detalle_compra_detalle_id
    ASC );

CREATE TABLE clasificacion (
    clasificacion_id INTEGER NOT NULL,
    descripcion      VARCHAR2(200) NOT NULL,
    edad_minima      INTEGER NOT NULL,
    edad_maxima      INTEGER NOT NULL
);

COMMENT ON COLUMN clasificacion.clasificacion_id IS
    'identificador unico de la clasificacion';

COMMENT ON COLUMN clasificacion.descripcion IS
    'describira a detalle la clasificacion';

COMMENT ON COLUMN clasificacion.edad_minima IS
    'edad minima de la clasificacion';

COMMENT ON COLUMN clasificacion.edad_maxima IS
    'describira la edad maxima de la clasificacion';

ALTER TABLE clasificacion ADD CONSTRAINT clasificacion_pk PRIMARY KEY ( clasificacion_id );

CREATE TABLE compra (
    compra_id           INTEGER NOT NULL,
    fecha               DATE NOT NULL,
    total               NUMBER NOT NULL,
    tipo_pago_tipo_pago INTEGER NOT NULL,
    usuario_usuario_id  INTEGER NOT NULL
);

COMMENT ON COLUMN compra.compra_id IS
    'identificador unico';

COMMENT ON COLUMN compra.fecha IS
    'fecha y hora de la compra';

COMMENT ON COLUMN compra.total IS
    'el total de la compra con su descuento incluido';

ALTER TABLE compra ADD CONSTRAINT compra_pk PRIMARY KEY ( compra_id );

CREATE TABLE contrasenia (
    contrasenia_id     INTEGER NOT NULL,
    pass               VARCHAR2(256) NOT NULL,
    fecha_creacion     DATE NOT NULL,
    usuario_usuario_id INTEGER NOT NULL
);

COMMENT ON COLUMN contrasenia.contrasenia_id IS
    'identificador unico';

COMMENT ON COLUMN contrasenia.pass IS
    'contrasenia de usuario encryptada';

COMMENT ON COLUMN contrasenia.fecha_creacion IS
    'manejara la fecha y hora de la creacion de la contrasenia';

ALTER TABLE contrasenia ADD CONSTRAINT contrasenia_pk PRIMARY KEY ( contrasenia_id );

CREATE TABLE creador (
    desarrollador_desarrollador_id INTEGER NOT NULL,
    juego_juego_id                 INTEGER NOT NULL
);

CREATE TABLE desarrollador (
    desarrollador_id INTEGER NOT NULL,
    nombres          VARCHAR2(100) NOT NULL,
    apellidos        VARCHAR2(100) NOT NULL,
    alias            VARCHAR2(50) NOT NULL
);

COMMENT ON COLUMN desarrollador.desarrollador_id IS
    'identificador unico';

COMMENT ON COLUMN desarrollador.nombres IS
    'Nombres del desarrollador';

COMMENT ON COLUMN desarrollador.apellidos IS
    'apellidos del desarrollador';

COMMENT ON COLUMN desarrollador.alias IS
    'Alias del desarrollador';

ALTER TABLE desarrollador ADD CONSTRAINT desarrollador_pk PRIMARY KEY ( desarrollador_id );

CREATE TABLE detalle_compra (
    detalle_id           INTEGER NOT NULL,
    precio_con_descuento NUMBER NOT NULL,
    compra_compra_id     INTEGER NOT NULL,
    juego_juego_id       INTEGER NOT NULL
);

COMMENT ON COLUMN detalle_compra.detalle_id IS
    'identificador unico';

COMMENT ON COLUMN detalle_compra.precio_con_descuento IS
    'muestra el precio, con el descuento aplicado.';

ALTER TABLE detalle_compra ADD CONSTRAINT detalle_compra_pk PRIMARY KEY ( detalle_id );

CREATE TABLE genero_juego (
    genero_id          INTEGER NOT NULL,
    genero_descripcion VARCHAR2(200) NOT NULL
);

COMMENT ON COLUMN genero_juego.genero_id IS
    'identificador unico';

COMMENT ON COLUMN genero_juego.genero_descripcion IS
    'describrira el genero del juego';

ALTER TABLE genero_juego ADD CONSTRAINT genero_juego_pk PRIMARY KEY ( genero_id );

CREATE TABLE historial_tarjeta_uso (
    compra_compra_id   INTEGER NOT NULL,
    tarjeta_tarjeta_id INTEGER NOT NULL
);

CREATE UNIQUE INDEX historial_tarjeta_uso__idx ON
    historial_tarjeta_uso (
        compra_compra_id
    ASC );

CREATE TABLE juego (
    juego_id                       INTEGER NOT NULL,
    descripcion_corta              VARCHAR2(50) NOT NULL,
    descripcion_larga              VARCHAR2(200) NOT NULL,
    fecha_lanzamiento              DATE NOT NULL,
    precio_original                NUMBER,
    precio_actual                  NUMBER NOT NULL,
    genero_juego_genero_id         INTEGER NOT NULL,
    clasificacion_clasificacion_id INTEGER NOT NULL
);

COMMENT ON COLUMN juego.juego_id IS
    'identificador unico del juego';

COMMENT ON COLUMN juego.descripcion_corta IS
    'hará referencia a una descripcion corta';

COMMENT ON COLUMN juego.descripcion_larga IS
    'describirá de una manera mas detalla el juego.';

COMMENT ON COLUMN juego.fecha_lanzamiento IS
    'Describira la fecha del lanzamiento del juego';

COMMENT ON COLUMN juego.precio_original IS
    'Mantendra el precio original o de inicio del juego';

COMMENT ON COLUMN juego.precio_actual IS
    'manejara el precio actual del producto';

ALTER TABLE juego ADD CONSTRAINT juego_pk PRIMARY KEY ( juego_id );

CREATE TABLE lista_deseos (
    fecha_aniadido     DATE NOT NULL,
    estado             CHAR(1) NOT NULL,
    juego_juego_id     INTEGER NOT NULL,
    usuario_usuario_id INTEGER NOT NULL
);

COMMENT ON COLUMN lista_deseos.fecha_aniadido IS
    'fecha que se aniado a la lista de deseos';

COMMENT ON COLUMN lista_deseos.estado IS
    'estado T= true(ya ha sido comprado), F=false(pendiente de compra)';

CREATE TABLE pais (
    pais_id   INTEGER NOT NULL,
    nombre    VARCHAR2(100) NOT NULL,
    extencion VARCHAR2(10) NOT NULL
);

COMMENT ON COLUMN pais.pais_id IS
    'identificador unico';

COMMENT ON COLUMN pais.nombre IS
    'nombre del pais';

COMMENT ON COLUMN pais.extencion IS
    'extencion telefonica';

ALTER TABLE pais ADD CONSTRAINT pais_pk PRIMARY KEY ( pais_id );

CREATE TABLE politica_disponibilidad (
    pais_pais_id   INTEGER NOT NULL,
    juego_juego_id INTEGER NOT NULL
);

CREATE TABLE promocion (
    promocion_id    INTEGER,
    fecha_inicio    DATE NOT NULL,
    fecha_fin       DATE NOT NULL,
    porcentaje      NUMBER(2),
    estado_vigencia CHAR(1),
    descripcion     VARCHAR2(200),
    juego_juego_id  INTEGER NOT NULL
);

COMMENT ON COLUMN promocion.promocion_id IS
    'identificador unico';

COMMENT ON COLUMN promocion.fecha_inicio IS
    'fecha inicio de la vigencia';

COMMENT ON COLUMN promocion.fecha_fin IS
    'fecha del fin de la vigencia.';

COMMENT ON COLUMN promocion.porcentaje IS
    'porcentaje de las promociones';

COMMENT ON COLUMN promocion.estado_vigencia IS
    'T= true(vigente), F= false(caducado)';

COMMENT ON COLUMN promocion.descripcion IS
    'breve descripion de la promocion';

CREATE TABLE rol (
    rol_id          INTEGER NOT NULL,
    descripcion_rol INTEGER NOT NULL
);

COMMENT ON COLUMN rol.rol_id IS
    'identificador unico';

COMMENT ON COLUMN rol.descripcion_rol IS
    'describira las funciones de los roles';

ALTER TABLE rol ADD CONSTRAINT rol_pk PRIMARY KEY ( rol_id );

CREATE TABLE tarjeta (
    tarjeta_id         INTEGER NOT NULL,
    propietario        VARCHAR2(150) NOT NULL,
    numero             VARCHAR2(19) NOT NULL,
    fecha_vencimiento  DATE NOT NULL,
    usuario_usuario_id INTEGER NOT NULL
);

COMMENT ON COLUMN tarjeta.tarjeta_id IS
    'identificador unico';

COMMENT ON COLUMN tarjeta.propietario IS
    'propietario de la tarjeta';

COMMENT ON COLUMN tarjeta.numero IS
    'numero de la tarjeta';

COMMENT ON COLUMN tarjeta.fecha_vencimiento IS
    'fecha vencimiento de la tarjeta';

ALTER TABLE tarjeta ADD CONSTRAINT tarjeta_pk PRIMARY KEY ( tarjeta_id );

CREATE TABLE tipo_pago (
    tipo_pago   INTEGER NOT NULL,
    descripcion VARCHAR2(150) NOT NULL
);

COMMENT ON COLUMN tipo_pago.tipo_pago IS
    'identificador unico';

COMMENT ON COLUMN tipo_pago.descripcion IS
    'breve descripcion del pago';

ALTER TABLE tipo_pago ADD CONSTRAINT tipo_pago_pk PRIMARY KEY ( tipo_pago );

CREATE TABLE usuario (
    usuario_id       INTEGER NOT NULL,
    nombres          VARCHAR2(50) NOT NULL,
    apellidos        VARCHAR2(50) NOT NULL,
    alias            VARCHAR2(50) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    correo_elec      VARCHAR2(100) NOT NULL,
    telefono         VARCHAR2(30) NOT NULL,
    direccion        VARCHAR2(200),
    pais_pais_id     INTEGER NOT NULL,
    rol_rol_id       INTEGER NOT NULL
);

COMMENT ON COLUMN usuario.usuario_id IS
    'identificador unico';

COMMENT ON COLUMN usuario.nombres IS
    'nombres del usuario';

COMMENT ON COLUMN usuario.apellidos IS
    'apellidos del usuario';

COMMENT ON COLUMN usuario.alias IS
    'alias del usuario';

COMMENT ON COLUMN usuario.fecha_nacimiento IS
    'fecha nacimiento del usuario';

COMMENT ON COLUMN usuario.correo_elec IS
    'correo electronico del usuario';

COMMENT ON COLUMN usuario.telefono IS
    'telefono del usuario';

COMMENT ON COLUMN usuario.direccion IS
    'direccion del usuario';

ALTER TABLE usuario ADD CONSTRAINT usuario_pk PRIMARY KEY ( usuario_id );

ALTER TABLE biblioteca
    ADD CONSTRAINT biblioteca_detalle_compra_fk FOREIGN KEY ( detalle_compra_detalle_id )
        REFERENCES detalle_compra ( detalle_id );

ALTER TABLE compra
    ADD CONSTRAINT compra_tipo_pago_fk FOREIGN KEY ( tipo_pago_tipo_pago )
        REFERENCES tipo_pago ( tipo_pago );

ALTER TABLE compra
    ADD CONSTRAINT compra_usuario_fk FOREIGN KEY ( usuario_usuario_id )
        REFERENCES usuario ( usuario_id );

ALTER TABLE contrasenia
    ADD CONSTRAINT contrasenia_usuario_fk FOREIGN KEY ( usuario_usuario_id )
        REFERENCES usuario ( usuario_id );

ALTER TABLE creador
    ADD CONSTRAINT creador_desarrollador_fk FOREIGN KEY ( desarrollador_desarrollador_id )
        REFERENCES desarrollador ( desarrollador_id );

ALTER TABLE creador
    ADD CONSTRAINT creador_juego_fk FOREIGN KEY ( juego_juego_id )
        REFERENCES juego ( juego_id );

ALTER TABLE detalle_compra
    ADD CONSTRAINT detalle_compra_compra_fk FOREIGN KEY ( compra_compra_id )
        REFERENCES compra ( compra_id );

ALTER TABLE detalle_compra
    ADD CONSTRAINT detalle_compra_juego_fk FOREIGN KEY ( juego_juego_id )
        REFERENCES juego ( juego_id );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE historial_tarjeta_uso
    ADD CONSTRAINT historial_tarjeta_uso_compra_fk FOREIGN KEY ( compra_compra_id )
        REFERENCES compra ( compra_id );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE historial_tarjeta_uso
    ADD CONSTRAINT historial_tarjeta_uso_tarjeta_fk FOREIGN KEY ( tarjeta_tarjeta_id )
        REFERENCES tarjeta ( tarjeta_id );

ALTER TABLE juego
    ADD CONSTRAINT juego_clasificacion_fk FOREIGN KEY ( clasificacion_clasificacion_id )
        REFERENCES clasificacion ( clasificacion_id );

ALTER TABLE juego
    ADD CONSTRAINT juego_genero_juego_fk FOREIGN KEY ( genero_juego_genero_id )
        REFERENCES genero_juego ( genero_id );

ALTER TABLE lista_deseos
    ADD CONSTRAINT lista_deseos_juego_fk FOREIGN KEY ( juego_juego_id )
        REFERENCES juego ( juego_id );

ALTER TABLE lista_deseos
    ADD CONSTRAINT lista_deseos_usuario_fk FOREIGN KEY ( usuario_usuario_id )
        REFERENCES usuario ( usuario_id );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE politica_disponibilidad
    ADD CONSTRAINT politica_disponibilidad_juego_fk FOREIGN KEY ( juego_juego_id )
        REFERENCES juego ( juego_id );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE politica_disponibilidad
    ADD CONSTRAINT politica_disponibilidad_pais_fk FOREIGN KEY ( pais_pais_id )
        REFERENCES pais ( pais_id );

ALTER TABLE promocion
    ADD CONSTRAINT promocion_juego_fk FOREIGN KEY ( juego_juego_id )
        REFERENCES juego ( juego_id );

ALTER TABLE tarjeta
    ADD CONSTRAINT tarjeta_usuario_fk FOREIGN KEY ( usuario_usuario_id )
        REFERENCES usuario ( usuario_id );

ALTER TABLE usuario
    ADD CONSTRAINT usuario_pais_fk FOREIGN KEY ( pais_pais_id )
        REFERENCES pais ( pais_id );

ALTER TABLE usuario
    ADD CONSTRAINT usuario_rol_fk FOREIGN KEY ( rol_rol_id )
        REFERENCES rol ( rol_id );



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            18
-- CREATE INDEX                             2
-- ALTER TABLE                             32
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
-- ERRORS                                   4
-- WARNINGS                                 0
