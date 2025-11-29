locals {
   databases = {
  #----------------------------------------------------------------------
  # 3 INSTÂNCIAS INDEPENDENTES (Requisito FIAP)
  # Equivalente ao AWS RDS for PostgreSQL
  #
  # ✓ Recurso 1 (PostgreSQL): Para o auth-service
  # ✓ Recurso 2 (PostgreSQL): Para o flag-service
  # ✓ Recurso 3 (PostgreSQL): Para o targeting-service
  #----------------------------------------------------------------------
 
    "auth" = {
      name     = "pgsql-fiap-auth"
      db_name  = "auth_db"
      sku_name = "B_Standard_B1ms"  # Burstable - mais econômico (~$12-15/mês)
    }
    "flag" = {
      name     = "pgsql-fiap-flag"
      db_name  = "flag_db"
      sku_name = "B_Standard_B1ms"
    }
    "targeting" = {
      name     = "pgsql-fiap-targeting"
      db_name  = "targeting_db"
      sku_name = "B_Standard_B1ms"
    }
  }

  # Credenciais do banco (em produção, usar Azure Key Vault)
  db_admin_username = "pgadmin"
  db_admin_password = "F1ap@TechCh4llenge!"  # Trocar em produção!
}
