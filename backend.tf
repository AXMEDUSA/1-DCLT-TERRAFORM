# terraform {
#   backend "azurerm" {
#     resource_group_name  = "rg-fiap-tech-challange"
#     storage_account_name = "safiaptechchallangetf"
#     container_name       = "tfstate"
#     key                  = "infra.tfstate"
#     client_id            = "6d42ea56-d5fa-455f-91b2-07744a7c70c1"
#     tenant_id            = "e11b1da1-3dbf-4c35-ad1d-2401fc59ba12"
#   }
# }