# 🏷 AdventureWorks DW — Projeto DBT (Certificado Indicium AE)

## Visão Geral

Construção de um **Data Warehouse analítico** sobre o banco transacional **AdventureWorks**, distribuído em ~68 tabelas nos schemas: `HR`, `Sales`, `Production`, `Purchasing`.

Framework utilizado: **dbt**, organizado em camadas medallion: **staging → intermediate → marts** para garantir qualidade, integridade e flexibilidade.

## Estrutura do Repositório

.
├── analyses/  
├── macros/  
├── models/  
│   ├── staging/  
│   ├── intermediate/  
│   └── marts/  
│       ├── utilities/  
├── seeds/  
├── snapshots/  
├── tests/  
├── README.md  
├── dbt_project.yml  
└── packages.yml  

## Modelagem DW (Star Schema)

O núcleo do DW é a tabela fato `fact_sales`, conectada a diversas dimensões:

- **Product** — reúne o produto com subcategoria e categoria  
- **Customer** — pessoa física ou loja, consolidado no `int_customers__enriched`  
- **Address** — cidade, estado, país  
- **Credit Card** — tipo de pagamento  
- **Sales Reason** — motivo da venda (Promoção, Marketing etc.)  
- **Date** — calendário analítico (dia, mês, ano…)

Cada dimensão passa por `staging → intermediate (enriched) → marts`.

### Modelos Criados

**Staging (`models/staging/erp`)**  
Extrai e padroniza os dados do ERP (ex.: `stg_erp__product`, `stg_erp__salesorderheader`, `stg_erp__address` etc.).

**Intermediate (`models/intermediate`)**  
Aplica joins e cálculos, como `int_products__enriched`, `int_customers__enriched`, `int_sales__enriched` (pré-fato).

**Marts (`models/marts`)**

- **Dimensions**: `dim_products`, `dim_customers`, `dim_address`, `dim_creditcard`, `dim_salesreason`, `dim_date`  
- **Fact**: `fact_sales` (granularidade: linhas de pedido, com medidas como quantidade, preço, total, descontos).

## Perguntas de Negócio Atendidas

1. **Resumo detalhado por pedido**  
   - Pedidos, quantidade, valor negociado  
   - Análise por produto, forma de pagamento, motivo, data, cliente, status, localização  

2. **Ticket médio de produtos**  
   - Por mês, ano, cidade, estado, país  

3. **Top 10 clientes por valor negociado**  
   - Filtros por produto, cartão, motivo, data, status, local  

4. **Top 5 cidades por valor total negociado**  

5. **Série temporal de vendas**  
   - Volume de pedidos, quantidade e valor por mês/ano  

6. **Produto líder em Promoções**  
   - Maior quantidade vendida para motivo “Promotion”  

## Como Executar

```bash
dbt deps     # instala pacotes (por ex. dbt_utils)
dbt run      # executa todos os modelos
dbt test     # executa testes de integridade
dbt docs generate && dbt docs serve  # visualiza a documentação gerada
