module "this" {
  source = "./module/"

  azure_tenant_id                = var.azure_tenant_id
  azure_subscription_id          = var.azure_subscription_id
  azure_client_id                = var.azure_client_id
  azure_client_secret            = var.azure_client_secret
  azure_infrastructure_subnet_id = var.azure_infrastructure_subnet_id

  docuseal_secret_key_base              = var.docuseal_secret_key_base
  docuseal_postgresql_connection_string = var.docuseal_postgresql_connection_string
  docuseal_smtp_username                = var.docuseal_smtp_username
  docuseal_smtp_address                 = var.docuseal_smtp_address
  docuseal_smtp_port                    = var.docuseal_smtp_port
  docuseal_smtp_domain                  = var.docuseal_smtp_domain
  docuseal_smtp_password                = var.docuseal_smtp_password
  docuseal_smtp_authentication          = var.docuseal_smtp_authentication
  docuseal_smtp_from                    = var.docuseal_smtp_from
  docuseal_azure_storage_account_name   = var.docuseal_azure_storage_account_name
  docuseal_azure_container              = var.docuseal_azure_container

  # azure_ca_max_replicas = 
  # azure_ca_min_replicas = 
  # azure_ca_container_vcpu = 
  # azure_ca_container_mem = 
}
