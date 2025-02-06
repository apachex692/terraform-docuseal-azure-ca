module "this" {
  source = "./module/"

  azure_tenant_id                = var.azure_tenant_id
  azure_subscription_id          = var.azure_subscription_id
  azure_client_id                = var.azure_client_id
  azure_client_secret            = var.azure_client_secret
  azure_infrastructure_subnet_id = var.azure_infrastructure_subnet_id

  docuseal_secret_key_base              = var.docuseal_secret_key_base
  docuseal_postgresql_connection_string = var.docuseal_postgresql_connection_string

  # azure_ca_max_replicas = 
  # azure_ca_min_replicas = 

  # azure_ca_container_vcpu = 
  # azure_ca_container_mem = 
}
