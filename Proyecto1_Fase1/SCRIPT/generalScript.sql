-- Generado por Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   en:        2023-09-15 23:19:17 CST
--   sitio:      Oracle Database 21c
--   tipo:      Oracle Database 21c



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE banco (
    banco_id INTEGER NOT NULL,
    nombre   VARCHAR2(50) NOT NULL
);

COMMENT ON TABLE banco IS
    'entidad que almacena la informacion d losl bancos';

COMMENT ON COLUMN banco.banco_id IS
    'Codigo unico del banco';

COMMENT ON COLUMN banco.nombre IS
    'Nombre del banco';

ALTER TABLE banco ADD CONSTRAINT banco_pk PRIMARY KEY ( banco_id );

CREATE TABLE categoria (
    categoria_id INTEGER NOT NULL,
    nombre       VARCHAR2(50) NOT NULL,
    descripcion  VARCHAR2(200) NOT NULL
);

COMMENT ON TABLE categoria IS
    'Esta endidad almacena las categorias de productos disponibles para las tiendas';

COMMENT ON COLUMN categoria.categoria_id IS
    'identificador unico';

COMMENT ON COLUMN categoria.nombre IS
    'Nombre de la categoria';

COMMENT ON COLUMN categoria.descripcion IS
    'breve descripcion de la categoria.';

ALTER TABLE categoria ADD CONSTRAINT categoria_pk PRIMARY KEY ( categoria_id );

CREATE TABLE clasificacion (
    producto_sku           INTEGER NOT NULL,
    categoria_categoria_id INTEGER NOT NULL
);

COMMENT ON TABLE clasificacion IS
    'entidad que almacena la clasificacion entre  productos y categorias';

COMMENT ON COLUMN clasificacion.producto_sku IS
    'campo que relaciona un producto con una categoria';

COMMENT ON COLUMN clasificacion.categoria_categoria_id IS
    'campo que relaciona una  una categoria con un producto';

CREATE TABLE client (
    cliente_id    INTEGER NOT NULL,
    nit           VARCHAR2(20 CHAR) NOT NULL,
    nombre        VARCHAR2(100 CHAR) NOT NULL,
    apellidos     VARCHAR2(100) NOT NULL,
    direccion     VARCHAR2(50 CHAR),
    telfono       VARCHAR2(25 CHAR),
    pais_id_pais  INTEGER NOT NULL,
    genero_id_gen INTEGER NOT NULL
);

COMMENT ON TABLE client IS
    'Almacena la informacion de registro del cleinte';

COMMENT ON COLUMN client.cliente_id IS
    'codigo unico';

COMMENT ON COLUMN client.nit IS
    'numero de identificacion tributario';

COMMENT ON COLUMN client.nombre IS
    'almacena el nombre del cliente';

COMMENT ON COLUMN client.apellidos IS
    'apellidos del cliente';

COMMENT ON COLUMN client.direccion IS
    'campo que almacena la direccion del cliente';

COMMENT ON COLUMN client.telfono IS
    'almacena telefono de contacto del cliente';

COMMENT ON COLUMN client.pais_id_pais IS
    'almacena el id del pais del cliente';

COMMENT ON COLUMN client.genero_id_gen IS
    'almacena el id del genero del cliente';

ALTER TABLE client ADD CONSTRAINT client_pk PRIMARY KEY ( cliente_id );

CREATE TABLE ctabanco (
    client_cliente_id INTEGER NOT NULL,
    numero_cta        VARCHAR2(50) NOT NULL,
    nombre_cta        VARCHAR2(100) NOT NULL,
    banco_banco_id    INTEGER NOT NULL
);

COMMENT ON TABLE ctabanco IS
    'es la entidad que almacena la relacion entre cliente y banco que emite las cuentas ';

COMMENT ON COLUMN ctabanco.client_cliente_id IS
    'campo que relaciona el cliente con el banco y cuenta';

COMMENT ON COLUMN ctabanco.numero_cta IS
    'campo que relaciona el cliente con el banco y cuenta';

COMMENT ON COLUMN ctabanco.nombre_cta IS
    'campo que relaciona el cliente con el banco y cuenta';

COMMENT ON COLUMN ctabanco.banco_banco_id IS
    'campo que relaciona el cliente con el banco y cuenta';

CREATE TABLE delivery (
    entrega_id           INTEGER NOT NULL,
    venta_venta_id       INTEGER,
    fecha_entrega        DATE NOT NULL,
    empleado_empleado_id INTEGER NOT NULL
);

COMMENT ON TABLE delivery IS
    'esta entidad almacenara la informacion de las entregas, tales como el pedido, quien entrega';

COMMENT ON COLUMN delivery.entrega_id IS
    'identificador unico';

COMMENT ON COLUMN delivery.venta_venta_id IS
    'clave de la venta a repartir';

COMMENT ON COLUMN delivery.fecha_entrega IS
    'fecha de entrega estimada';

COMMENT ON COLUMN delivery.empleado_empleado_id IS
    'campo que almacena el identificador del empleado que realiza el reparto';

CREATE UNIQUE INDEX delivery__idx ON
    delivery (
        venta_venta_id
    ASC );

ALTER TABLE delivery ADD CONSTRAINT delivery_pk PRIMARY KEY ( entrega_id );

CREATE TABLE detalle (
    id_detalle     INTEGER NOT NULL,
    venta_venta_id INTEGER NOT NULL,
    producto_sku   INTEGER NOT NULL,
    cantidad       INTEGER NOT NULL,
    costo          NUMBER(20, 5) NOT NULL
);

ALTER TABLE detalle ADD CHECK ( costo > 0 );

COMMENT ON TABLE detalle IS
    'Entidad que almacena el detalle de las ventas';

COMMENT ON COLUMN detalle.id_detalle IS
    'identificador del detalle';

COMMENT ON COLUMN detalle.venta_venta_id IS
    'campo que almacena el id de la venta a la que se asocia el detalle';

COMMENT ON COLUMN detalle.producto_sku IS
    'campo que almacena el codigo del producto';

COMMENT ON COLUMN detalle.cantidad IS
    'campo que almacena la cantidad de productos comprados';

COMMENT ON COLUMN detalle.costo IS
    'cantidad*precio unitario*tasa de cambio';

ALTER TABLE detalle ADD CONSTRAINT detalle_pk PRIMARY KEY ( id_detalle );

CREATE TABLE empleado (
    tienda_id_st INTEGER NOT NULL,
    empleado_id  INTEGER NOT NULL,
    nombre       VARCHAR2(150) NOT NULL,
    apellidos    VARCHAR2(150) NOT NULL,
    rol_rol_id   INTEGER NOT NULL
);

COMMENT ON TABLE empleado IS
    'Esta entidad almacena la información del empleado';

COMMENT ON COLUMN empleado.tienda_id_st IS
    'este campo almacena la informacion de la clave foranea de la tienda a la que pertence el empleado';

COMMENT ON COLUMN empleado.empleado_id IS
    'identificador unico de empleado';

COMMENT ON COLUMN empleado.nombre IS
    'Nombre del empleado';

COMMENT ON COLUMN empleado.apellidos IS
    'Apellidos del empleado';

COMMENT ON COLUMN empleado.rol_rol_id IS
    'clave foranea del rol del empleado';

ALTER TABLE empleado ADD CONSTRAINT empleado_pk PRIMARY KEY ( empleado_id );

CREATE TABLE factura (
    num_fact                   INTEGER NOT NULL,
    total                      NUMBER(20, 10) NOT NULL,
    fecha_compra               DATE,
    id_client                  INTEGER NOT NULL,
    direccion                  VARCHAR2(25 CHAR),
    metodo_pago_metodo_pago_id INTEGER NOT NULL,
    venta_venta_id             INTEGER NOT NULL,
    costo_envio                NUMBER(15, 10) NOT NULL
);

ALTER TABLE factura ADD CHECK ( total > 0 );

ALTER TABLE factura ADD CHECK ( costo_envio > 0 );

COMMENT ON TABLE factura IS
    'Entidad que almacena datos de las facturas';

COMMENT ON COLUMN factura.num_fact IS
    'campo que almacena el numero de factura el cual es el PK de la entidad';

COMMENT ON COLUMN factura.total IS
    'Suma total de los detalles + el costo de envio';

COMMENT ON COLUMN factura.fecha_compra IS
    'almacena la fecha de factuación';

COMMENT ON COLUMN factura.id_client IS
    'almacena el campo id_cliente que relaciona la factura con el cliente';

COMMENT ON COLUMN factura.direccion IS
    'almacena la dirección fiscal del cliente';

COMMENT ON COLUMN factura.metodo_pago_metodo_pago_id IS
    'almacena el metodo de pago seleccionado por el cliente';

COMMENT ON COLUMN factura.venta_venta_id IS
    'almacena el campo que relaciona la factura con la venta';

COMMENT ON COLUMN factura.costo_envio IS
    'Define el costo del envió, si el valor es 0, es porque es compra directa en tienda, si es diferente, es con servicio a domicilio'
    ;

CREATE UNIQUE INDEX factura__idx ON
    factura (
        venta_venta_id
    ASC );

ALTER TABLE factura ADD CONSTRAINT factura_pk PRIMARY KEY ( num_fact );

CREATE TABLE genero (
    id_gen INTEGER NOT NULL,
    genero VARCHAR2(20 CHAR) NOT NULL
);

COMMENT ON TABLE genero IS
    'Almacena informacion de los generos para el registro del cliente';

COMMENT ON COLUMN genero.id_gen IS
    'almacena el id del genero a registrar';

COMMENT ON COLUMN genero.genero IS
    'almacena la descripcion del genero';

ALTER TABLE genero ADD CONSTRAINT genero_pk PRIMARY KEY ( id_gen );

CREATE TABLE htransaccion (
    historico_id                INTEGER NOT NULL,
    fecha_transaccion           DATE NOT NULL,
    cantidad                    INTEGER NOT NULL,
    tienda_id_st                INTEGER NOT NULL,
    producto_sku                INTEGER NOT NULL,
    notacredito_nota_credito_id INTEGER,
    venta_venta_id              INTEGER,
    pedido_pedido_id            INTEGER
);

COMMENT ON TABLE htransaccion IS
    'Esta entidad alamacena el historico de las transacciones de la tienda';

COMMENT ON COLUMN htransaccion.historico_id IS
    'Codigo unico del historico';

COMMENT ON COLUMN htransaccion.fecha_transaccion IS
    'lleva el registro de la fecha de la transaccion';

COMMENT ON COLUMN htransaccion.cantidad IS
    'Cantidad del producto en la transaccion';

COMMENT ON COLUMN htransaccion.tienda_id_st IS
    'contiende el identificador de la tienda que realiza la transacción';

COMMENT ON COLUMN htransaccion.producto_sku IS
    'contiene el campo del producto con el que se efectua la transacción';

COMMENT ON COLUMN htransaccion.notacredito_nota_credito_id IS
    'campo que relaciona la nota de credito a la que pertenece la transacción';

COMMENT ON COLUMN htransaccion.venta_venta_id IS
    'campo que relaciona la nota de venta  a la que pertenece la transacción';

COMMENT ON COLUMN htransaccion.pedido_pedido_id IS
    'campo que relaciona un pedido  a la que pertenece la transacción';

ALTER TABLE htransaccion ADD CONSTRAINT historico_transaccion_pk PRIMARY KEY ( historico_id );

CREATE TABLE inventario (
    producto_sku   INTEGER NOT NULL,
    tienda_id_st   INTEGER NOT NULL,
    disponibilidad INTEGER NOT NULL
);

COMMENT ON COLUMN inventario.producto_sku IS
    'es el identficador unico del producto ';

COMMENT ON COLUMN inventario.tienda_id_st IS
    'es el identificador de la tienda a la que pertenece ';

COMMENT ON COLUMN inventario.disponibilidad IS
    'lleva la cantidad existente en unidades de ese producto.';

CREATE TABLE midireccion (
    direccion_id      INTEGER NOT NULL,
    direccion         VARCHAR2(400) NOT NULL,
    client_cliente_id INTEGER NOT NULL
);

COMMENT ON TABLE midireccion IS
    'esta entidad almacenara las direcciones del cliente';

COMMENT ON COLUMN midireccion.direccion_id IS
    'CODIGO UNICO DE DIRECCION';

COMMENT ON COLUMN midireccion.direccion IS
    'direccion de entrega';

COMMENT ON COLUMN midireccion.client_cliente_id IS
    'campo que identifica a que cliente corresponde cada dirección';

ALTER TABLE midireccion ADD CONSTRAINT midireccion_pk PRIMARY KEY ( direccion_id );

CREATE TABLE ncredito (
    nota_credito_id  INTEGER NOT NULL,
    fecha            DATE NOT NULL,
    factura_num_fact INTEGER
);

COMMENT ON TABLE ncredito IS
    'lleva la lista de notas de credito';

COMMENT ON COLUMN ncredito.nota_credito_id IS
    'codigo unico de la nota de credito';

COMMENT ON COLUMN ncredito.fecha IS
    'Fecha en que se realizó la nota de credito';

COMMENT ON COLUMN ncredito.factura_num_fact IS
    'campo que relaciona la factura con la nota de credito';

CREATE UNIQUE INDEX notacredito__idx ON
    ncredito (
        factura_num_fact
    ASC );

ALTER TABLE ncredito ADD CONSTRAINT notacredito_pk PRIMARY KEY ( nota_credito_id );

CREATE TABLE pais (
    id_pais INTEGER NOT NULL,
    pais    VARCHAR2(25 CHAR),
    divisa  NUMBER(15, 10) NOT NULL
);

ALTER TABLE pais ADD CONSTRAINT checkdivis CHECK ( divisa > 0 );

COMMENT ON TABLE pais IS
    'Entidad que almacena infromacion de los paises y tasas de cambio';

COMMENT ON COLUMN pais.id_pais IS
    'identificador del pais';

COMMENT ON COLUMN pais.pais IS
    'nombre del pais';

COMMENT ON COLUMN pais.divisa IS
    'Tipo de cambio del pais a comparación del dolar';

ALTER TABLE pais ADD CONSTRAINT pais_pk PRIMARY KEY ( id_pais );

CREATE TABLE pedido (
    pedido_id              INTEGER NOT NULL,
    proveedor_proveedor_id INTEGER NOT NULL
);

COMMENT ON TABLE pedido IS
    'Esta tabla contendrá la informacion de los pedidos que se realizan a un proveedor
';

COMMENT ON COLUMN pedido.pedido_id IS
    'identificador unico del pedido';

CREATE UNIQUE INDEX pedido__idx ON
    pedido (
        proveedor_proveedor_id
    ASC );

ALTER TABLE pedido ADD CONSTRAINT pedido_pk PRIMARY KEY ( pedido_id );

CREATE TABLE producto (
    sku         INTEGER NOT NULL,
    descripcion VARCHAR2(200) NOT NULL,
    precio      NUMBER(11, 2)
);

ALTER TABLE producto ADD CHECK ( precio > 0 );

COMMENT ON COLUMN producto.sku IS
    'clave unica';

ALTER TABLE producto ADD CONSTRAINT producto_pk PRIMARY KEY ( sku );

CREATE TABLE proveedor (
    proveedor_id    INTEGER NOT NULL,
    razon_social    VARCHAR2(150) NOT NULL,
    direccion       VARCHAR2(200) NOT NULL,
    telefono        VARCHAR2(20),
    email           VARCHAR2(150),
    nombre_contacto VARCHAR2(150) NOT NULL,
    pedido_id       INTEGER NOT NULL
);

COMMENT ON TABLE proveedor IS
    'Esta tabla almacena la información de los proveedores';

COMMENT ON COLUMN proveedor.proveedor_id IS
    'identificacion unica del proveedor';

COMMENT ON COLUMN proveedor.razon_social IS
    'Nombre de la empresa que distribuye';

COMMENT ON COLUMN proveedor.direccion IS
    'Direccion de las oficinas';

COMMENT ON COLUMN proveedor.telefono IS
    'Email de contacto con el proveedor';

COMMENT ON COLUMN proveedor.email IS
    'Email de contacto con el proveedor';

COMMENT ON COLUMN proveedor.nombre_contacto IS
    'NOMBRE DEL EJECUTIVO DE VENTAS';

ALTER TABLE proveedor ADD CONSTRAINT proveedor_pk PRIMARY KEY ( proveedor_id );

CREATE TABLE region (
    region_id    INTEGER NOT NULL,
    nombre       VARCHAR2(200) NOT NULL,
    tarifa       NUMBER(15, 10) NOT NULL,
    tienda_id_st INTEGER NOT NULL
);

ALTER TABLE region ADD CHECK ( tarifa > 0 );

COMMENT ON COLUMN region.region_id IS
    'codigo unico';

COMMENT ON COLUMN region.nombre IS
    'Nombre de la region';

COMMENT ON COLUMN region.tarifa IS
    'monto de la tarifa';

ALTER TABLE region ADD CONSTRAINT region_pk PRIMARY KEY ( region_id );

CREATE TABLE rol (
    rol_id      INTEGER NOT NULL,
    descripcion VARCHAR2(100) NOT NULL
);

COMMENT ON TABLE rol IS
    'Esta entidad almacena informacion de los roles del empleado';

COMMENT ON COLUMN rol.rol_id IS
    'codigo unico del rol';

COMMENT ON COLUMN rol.descripcion IS
    'Describe el rol y sus funciones
';

ALTER TABLE rol ADD CONSTRAINT rol_pk PRIMARY KEY ( rol_id );

CREATE TABLE tarjeta (
    client_cliente_id INTEGER NOT NULL,
    numero            VARCHAR2(16) NOT NULL,
    nombre_tarjeta    VARCHAR2(50) NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    banco_banco_id    INTEGER NOT NULL
);

COMMENT ON TABLE tarjeta IS
    'Entidad que almacena las tarjetas de los clientes';

COMMENT ON COLUMN tarjeta.client_cliente_id IS
    'almacena el id del cliente que registra su tarjeta';

COMMENT ON COLUMN tarjeta.numero IS
    'almacena el numero de tarjeta del cliente';

COMMENT ON COLUMN tarjeta.nombre_tarjeta IS
    'Nombre del duenio de la tarjeta';

COMMENT ON COLUMN tarjeta.fecha_vencimiento IS
    'Fecha de vencimiento de la tarjeta';

COMMENT ON COLUMN tarjeta.banco_banco_id IS
    'id del banco que emite la tarjeta';

CREATE TABLE tienda (
    pais_id_pais INTEGER NOT NULL,
    id_st        INTEGER NOT NULL,
    nombre       VARCHAR2(150) NOT NULL,
    direccion    VARCHAR2(200) NOT NULL
);

COMMENT ON TABLE tienda IS
    'Esta entidad registra la informacion de las tiendas';

COMMENT ON COLUMN tienda.pais_id_pais IS
    'este campo almacena la clave foranea del país al qu pertenece la tienda ';

COMMENT ON COLUMN tienda.id_st IS
    'este campo almacena el identificador unico de la tienda';

COMMENT ON COLUMN tienda.nombre IS
    'describe el nombre de la tienda ';

COMMENT ON COLUMN tienda.direccion IS
    'descripcion de la direccion de la tienda';

ALTER TABLE tienda ADD CONSTRAINT tienda_pk PRIMARY KEY ( id_st );

CREATE TABLE tpago (
    metodo_pago_id   INTEGER NOT NULL,
    nombre_tipo_pago VARCHAR2(50) NOT NULL
);

COMMENT ON TABLE tpago IS
    'Lleva los metodos de pago, como pagos con tarjeta, depositos, efectivo.';

COMMENT ON COLUMN tpago.metodo_pago_id IS
    'identificador unico';

COMMENT ON COLUMN tpago.nombre_tipo_pago IS
    'Descripcion del metodo de pago';

ALTER TABLE tpago ADD CONSTRAINT metodo_pago_pk PRIMARY KEY ( metodo_pago_id );

CREATE TABLE venta (
    venta_id                 INTEGER NOT NULL,
    tienda_id_st             INTEGER NOT NULL,
    id_client                INTEGER NOT NULL,
    client_cliente_id        INTEGER NOT NULL,
    midireccion_direccion_id INTEGER NOT NULL
);

COMMENT ON TABLE venta IS
    'esta entidad almacenara datos de la venta';

COMMENT ON COLUMN venta.venta_id IS
    'clave unica de la venta';

COMMENT ON COLUMN venta.tienda_id_st IS
    'clave  de la tienda que reliza la venta';

COMMENT ON COLUMN venta.id_client IS
    'clave del cliente que realiza la compra';

COMMENT ON COLUMN venta.client_cliente_id IS
    'clave del cliente que realiza la compra';

COMMENT ON COLUMN venta.midireccion_direccion_id IS
    'direccion fiscal del cliente';

ALTER TABLE venta ADD CONSTRAINT venta_pk PRIMARY KEY ( venta_id );

ALTER TABLE clasificacion
    ADD CONSTRAINT clasificacion_categoria_fk FOREIGN KEY ( categoria_categoria_id )
        REFERENCES categoria ( categoria_id );

ALTER TABLE clasificacion
    ADD CONSTRAINT clasificacion_producto_fk FOREIGN KEY ( producto_sku )
        REFERENCES producto ( sku );

ALTER TABLE client
    ADD CONSTRAINT client_genero_fk FOREIGN KEY ( genero_id_gen )
        REFERENCES genero ( id_gen );

ALTER TABLE client
    ADD CONSTRAINT client_pais_fk FOREIGN KEY ( pais_id_pais )
        REFERENCES pais ( id_pais );

ALTER TABLE ctabanco
    ADD CONSTRAINT cuenta_banco_banco_fk FOREIGN KEY ( banco_banco_id )
        REFERENCES banco ( banco_id );

ALTER TABLE ctabanco
    ADD CONSTRAINT cuenta_banco_client_fk FOREIGN KEY ( client_cliente_id )
        REFERENCES client ( cliente_id );

ALTER TABLE delivery
    ADD CONSTRAINT delivery_empleado_fk FOREIGN KEY ( empleado_empleado_id )
        REFERENCES empleado ( empleado_id );

ALTER TABLE delivery
    ADD CONSTRAINT delivery_venta_fk FOREIGN KEY ( venta_venta_id )
        REFERENCES venta ( venta_id );

ALTER TABLE detalle
    ADD CONSTRAINT detalle_producto_fk FOREIGN KEY ( producto_sku )
        REFERENCES producto ( sku );

ALTER TABLE detalle
    ADD CONSTRAINT detalle_venta_fk FOREIGN KEY ( venta_venta_id )
        REFERENCES venta ( venta_id );

ALTER TABLE empleado
    ADD CONSTRAINT empleado_rol_fk FOREIGN KEY ( rol_rol_id )
        REFERENCES rol ( rol_id );

ALTER TABLE empleado
    ADD CONSTRAINT empleado_tienda_fk FOREIGN KEY ( tienda_id_st )
        REFERENCES tienda ( id_st );

ALTER TABLE factura
    ADD CONSTRAINT factura_metodo_pago_fk FOREIGN KEY ( metodo_pago_metodo_pago_id )
        REFERENCES tpago ( metodo_pago_id );

ALTER TABLE factura
    ADD CONSTRAINT factura_venta_fk FOREIGN KEY ( venta_venta_id )
        REFERENCES venta ( venta_id );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE htransaccion
    ADD CONSTRAINT historico_transaccion_notacredito_fk FOREIGN KEY ( notacredito_nota_credito_id )
        REFERENCES ncredito ( nota_credito_id );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE htransaccion
    ADD CONSTRAINT historico_transaccion_pedido_fk FOREIGN KEY ( pedido_pedido_id )
        REFERENCES pedido ( pedido_id );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE htransaccion
    ADD CONSTRAINT historico_transaccion_producto_fk FOREIGN KEY ( producto_sku )
        REFERENCES producto ( sku );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE htransaccion
    ADD CONSTRAINT historico_transaccion_tienda_fk FOREIGN KEY ( tienda_id_st )
        REFERENCES tienda ( id_st );

ALTER TABLE htransaccion
    ADD CONSTRAINT historico_transaccion_venta_fk FOREIGN KEY ( venta_venta_id )
        REFERENCES venta ( venta_id );

ALTER TABLE inventario
    ADD CONSTRAINT inventario_producto_fk FOREIGN KEY ( producto_sku )
        REFERENCES producto ( sku );

ALTER TABLE inventario
    ADD CONSTRAINT inventario_tienda_fk FOREIGN KEY ( tienda_id_st )
        REFERENCES tienda ( id_st );

ALTER TABLE midireccion
    ADD CONSTRAINT midireccion_client_fk FOREIGN KEY ( client_cliente_id )
        REFERENCES client ( cliente_id );

ALTER TABLE ncredito
    ADD CONSTRAINT notacredito_factura_fk FOREIGN KEY ( factura_num_fact )
        REFERENCES factura ( num_fact );

ALTER TABLE pedido
    ADD CONSTRAINT pedido_proveedor_fk FOREIGN KEY ( proveedor_proveedor_id )
        REFERENCES proveedor ( proveedor_id );

ALTER TABLE region
    ADD CONSTRAINT region_tienda_fk FOREIGN KEY ( tienda_id_st )
        REFERENCES tienda ( id_st );

ALTER TABLE tarjeta
    ADD CONSTRAINT tarjeta_banco_fk FOREIGN KEY ( banco_banco_id )
        REFERENCES banco ( banco_id );

ALTER TABLE tarjeta
    ADD CONSTRAINT tarjeta_client_fk FOREIGN KEY ( client_cliente_id )
        REFERENCES client ( cliente_id );

ALTER TABLE tienda
    ADD CONSTRAINT tienda_pais_fk FOREIGN KEY ( pais_id_pais )
        REFERENCES pais ( id_pais );

ALTER TABLE venta
    ADD CONSTRAINT venta_client_fk FOREIGN KEY ( client_cliente_id )
        REFERENCES client ( cliente_id );

ALTER TABLE venta
    ADD CONSTRAINT venta_midireccion_fk FOREIGN KEY ( midireccion_direccion_id )
        REFERENCES midireccion ( direccion_id );

ALTER TABLE venta
    ADD CONSTRAINT venta_tienda_fk FOREIGN KEY ( tienda_id_st )
        REFERENCES tienda ( id_st );



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            24
-- CREATE INDEX                             4
-- ALTER TABLE                             57
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

