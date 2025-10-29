# Usa a imagem oficial do Jupyter/PySpark como base
# Esta imagem já configura a SparkSession e variáveis de ambiente
FROM jupyter/pyspark-notebook

# Instala pacotes Python adicionais que podem ser úteis
# Ex: pandas para visualização local, matplotlib para plotting
# OBS: A instalação é feita como root para evitar problemas de permissão
# Se precisar de mais pacotes, adicione-os aqui
USER root
RUN pip install --no-cache-dir \
    pandas \
    matplotlib \
    findspark # O findspark não é estritamente necessário na imagem jupyter/pyspark, mas é bom ter

# A imagem base já define o usuário 'jovyan', mas vamos criar um usuário customizado para a nossa imagem.
USER root

# Cria o usuário 'tavares', seu diretório home e o adiciona ao grupo 'users' (GID 100)
# A UID 1001 é usada para evitar conflito com a UID do jovyan (1000)
RUN useradd -ms /bin/bash -g 100 -u 1001 tavares && \
    mkdir -p /home/tavares && \
    chown -R tavares:users /home/tavares

# Retorna para o usuário 'tavares' e define o diretório de trabalho
USER tavares
WORKDIR /home/tavares/work

# Porta 8888 (Jupyter Notebook) já é exposta pela imagem base.