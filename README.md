# 🏗️ Infraestrutura como Código – Terraform  
### FIAP – Pós-Graduação em DevOps Engineering

Este repositório contém toda a infraestrutura criada com **Terraform** utilizada nas atividades práticas e no trabalho final da **Pós-Graduação em DevOps da FIAP**.  
Aqui centralizamos os módulos, recursos e configurações necessárias para provisionar ambientes completos de forma automatizada, versionada e padronizada.

---

## 📘 Sobre o Repositório

O objetivo deste projeto é:

- Demonstrar boas práticas de Infraestrutura como Código (IaC)
- Facilitar a criação e evolução da infraestrutura
- Permitir reprodutibilidade dos ambientes
- Manter controle de versão da infraestrutura
- Automatizar deploys em nuvem utilizando pipelines

Toda a arquitetura é organizada de forma modular e escalável, seguindo padrões amplamente usados no mercado.

---

## 🛠️ Tecnologias Utilizadas

- **Terraform**
- **Azure / AWS** (dependendo do módulo do curso)
- **Azure CLI / AWS CLI**
- **GitHub Actions** (opcional para automação)
- **Infraestrutura como Código (IaC)**

---

# 🚀 Como executar o Terraform

Siga os passos abaixo para rodar essa infraestrutura localmente ou em CI/CD.

---

## ✔️ 1. Instale as dependências

### Terraform  
Baixe e instale:  
https://developer.hashicorp.com/terraform/downloads

### Azure CLI  
https://learn.microsoft.com/cli/azure/install-azure-cli

### AWS CLI (se aplicável)  
https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

---

## ✔️ 2. Autenticação na nuvem

Dependendo do provedor que você está utilizando:

---

### 🟦 Azure (via Service Principal recomendado)

```bash
az login --service-principal \
  --username <APP_ID> \
  --password <CLIENT_SECRET> \
  --tenant <TENANT_ID>
```

---

## Arquitetura da Infraestrutura

A estrutura ficou assim:

```text
Azure Subscription
└── Resource Group: rg-fiap-tech-challange-fase-4
    │
    ├── Região eastus2
    │   │
    │   ├── VNet principal: vnet-fiap-tech
    │   │   ├── snet-public-1     10.0.1.0/24
    │   │   └── snet-private-1    10.0.3.0/24
    │   │        │
    │   │        ├── Private Endpoint PostgreSQL auth
    │   │        ├── Private Endpoint PostgreSQL flag
    │   │        └── Private Endpoint PostgreSQL targeting
    │   │
    │   ├── Redis
    │   ├── Cosmos DB Table
    │   ├── Storage Queue
    │   ├── Storage Account do tfstate
    │   └── ACR: toggleacrfase4.azurecr.io
    │
    ├── Região centralus
    │   │
    │   ├── VNet AKS: vnet-fiap-tech-aks
    │   │   └── snet-aks-private  10.2.1.0/24
    │   │        └── AKS: aks-togglemaster
    │   │
    │   ├── PostgreSQL auth
    │   ├── PostgreSQL flag
    │   └── PostgreSQL targeting
    │
    └── Private DNS Zone
        └── privatelink.postgres.database.azure.com
            ├── link com vnet-fiap-tech
            └── link com vnet-fiap-tech-aks
```

O desenho do tráfego fica assim:

```text
Pods no AKS
   │
   │ DNS: pg-flag-togglemaster-fase4.postgres.database.azure.com
   ▼
Private DNS Zone
privatelink.postgres.database.azure.com
   │
   │ resolve para IP privado do Private Endpoint
   ▼
VNet AKS - centralus
10.2.0.0/16
   │
   │ VNet Peering
   ▼
VNet principal - eastus2
10.0.0.0/16
   │
   ▼
Private Endpoint PostgreSQL
10.0.3.x
   │
   │ Azure Private Link
   ▼
PostgreSQL Flexible Server
centralus
```

Em palavras simples: o AKS ficou em `centralus` porque `eastus2` estava recusando os SKUs de VM. Para ele continuar falando com o resto, criamos uma rede própria para o AKS e conectamos essa rede à rede principal com **VNet Peering**.

Os PostgreSQLs estão em `centralus`, mas os **Private Endpoints** deles ficam na subnet privada da VNet principal. Como a VNet do AKS está pareada com a VNet principal e a Private DNS Zone está linkada nas duas VNets, os pods conseguem resolver o nome privado do banco e acessar via IP privado.

Fluxos principais:

```text
AKS -> PostgreSQL
via Private DNS + VNet Peering + Private Endpoint
```

```text
AKS -> Redis
via endpoint público TLS do Redis, por enquanto
```

```text
AKS -> Cosmos DB
via endpoint público do Cosmos, por enquanto
```

```text
AKS -> Storage Queue
via endpoint público do Storage, por enquanto
```

```text
AKS -> ACR
via endpoint público do Azure Container Registry
```

O AKS possui permissão `AcrPull` no ACR pela identidade dos nós, então os pods conseguem puxar imagens sem usuário/senha do registry dentro do Kubernetes. O usuário admin do ACR fica desabilitado com `admin_enabled = false`.
