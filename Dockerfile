FROM apache/spark:4.1.0-python3

USER root

RUN pip install --no-cache-dir \
    pandas \
    numpy \
    matplotlib \
    scikit-learn \
    jupyter \
    pyspark==4.1.0 

WORKDIR /workspace
EXPOSE 8888

# Este comando no es necesario si orquestamos desde devcontainer.json con dockerComposeFile,
# ya tenemos el comando en el servicio.
#CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]