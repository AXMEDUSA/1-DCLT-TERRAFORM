variable "location" {
  type    = string
  default = "eastus2"
}

variable "resource_group_name" {
  type    = string
  default = "rg-fiap-tech-challange-fase-3"
}

variable "acr_name" {
  type    = string
  default = "toggleacrfase3" # precisa ser único globalmente
}