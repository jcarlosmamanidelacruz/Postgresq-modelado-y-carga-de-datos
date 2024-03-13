# Proyecto de Modelado y Carga de Datos con PostgreSQL

Este repositorio contiene el código y los recursos necesarios para modelar una base de datos transaccional utilizando PostgreSQL. El objetivo principal es estructurar las entidades y relaciones a partir de un archivo de texto descargado de Kaggle, y luego poblar las tablas correspondientes mediante un stored procedure.

## Contenido del Repositorio

- `data/`: Carpeta que contiene el archivo de texto original descargado de Kaggle.
- `sql/`: Carpeta que contiene los scripts SQL utilizados en el proyecto.
  - `create_tables.sql`: Script para crear las tablas en la base de datos.
  - `load_data.sql`: Script para cargar los datos en la tabla temporal.
  - `populate_tables.sql`: Script del stored procedure para poblar las tablas finales.
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

## Uso

1. Clona este repositorio en tu máquina local.
2. Importa la base de datos en PostgreSQL utilizando los scripts proporcionados.
3. Ejecuta el stored procedure para poblar las tablas finales.

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
