# Spark MLlib – Entorno Contenerizado para Práctica 2 de Infraestructuras Computacionales para Procesamiento de Datos Masivos (UNED)

Este repositorio proporciona un **entorno reproducible y completamente contenerizado** para desarrollar notebooks de Apache Spark (PySpark + MLlib) utilizando **Visual Studio Code** y **Docker**, sin necesidad de instalar Python, Java ni Spark en la máquina local.

El objetivo es facilitar el desarrollo del **segundo ejercicio de la Práctica 2**, permitiendo a cualquier alumno centrarse exclusivamente en el código y los conceptos, no en la configuración del entorno.

---

## Arquitectura del entorno

El proyecto levanta un **clúster mínimo de Apache Spark** compuesto por:

- **1 Spark Master**
- **1 Spark Worker** (se pueden crear más copiando y pegando la sección de servicio llamada `spark-worker` en el fichero `docker-compose.yml` pero teniendo cuidado de darle un nombre distinto a cada nodo, i.e. `spark-worker-1`, `spark-worker-2`, etc)
- **1 contenedor Jupyter Notebook** (desde el que se ejecutan los notebooks)

Todo el entorno se ejecuta en Docker y se integra con Visual Studio Code mediante **Dev Containers**.

---

## Estructura del proyecto

```text
.
├── Dockerfile
├── docker-compose.yml
├── test-notebook.ipynb
├── README.md
└── .devcontainer/
    └── devcontainer.json
```

### Descripción de los ficheros

* `Dockerfile` 

Imagen base de Apache Spark (4.1.0) con Python y librerías adicionales necesarias para notebooks y ML.
* `docker-compose.yml` 

Define el clúster Spark (master + worker) y el servicio de Jupyter Notebook.
* `test-notebook.ipynb`

Notebook de ejemplo. Se puede duplicar o renombrar para desarrollar la práctica.
* `.devcontainer/devcontainer.json`

Configuración para que Visual Studio Code se conecte automáticamente al entorno Docker.

---

## Cómo arrancar el entorno

### Clonar el repositorio

```bash
git clone git@github.com:jolmedilla/spark-jupyter-notebook-on-devcontainer.git
cd spark-jupyter-notebook-on-devcontainer
```

### Abrir en Visual Studio Code

```bash
code .
```

### Reabrir en contenedor

Desde la paleta de comandos:

```text
Dev Containers: Reopen in Container
```

---

## Abrir el notebook

Abre `test-notebook.ipynb` desde VS Code.

---

## Obtener el token de Jupyter

```bash
docker logs spark-notebook
```

Busca:

```text
http://127.0.0.1:8888/tree?token=XXXXXXXX
```

---

## Conectarse a Jupyter

- URL: `http://127.0.0.1:8888`
- Token: el obtenido de los logs

**Usa `127.0.0.1`, no `localhost`**.

---

## Seleccionar kernel

Selecciona **Python 3 (ipykernel)**.

---

## Verificación rápida

```python
from pyspark.sql import SparkSession

spark = (
    SparkSession.builder
    .appName("Test")
    .master("spark://spark-master:7077")
    .getOrCreate()
)

spark.range(10).show()
```

---

## Reducir logs (opcional)

```python
spark.sparkContext.setLogLevel("ERROR")
```
