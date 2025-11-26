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
