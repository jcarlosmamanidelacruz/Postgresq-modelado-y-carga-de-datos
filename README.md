# Proyecto de Modelado y Carga de Datos con PostgreSQL

Este repositorio contiene el código y los recursos necesarios para modelar una base de datos transaccional utilizando PostgreSQL. El objetivo principal es estructurar las entidades y relaciones a partir de un archivo de texto descargado de Kaggle, y luego poblar las tablas correspondientes mediante un stored procedure.

#### Contenido del Archivo de Datos
[![Contenido-del-archivo-de-datos.png](https://i.postimg.cc/Kc5T3Yqt/Contenido-del-archivo-de-datos.png)](https://postimg.cc/kDBGk7d5)


## Introducción

- En este proyecto, se han seguido los siguientes pasos para llevar a cabo el modelado y la carga de datos:

### Recolección de Requisitos:

- Identificación de los datos y necesidades del negocio basándonos en el archivo de texto descargado de Kaggle.

### Diseño Conceptual:

- Creación del modelo entidad-relación (ER) para definir las entidades y sus relaciones.
- Diseño Lógico:

- Transformación del modelo ER en un esquema lógico compatible con PostgreSQL.

### Diseño Físico:

- Implementación del esquema lógico en PostgreSQL, definiendo tablas, índices y constraints.

### Implementación:

- Desarrollo de scripts SQL para crear las tablas y el stored procedure necesario para poblarlas.

### Pruebas y Validación:

- Ejecución de pruebas unitarias e integradas para asegurar la correcta creación y población de las tablas.

## Recolección y análisis de los datos

Para modelar una base de datos transaccional basada en los datos de los archivos .txt descargados de Kaggle, podemos seguir un proceso estructurado, desde la recolección y análisis de los datos hasta el diseño y creación de la base de datos.

### Recolección y Análisis de Datos

Entender los Datos:

- Cabeceras de los Datos:
- País de Proveniencia
- Aduana de Ingreso
- Fecha de la Poliza
- Partida Arancelaria
- Modelo del Vehiculo
- Marca
- Linea
- Centimetros Cubicos
- Distintivo
- Tipo de Vehiculo
- Tipo de Importador
- Tipo Combustible
- Asientos
- Puertas
- Tonelaje
- Valor CIF
- Impuesto

Características de los Datos:

- Datos textuales y numéricos.
- Información relacionada con importaciones de vehículos.

### Modelo Físico OLTP

[![modelo-fisico-oltp.png](https://i.postimg.cc/DyN17wwF/modelo-fisico-oltp.png)](https://postimg.cc/mtQPwR96)

### Creación de la Base de Datos

En esta sección se describen los comandos utilizados para la creación de la base de datos en PostgreSQL. Estos comandos se aplican a lo largo del desarrollo de la base de datos para definir esquemas, tablas, constraints y otras estructuras necesarias. Esta documentación sirve como referencia para entender y reproducir el proceso de creación de la base de datos.

### Comandos Utilizados

**CREATE SCHEMA:**

Se utiliza para crear un nuevo esquema en la base de datos, que sirve como un contenedor para las tablas y otros objetos.

- Ejemplo:

			CREATE SCHEMA importaciones_db;

**CREATE TABLE:**

Se utiliza para crear una nueva tabla dentro del esquema especificado. Define la estructura de la tabla, incluyendo las columnas y sus tipos de datos.

- Ejemplo:

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

**COPY:**

Se utiliza para cargar datos desde un archivo externo a una tabla en la base de datos.

- Ejemplo:

		COPY importaciones_db.tablatemporal FROM 'D:\CURSO DE DATAPATH\BOOTCAMP\Proyectos en GITHub\Modelado de BD y carga de datos con Postgresql\data\web_imp_08012019.txt' DELIMITER '|' CSV HEADER;

**SERIAL:**

Se utiliza para definir una columna de tipo entero que se auto incrementa automáticamente. Es útil para crear identificadores únicos.

- Ejemplo:

			id_marca serial NOT NULL

**PRIMARY KEY:**

Se utiliza para definir una clave primaria en una tabla, que asegura la unicidad y no nulidad de los valores en una columna o conjunto de columnas.

- Ejemplo:

			CONSTRAINT marca_pkey PRIMARY KEY (id_marca)

**UNIQUE:**

Se utiliza para asegurar que los valores en una columna o conjunto de columnas sean únicos en la tabla.

- Ejemplo:

			CONSTRAINT marca_nombremarca_key UNIQUE (nombre_marca)

**FOREIGN KEY:**

Se utiliza para definir una clave foránea en una tabla, que crea una relación entre columnas de diferentes tablas. Asegura la integridad referencial entre las tablas.


			CONSTRAINT pais_aduana_id_pais_origen_fkey FOREIGN KEY (id_pais_origen)
			  REFERENCES importaciones_db.pais_origen (id_pais_origen) MATCH SIMPLE
			  ON UPDATE NO ACTION ON DELETE NO ACTION

[![Script-sql-creacion-tablas.png](https://i.postimg.cc/bv5QwYT1/Script-sql-creacion-tablas.png)](https://postimg.cc/CZjZvg9K)


### Stored Procedure para la Carga de Información

En el stored procedure creado para la carga de información, se utilizan diversos comandos y técnicas para asegurar una limpieza y una carga adecuada de los datos. A continuación, se describen los principales elementos y comandos utilizados:

### Comandos Utilizados

**UPPER:**

Se utiliza para convertir todos los datos a mayúsculas, asegurando así una homologación de la información.

**TRIM:**

Se utiliza para eliminar espacios en blanco al inicio y al final de los datos.

- Ejemplo: TRIM(nombre_columna)
- Ejemplo: UPPER(nombre_columna)

		update importaciones_db.tablatemporal set
			pais_de_proveniencia = upper(trim(pais_de_proveniencia)),
			aduana_de_ingreso = upper(trim(aduana_de_ingreso)),
			fecha_de_la_poliza = upper(trim(fecha_de_la_poliza)),
			modelo_del_vehiculo = upper(trim(modelo_del_vehiculo)),
			marca = upper(trim(marca)),
			linea = upper(trim(linea)),
			centimetros_cubicos = upper(trim(centimetros_cubicos)),
			tipo_de_vehiculo = upper(trim(tipo_de_vehiculo)),
			tipo_de_importador = upper(trim(tipo_de_importador)),
			tipo_combustible = upper(trim(tipo_combustible)),
			asientos = upper(trim(asientos)),
			puertas = upper(trim(puertas)),
			tonelaje = upper(trim(tonelaje)),
			valor_cif = upper(trim(valor_cif)),
			impuesto = upper(trim(impuesto))
		;
		

**UPDATE:**

Se utiliza para realizar una limpieza y actualización de los datos. Por ejemplo, en casos donde se detectó que la marca "GREAT DANE" estaba escrita incorrectamente como "RATE DANE".

Ejemplo:

			update importaciones_db.tablatemporal set marca = 'GREAT DANE'
			where marca = 'GRATE DANE';

			update importaciones_db.tablatemporal set linea = (
				case
					when linea in ('SINLINEA', 'SILINEA', '--') then 'SIN LINEA'
					when linea =  'SOUL !' then 'SOUL'
					else linea 
				end
			);

**DELETE:**

Se utiliza para eliminar la información de las tablas antes de la ejecución del stored procedure, evitando así errores al momento de la población.

Ejemplo:

			delete from importaciones_db.importacion;
			delete from importaciones_db.pais_aduana;
			delete from importaciones_db.aduana_ingreso;
			delete from importaciones_db.pais_aduana;
			delete from importaciones_db.tipo_vehiculo;
			delete from importaciones_db.tipo_importador;
			delete from importaciones_db.tipo_combustible;
			delete from importaciones_db.linea_modelo;
			delete from importaciones_db.modelo_lanzamiento;
			delete from importaciones_db.marca;
			delete from importaciones_db.linea;

**INSERT INTO:**

Se utiliza para poblar las tablas con los datos limpios y estructurados.

Ejemplo:

			insert into importaciones_db.pais_origen(nombre_pais_origen)
			select pais_de_proveniencia
			from importaciones_db.tablatemporal
			where pais_de_proveniencia not in (
				select nombre_pais_origen
				from importaciones_db.pais_origen
			)
			group by pais_de_proveniencia
			order by pais_de_proveniencia;

**GROUP BY:**

Se utiliza para agrupar los datos de los catálogos al momento de la carga.

Ejemplo:

			insert into importaciones_db.marca(nombre_marca)
			select marca
			from importaciones_db.tablatemporal
			where marca not in (
				select nombre_marca
				from importaciones_db.marca
			)
			group by marca
			order by marca;

**ORDER BY:**

Se utiliza para ordenar los datos al momento de insertarlos, asegurando que las claves automáticas se generen en el orden correcto.

Ejemplo:

			insert into importaciones_db.linea(nombre_linea)
			select linea
			from importaciones_db.tablatemporal
			where linea not in (
				select nombre_linea
				from importaciones_db.linea
			)
			group by linea
			order by linea;

**LEFT JOIN e INNER JOIN:**

Se utilizan para poblar tablas que dependen de otras tablas de catálogo previamente pobladas, de manera que se puedan obtener sus llaves primarias.

Ejemplo:

	insert into importaciones_db.pais_aduana (id_pais_origen, id_aduana_ingreso)
	select tb.id_pais_origen, tc.id_aduana_ingreso
	from (
		select ta.pais_de_proveniencia, ta.aduana_de_ingreso
		from importaciones_db.tablatemporal ta
		group by ta.pais_de_proveniencia, ta.aduana_de_ingreso
	) tx
		left join importaciones_db.pais_origen tb on tx.pais_de_proveniencia = tb.nombre_pais_origen
		left join importaciones_db.aduana_ingreso tc on tx.aduana_de_ingreso = tc.nombre_aduana_ingreso
	where (id_pais_origen, id_aduana_ingreso) not in (
		select id_pais_origen, id_aduana_ingreso
		from importaciones_db.pais_aduana
	);

**Bucle FOR:**

Se utiliza para recorrer los registros de la tabla temporal y, en la recursividad, extraer las llaves de cada catálogo para poblar la tabla base que contiene los registros de las importaciones.

Ejemplo:

			for v_rs_record in
				select *
				from importaciones_db.tablatemporal
			loop

				v_id_pais_origen := null;
				v_id_pais_origen := (
					select id_pais_origen
					from importaciones_db.pais_origen
					where nombre_pais_origen = v_rs_record.pais_de_proveniencia
				);
				
			end loop;

[![Script-sql-store-procedure.png](https://i.postimg.cc/CK41xwVm/Script-sql-store-procedure.png)](https://postimg.cc/Y4hkXK0W)

## Contenido del Repositorio

- `data/`: Carpeta que contiene el archivo de texto original descargado de Kaggle.
- `sql/`: Carpeta que contiene los scripts SQL utilizados en el proyecto.
  - `create_tables.sql`: Script para crear las tablas en la base de datos.
  - `store_procedure.sql`: Script del stored procedure para poblar las tablas finales.
- `README.md`: Este archivo, que proporciona una guía sobre el proyecto y su estructura.

[![Estructura-proyecto.png](https://i.postimg.cc/htDpQw1t/Estructura-proyecto.png)](https://postimg.cc/7fRgpKRF)

## Instrucciones para Configurar y Cargar los Datos

Sigue estos pasos para configurar el proyecto y cargar los datos en la tabla temporal:

### 1. Clonar el Repositorio

- Abre una terminal o un cliente de Git en tu máquina local.
- Clona este repositorio en tu máquina local ejecutando el siguiente comando:

      git clone https://github.com/jcarlosmamanidelacruz/Postgresq-modelado-y-carga-de-datos.git

### 2. Editar el Script "create_tables.sql"

- Abre el archivo `create_tables.sql` que se encuentra en el directorio `sql/` del proyecto clonado.<br>
- Realiza las modificaciones necesarias en este script para permitir la carga de información desde los archivos .txt a la tabla temporal, el cambio que debes realizar es solo cambiar la ruta del directorio en donde se encuentran los archivos .txt, los códigos a reemplazar son:<br>

  <b>COPY importaciones_db.tablatemporal FROM 'D:\CURSO DE DATAPATH\BOOTCAMP\Proyectos en GITHub\Modelado de BD y carga de datos con Postgresql\data\web_imp_08012019.txt' DELIMITER '|' CSV HEADER;</b><br><br>
  <b>COPY importaciones_db.tablatemporal FROM 'D:\CURSO DE DATAPATH\BOOTCAMP\Proyectos en GITHub\Modelado de BD y carga de datos con Postgresql\data\web_imp_08022017.txt' DELIMITER '|' CSV HEADER;</b><br><br>

[![ruta-path-txt.png](https://i.postimg.cc/sDrYHfD2/ruta-path-txt.png)](https://postimg.cc/Cdcnzg8y)

### 3. Crea el schema en la base de datos de PostgreSQL

- Abre y ejecuta el archivo `create_tables.sql` que se encuentra en el directorio `sql/` del proyecto clonado y ejecutalo

### 4. Crea el stored procedure para poblar las tablas finales
   
- Abre y ejecuta el archivo `store_procedure.sql` que se encuentra en el directorio `sql/` del proyecto clonado y ejecutalo.

### 5. Ejecuta el stored procedure

- Utiliza cualquiera de los siguientes comandos para ejecutar el stored procedure y poblar las tablas creadas:
  
      perforn importaciones_db.sp_proceso_carga();
      select * from importaciones_db.sp_proceso_carga();
