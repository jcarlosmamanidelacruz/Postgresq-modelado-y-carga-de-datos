-- Schema: importaciones_db

-- DROP SCHEMA importaciones_db;

CREATE SCHEMA importaciones_db;

-- Table: importaciones_db.tablatemporal

-- DROP TABLE importaciones_db.tablatemporal;

CREATE TABLE importaciones_db.tablatemporal
(
  pais_de_proveniencia character varying,
  aduana_de_ingreso character varying,
  fecha_de_la_poliza character varying,
  partida_arancelaria character varying,
  modelo_del_vehiculo character varying,
  marca character varying,
  linea character varying,
  centimetros_cubicos character varying,
  distintivo character varying,
  tipo_de_vehiculo character varying,
  tipo_de_importador character varying,
  tipo_combustible character varying,
  asientos character varying,
  puertas character varying,
  tonelaje character varying,
  valor_cif character varying,
  impuesto character varying,
  otro character varying
)
WITH (
  OIDS=FALSE
);

COPY importaciones_db.tablatemporal FROM 'D:\CURSO DE DATAPATH\BOOTCAMP\Proyectos en GITHub\Modelado de BD y carga de datos con Postgresql\data\web_imp_08012019.txt' DELIMITER '|' CSV HEADER;
COPY importaciones_db.tablatemporal FROM 'D:\CURSO DE DATAPATH\BOOTCAMP\Proyectos en GITHub\Modelado de BD y carga de datos con Postgresql\data\web_imp_08022017.txt' DELIMITER '|' CSV HEADER;

-- -----------------------------------------------------

-- Table: importaciones_db.marca

-- DROP TABLE importaciones_db.marca;

CREATE TABLE importaciones_db.marca
(
  id_marca serial NOT NULL,
  nombre_marca character varying(45) NOT NULL,
  CONSTRAINT marca_pkey PRIMARY KEY (id_marca),
  CONSTRAINT marca_nombremarca_key UNIQUE (nombre_marca)
)
WITH (
  OIDS=FALSE
);

-- -----------------------------------------------------

-- Table: importaciones_db.tipo_combustible

-- DROP TABLE importaciones_db.tipo_combustible;

CREATE TABLE importaciones_db.tipo_combustible
(
  id_tipo_combustible serial NOT NULL,
  nombre_tipo_combustible character varying(45) NOT NULL,
  CONSTRAINT tipo_combustible_pkey PRIMARY KEY (id_tipo_combustible),
  CONSTRAINT nombretipocombustiblea_key UNIQUE (nombre_tipo_combustible)
)
WITH (
  OIDS=FALSE
);

-- -----------------------------------------------------

-- Table: importaciones_db.tipo_vehiculo

-- DROP TABLE importaciones_db.tipo_vehiculo;

CREATE TABLE importaciones_db.tipo_vehiculo
(
  id_tipo_vehiculo serial NOT NULL,
  nombre_tipo_vehiculo character varying(45) NOT NULL,
  CONSTRAINT tipo_vehiculo_pkey PRIMARY KEY (id_tipo_vehiculo),
  CONSTRAINT nombretipovehiculo_key UNIQUE (nombre_tipo_vehiculo)
)
WITH (
  OIDS=FALSE
);

-- -----------------------------------------------------

-- Table: importaciones_db.tipo_importador

-- DROP TABLE importaciones_db.tipo_importador;

CREATE TABLE importaciones_db.tipo_importador
(
  id_tipo_importador serial NOT NULL,
  nombre_tipo_importador character varying(45) NOT NULL,
  CONSTRAINT tipo_importador_pkey PRIMARY KEY (id_tipo_importador),
  CONSTRAINT nombretipoimportador_key UNIQUE (nombre_tipo_importador)
)
WITH (
  OIDS=FALSE
);

-- -----------------------------------------------------

-- Table: importaciones_db.modelo_lanzamiento

-- DROP TABLE importaciones_db.modelo_lanzamiento;

CREATE TABLE importaciones_db.modelo_lanzamiento
(
  id_modelo_lanzamiento serial NOT NULL,
  anio character varying(45) NOT NULL,
  CONSTRAINT modelo_lanzamiento_pkey PRIMARY KEY (id_modelo_lanzamiento),
  CONSTRAINT anio_key UNIQUE (anio)
)
WITH (
  OIDS=FALSE
);

-- -----------------------------------------------------

-- Table: importaciones_db.linea

-- DROP TABLE importaciones_db.linea;

CREATE TABLE importaciones_db.linea
(
  id_linea serial NOT NULL,
  nombre_linea character varying(45) NOT NULL,
  CONSTRAINT linea_pkey PRIMARY KEY (id_linea),
  CONSTRAINT nombre_linea_key UNIQUE (nombre_linea)
)
WITH (
  OIDS=FALSE
);

-- -----------------------------------------------------

-- Table: importaciones_db.pais_origen

-- DROP TABLE importaciones_db.pais_origen;

CREATE TABLE importaciones_db.pais_origen
(
  id_pais_origen serial NOT NULL,
  nombre_pais_origen character varying(45) NOT NULL,
  CONSTRAINT pais_origen_pkey PRIMARY KEY (id_pais_origen),
  CONSTRAINT nombre_pais_origen_key UNIQUE (nombre_pais_origen)
)
WITH (
  OIDS=FALSE
);

-- -----------------------------------------------------

-- Table: importaciones_db.aduana_ingreso

-- DROP TABLE importaciones_db.aduana_ingreso;

CREATE TABLE importaciones_db.aduana_ingreso
(
  id_aduana_ingreso serial NOT NULL,
  nombre_aduana_ingreso character varying(45) NOT NULL,
  CONSTRAINT aduana_ingreso_pkey PRIMARY KEY (id_aduana_ingreso),
  CONSTRAINT nombre_aduana_ingreso_key UNIQUE (nombre_aduana_ingreso)
)
WITH (
  OIDS=FALSE
);

-- -----------------------------------------------------

-- Table: importaciones_db.pais_aduana

-- DROP TABLE importaciones_db.pais_aduana;

CREATE TABLE importaciones_db.pais_aduana
(
  id_pais_id_aduana serial NOT NULL,
  id_pais_origen integer NOT NULL,
  id_aduana_ingreso integer NOT NULL,
  CONSTRAINT pais_aduana_pkey PRIMARY KEY (id_pais_id_aduana),
  CONSTRAINT pais_aduana_id_aduana_ingreso_fkey FOREIGN KEY (id_aduana_ingreso)
      REFERENCES importaciones_db.aduana_ingreso (id_aduana_ingreso) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT pais_aduana_id_pais_origen_fkey FOREIGN KEY (id_pais_origen)
      REFERENCES importaciones_db.pais_origen (id_pais_origen) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT d_pais_id_aduana_key UNIQUE (id_pais_origen, id_aduana_ingreso)
)
WITH (
  OIDS=FALSE
);

-- -----------------------------------------------------

-- Table: importaciones_db.linea_modelo

-- DROP TABLE importaciones_db.linea_modelo;

CREATE TABLE importaciones_db.linea_modelo
(
  id_linea_modelo serial NOT NULL,
  id_linea integer NOT NULL,
  id_modelo_lanzamiento integer NOT NULL,
  id_marca integer NOT NULL,
  CONSTRAINT linea_modelo_pkey PRIMARY KEY (id_linea_modelo),
  CONSTRAINT linea_modelo_id_linea_fkey FOREIGN KEY (id_linea)
      REFERENCES importaciones_db.linea (id_linea) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT linea_modelo_id_marca_fkey FOREIGN KEY (id_marca)
      REFERENCES importaciones_db.marca (id_marca) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT linea_modelo_id_modelo_lanzamiento_fkey FOREIGN KEY (id_modelo_lanzamiento)
      REFERENCES importaciones_db.modelo_lanzamiento (id_modelo_lanzamiento) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT linea_modelo_marca_key UNIQUE (id_linea, id_modelo_lanzamiento, id_marca)
)
WITH (
  OIDS=FALSE
);

-- -----------------------------------------------------

-- Table: importaciones_db.importacion

-- DROP TABLE importaciones_db.importacion;

CREATE TABLE importaciones_db.importacion
(
  id_importacion serial NOT NULL,
  id_pais_id_aduana integer NOT NULL,
  id_linea_modelo integer NOT NULL,
  id_tipo_vehiculo integer NOT NULL,
  id_tipo_combustible integer NOT NULL,
  id_tipo_importador integer NOT NULL,
  fecha_importacion date NOT NULL,
  valor_cif numeric NOT NULL,
  impuesto numeric NOT NULL,
  puertas integer NOT NULL,
  tonelaje numeric NOT NULL,
  asientos integer NOT NULL,
  CONSTRAINT importacion_pkey PRIMARY KEY (id_importacion),
  CONSTRAINT importacion_id_linea_modelo_fkey FOREIGN KEY (id_linea_modelo)
      REFERENCES importaciones_db.linea_modelo (id_linea_modelo) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT importacion_id_pais_idaduana_fkey FOREIGN KEY (id_pais_id_aduana)
      REFERENCES importaciones_db.pais_aduana (id_pais_id_aduana) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT importacion_id_tipo_combustible_fkey FOREIGN KEY (id_tipo_combustible)
      REFERENCES importaciones_db.tipo_combustible (id_tipo_combustible) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT importacion_id_tipo_importador_fkey FOREIGN KEY (id_tipo_importador)
      REFERENCES importaciones_db.tipo_importador (id_tipo_importador) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT importacion_id_tipo_vehiculo_fkey FOREIGN KEY (id_tipo_vehiculo)
      REFERENCES importaciones_db.tipo_vehiculo (id_tipo_vehiculo) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);

