# Projeto de Data Quality com PySpark

Este repositório foi criado com o objetivo de fornecer um guia prático e introdutório ao Apache Spark, utilizando a linguagem Python (PySpark). O foco principal é demonstrar um fluxo de trabalho essencial de engenharia de dados, cobrindo desde a ingestão de dados brutos até a aplicação de técnicas de qualidade de dados e o armazenamento em formatos otimizados.

## 🚀 Conceitos Abordados

O projeto, contido no notebook `notebooks/script.ipynb`, aborda os seguintes pilares de processamento de dados com Spark:

1.  **Inicialização e Configuração**:
    *   Criação de uma `SparkSession`, o ponto de entrada para qualquer aplicação Spark.

2.  **Ingestão de Dados**:
    *   Leitura de arquivos CSV, definindo um **schema explícito** para garantir a consistência dos tipos de dados e otimizar a performance de leitura.

3.  **Pipeline de Qualidade de Dados (Data Quality)**:
    *   **Limpeza (Cleaning)**: Tratamento de valores nulos (`null`) utilizando `coalesce` e `fillna`.
    *   **Transformação (Transformation)**: Padronização de formatos (datas, strings) e conversão de tipos de dados (`cast`).
    *   **Enriquecimento (Enrichment)**: Criação de novas colunas com base em regras de negócio (`when`/`otherwise`).
    *   **Normalização (Normalization)**: Padronização de valores categóricos para garantir consistência.
    *   **Desduplicação (Deduplication)**: Remoção de registros duplicados para garantir a unicidade dos dados.

4.  **Armazenamento Otimizado**:
    *   Escrita dos dados tratados em formato **Parquet** e **ORC**, explicando os benefícios de formatos colunares.
    *   Uso de **particionamento** (`partitionBy`) para otimizar futuras consultas.

5.  **Otimização de Consultas**:
    *   Demonstração prática do **Predicate Pushdown**, onde o Spark otimiza a leitura ao filtrar dados diretamente no nível das partições.
    *   Demonstração da otimização de **SerDe (Projection Pushdown)**, onde apenas as colunas selecionadas em uma query são lidas do disco.

## 📂 Estrutura do Projeto

```
/
├── data/
│   └── logistica_raw.csv       # Dataset bruto para ser utilizado no exercicio.
├── notebooks/
│   ├── geradorDataset.ipynb    # Notebook Jupter com o codigo para Gerar o arquivo CSV para o Exercicio.
│   ├── script.ipynb            # Notebook Jupyter com todo o código PySpark.
│   └── vendas_brutas.csv       # Dataset bruto utilizado no exemplo.
├── docker-compose.yml          # Arquivo para orquestrar o ambiente Docker.
├── Dockerfile                  # Arquivo de configuração para a imagem Docker.
├── exercicio.md                # Arquivo com o Desafio para ser feito em aula
└── readme.md                   # Este arquivo.
```

## 🛠️ Setup e Execução do Ambiente

Para executar o projeto, utilizamos um ambiente Docker que já contém o Jupyter e o PySpark configurados.

### Pré-requisitos
*   [Docker](httpss://docs.docker.com/get-docker/)
*   [Docker Compose](httpss://docs.docker.com/compose/install/)

### Passos para Execução

1.  **Clone o Repositório**:
    ```bash
    git clone https://github.com/AleTavares/dataqualitySpark.git
    cd dataqualitySpark
    ```

2.  **Inicie o Ambiente Docker**:
    No terminal, a partir da raiz do projeto, execute o comando abaixo. Ele irá construir a imagem Docker (se ainda não existir) e iniciar o container do JupyterLab em background.
    ```bash
    docker compose up --build -d
    ```

3.  **Acesse o Jupyter**:
    Abra seu navegador e acesse o seguinte endereço:
    ```
    http://localhost:8888/
    ```
    *   O token de acesso já está configurado no `docker-compose.yml` para simplificar.

4.  **Execute o Notebook**:
    *   Dentro do ambiente Jupyter, navegue até a pasta `notebooks`.
    *   Abra o arquivo `script.ipynb`.
    *   Execute as células sequencialmente para acompanhar todo o processo de transformação dos dados.

> Com isso, o ambiente estará pronto para você explorar e aprender os conceitos fundamentais de qualidade de dados com PySpark!

> [!IMPORTANT]
> 5.  **Desligando o Ambiente**:
>    Para parar e remover os containers, execute o seguinte comando no terminal:
>    ```bash
>    docker compose down
>    ```