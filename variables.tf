variable "azure_subscription_id" {
  type      = string
  sensitive = true
}

variable "azure_tenant_id" {
  type      = string
  sensitive = true
}

variable "azure_client_id" {
  type      = string
  sensitive = true
}

variable "azure_client_secret" {
  type      = string
  sensitive = true
}

variable "azure_infrastructure_subnet_id" {
  type      = string
  sensitive = true
}

variable "docuseal_secret_key_base" {
  type      = string
  sensitive = true
}

variable "docuseal_postgresql_connection_string" {
  type      = string
  sensitive = true
}
