Projeto DBT – AdventureWorks DW

📌 Visão Geral:
Este projeto implementa um Data Warehouse baseado no banco AdventureWorks, utilizando o framework dbt.
O objetivo é organizar os dados brutos do ERP em camadas de transformação (staging, intermediate e marts), criando modelos analíticos confiáveis para relatórios e dashboards.

🏗️ Arquitetura:
O projeto segue a abordagem medallion architecture adaptada para dbt:

- Staging (stg_)
Normaliza e limpa os dados brutos.
Aplica casts, renomeia colunas e remove metadados técnicos.

- Intermediate (int_)
Consolida e enriquece dados entre diferentes tabelas.
Cria surrogate keys e padroniza dimensões.

- Marts (dim_, fct_)
Camada analítica final.
Dimensões (ex.: dim_products, dim_customers, dim_payment_type)
Fatos (ex.: fct_sales_orders)