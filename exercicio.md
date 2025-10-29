# 📝 Desafio Final da Aula Prática: Refino de Dados de Logística

## 🎯 Objetivo

Criar um *pipeline* PySpark completo para transformar dados brutos de logística na camada **Curated**, aplicando todas as 5 técnicas de Data Quality, salvando no formato Parquet particionado e demonstrando a otimização de I/O.

## 1. 📂 Dados Brutos (`logistica_raw.csv`)

O arquivo de entrada (que será gerado via código na Tarefa A) contém problemas de tipagem, nulos e duplicatas:

| ID_RASTREIO | DATA_ENVIO_RAW | CUSTO_FRETE_RAW | CIDADE_DESTINO | STATUS_ENTREGA |
| :---: | :---: | :---: | :---: | :---: |
| L9001 | 2024-05-10 | 15.50 | Sao Paulo | ENTREGUE |
| L9002 | 2024/05/11 | 22,00 | Rio | Em Trânsito |
| L9003 | 2024-05-12 | 100.00 | Salvador | null |
| L9004 | 2024-05-12 | null | BH | PENDENTE |
| L9004 | 2024-05-12 | null | BH | PENDENTE |

---

## 2. 🚀 Tarefa A: Ingestão e Data Quality (50%)

Utilize o código de suporte fornecido para carregar os dados no `df_logistica_raw`. Em seguida, aplique as transformações em sequência:

1.  **Pré-requisito:** Defina o `StructType` que trate **todas** as colunas como `StringType`.
2.  **Limpeza (Cleaning):**
    * Trate nulos na coluna `STATUS_ENTREGA`: Se for nulo, preencha com a *string* `"DESCONHECIDO"`.
    * Trate nulos na coluna `CUSTO_FRETE_RAW`: Se for nulo, preencha com a *string* `"0.00"`.
3.  **Transformação (Transformation):**
    * Crie uma coluna `DATA_ENVIO` convertendo `DATA_ENVIO_RAW` para o tipo `Date`.
    * Crie uma coluna `CUSTO_FRETE` convertendo `CUSTO_FRETE_RAW` para o tipo `Double` (remova vírgulas antes do `cast`).
4.  **Enriquecimento (Enrichment):**
    * Crie uma coluna `FLAG_CARO`: Atribua `True` se `CUSTO_FRETE` for maior ou igual a `50.00`, senão `False`.
5.  **Normalização (Normalization):**
    * Converta a coluna `STATUS_ENTREGA` para **CAIXA ALTA**.
6.  **Desduplicação (Deduplication):**
    * Use `ID_RASTREIO` como chave e remova as duplicatas. O resultado final deve ter **4 linhas**.

### **Resultado Esperado da Tarefa A:** Um DataFrame `df_logistica_curated` limpo, sem nulos, com tipos corretos, e 4 linhas.

---

## 3. 💾 Tarefa B: Armazenamento Otimizado (30%)

Salve o DataFrame final (`df_logistica_curated`) no Data Lake (diretório mapeado pelo Docker):

1.  **Escrita em Parquet:**
    * Salve o DataFrame em: `./data/curated/logistica_parquet`.
    * Use o modo `overwrite`.
    * **Particione o dataset** fisicamente pela coluna **`CIDADE_DESTINO`**.

---

## 4. 🔎 Tarefa C: Otimização de I/O (20%)

Demonstre que o seu armazenamento está eficiente:

1.  **Predicate Pushdown:**
    * Crie uma variável `df_salvador`. Leia o arquivo Parquet **filtrando** apenas as entregas com `CIDADE_DESTINO` igual a `"Salvador"`.
    * Adicione um comentário (`#`) explicando como o particionamento acelera esta consulta.

2.  **SerDe e Projeção:**
    * Crie uma variável `df_leve`. Leia o arquivo Parquet **selecionando (projetando)** apenas as colunas `ID_RASTREIO` e `FLAG_CARO`.
    * Adicione um comentário (`#`) explicando como o formato colunar e o SerDe otimizam a leitura (ignorando as colunas de data/custo).