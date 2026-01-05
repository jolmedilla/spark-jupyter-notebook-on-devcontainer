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

## Obtener el token de Jupyter

```bash
docker logs spark-notebook
```
Ten cuidado de que estés obteniendo los logs del contenedor `spark-notebook` y no de ninguno de los otros.
Busca:

```text
http://127.0.0.1:8888/tree?token=XXXXXXXX
```

![Obtener token](/images/get-token.png)

---

## Abrir el notebook

Abre `test-notebook.ipynb` desde VS Code.

![Abrir notebook](/images/open-notebook.png)

---

## Seleccionar kernel

Desde Visual Studio Code, una vez abierto el Notebook, dale al icono de seleccionar el Kernel de Jupyter:
![Selecciona el kernel clicando en el icono](/images/select-kernel.png)

A continuación elige *Existing Jupyter Server*:
![Existing Jupyter Server](/images/existing-jupyter-server.png)

Ahora te pedirá la URL del servidor (véase la imagen a continuación) y tienes que introducir el valor `http://127.0.0.1:8888`, **usa `127.0.0.1`, no `localhost`**.

![URL del servidor](/images/jupyter-server-url.png)

Te va a pedir, a continuación, la password y aquí es donde tienes que introducir el token que has obtenido antes de los logs del contenedor `spark-notebook`.

![Introduce password](/images/password-prompt.png)

Te pide ahora que confirmes el nombre que le quieres dar a ese servidor en tu lista de servidores a los que conectarse y por defecto te propone `127.0.0.1`, puedes simplemente confirmar pulsando la tecla *enter*.

![Confirma el nombre del servidor](/images/confirm-server-name.png)

Y ahora ya sí, como último paso, te pide que elijas el kernel de entre los disponibles en el servidor Jupyter al que te acabas de conectar, sólo te saldrá uno *Python 3 (ipykernel)*, escógelo y dale al *enter*.

![Escoge kernel y enter](/images/select-kernel-in-connected-server.png)



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
