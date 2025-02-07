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

variable "docuseal_smtp_username" {
  type      = string
  sensitive = true
}

variable "docuseal_smtp_address" {
  type = string
}

variable "docuseal_smtp_port" {
  type = number
}

variable "docuseal_smtp_domain" {
  type = string
}

variable "docuseal_smtp_password" {
  type      = string
  sensitive = true
}

variable "docuseal_smtp_authentication" {
  type = string
}

variable "docuseal_smtp_from" {
  type = string
}

variable "docuseal_azure_storage_account_name" {
  type = string
}

variable "docuseal_azure_container" {
  type = string
}
