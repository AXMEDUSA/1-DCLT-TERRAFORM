variable "location" {
  type        = string
  default     = "eastus2"
}

variable "resource_group_name" {
  type        = string
  default     = "rg-fiap-tech-challange"
}

variable "acr_name" {
  type        = string
  default     = "toggleacr" # precisa ser único globalmente
}