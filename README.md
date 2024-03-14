# Proyecto de Modelado y Carga de Datos con PostgreSQL

Este repositorio contiene el código y los recursos necesarios para modelar una base de datos transaccional utilizando PostgreSQL. El objetivo principal es estructurar las entidades y relaciones a partir de un archivo de texto descargado de Kaggle, y luego poblar las tablas correspondientes mediante un stored procedure.

## Contenido del Repositorio

- `data/`: Carpeta que contiene el archivo de texto original descargado de Kaggle.
- `sql/`: Carpeta que contiene los scripts SQL utilizados en el proyecto.
  - `create_tables.sql`: Script para crear las tablas en la base de datos.
  - `store_procedure.sql`: Script del stored procedure para poblar las tablas finales.
- `README.md`: Este archivo, que proporciona una guía sobre el proyecto y su estructura.

## Pasos Utilizados

1. **Análisis del Archivo de Texto**:
   - Examiné el archivo de texto descargado de Kaggle para entender su estructura y contenido.

2. **Estructuración de las Entidades y Atributos**:
   - Definí las entidades y sus atributos en PostgreSQL basándome en el análisis del paso anterior.

3. **Definición de las Relaciones**:
   - Establecí las relaciones entre las entidades según fuera necesario.

4. **Creación de la Tabla Temporal**:
   - Creé una tabla temporal en PostgreSQL para cargar la data original del archivo de texto.

5. **Carga de la Data en la Tabla Temporal**:
   - Utilicé comandos SQL para cargar la data del archivo de texto en la tabla temporal.

6. **Desarrollo del Stored Procedure**:
   - Creé un stored procedure en PostgreSQL que contiene la lógica para poblar las tablas finales.

7. **Población de las Tablas Finales**:
   - Utilicé el stored procedure desarrollado en el paso anterior para poblar las tablas finales.

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

## Contribuciones

Las contribuciones son bienvenidas. Siéntete libre de abrir un *issue* o enviar un *pull request* para sugerir mejoras o correcciones.

## Capturas de Pantalla

### Estructura del Repositorio
[![Estructura-proyecto.png](https://i.postimg.cc/htDpQw1t/Estructura-proyecto.png)](https://postimg.cc/7fRgpKRF)

### Contenido del Archivo de Datos
[![Contenido-del-archivo-de-datos.png](https://i.postimg.cc/Kc5T3Yqt/Contenido-del-archivo-de-datos.png)](https://postimg.cc/kDBGk7d5)

### Modelo Físico OLTP
[![modelo-fisico-oltp.png](https://i.postimg.cc/DyN17wwF/modelo-fisico-oltp.png)](https://postimg.cc/mtQPwR96)

### Script SQL - Creación de Tablas
[![Script-sql-creacion-tablas.png](https://i.postimg.cc/bv5QwYT1/Script-sql-creacion-tablas.png)](https://postimg.cc/CZjZvg9K)

### Script SQL - Store Procedure
[![Script-sql-store-procedure.png](https://i.postimg.cc/CK41xwVm/Script-sql-store-procedure.png)](https://postimg.cc/Y4hkXK0W)
