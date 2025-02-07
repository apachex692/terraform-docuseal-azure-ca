resource "azurerm_resource_group" "this" {
  name     = "attack-docuseal"
  location = "UK South"
  tags     = var.azure_tags
}

resource "azurerm_log_analytics_workspace" "this" {
  name                = "attack-docuseal-log-analytics-workspace"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = var.azure_tags
}

resource "azurerm_container_app_environment" "this" {
  name                       = "attack-docuseal-cae"
  location                   = azurerm_resource_group.this.location
  resource_group_name        = azurerm_resource_group.this.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id

  logs_destination         = "log-analytics"
  infrastructure_subnet_id = var.azure_infrastructure_subnet_id # Production VNet
  tags                     = var.azure_tags

  workload_profile {
    name                  = "Consumption"
    workload_profile_type = "Consumption"
    maximum_count         = 1
    minimum_count         = 1
  }
}

resource "azurerm_container_app" "this" {
  name                         = "docuseal-container-app"
  container_app_environment_id = azurerm_container_app_environment.this.id
  resource_group_name          = azurerm_resource_group.this.name
  revision_mode                = "Single"
  tags                         = var.azure_tags

  template {
    max_replicas = var.azure_ca_max_replicas
    min_replicas = var.azure_ca_min_replicas

    container {
      name   = "docuseal"
      image  = "docker.io/docuseal/docuseal:1.8.9"
      cpu    = var.azure_ca_container_vcpu
      memory = var.azure_ca_container_mem

      env {
        name        = "SECRET_KEY_BASE"
        secret_name = "secret-key-base"
      }

      env {
        name        = "DATABASE_URL"
        secret_name = "database-url"
      }

      env {
        name        = "SMTP_USERNAME"
        secret_name = "smtp-username"
      }

      env {
        name  = "SMTP_ADDRESS"
        value = var.docuseal_smtp_address
      }

      env {
        name  = "SMTP_PORT"
        value = var.docuseal_smtp_port
      }

      env {
        name  = "SMTP_DOMAIN"
        value = var.docuseal_smtp_domain
      }

      env {
        name        = "SMTP_PASSWORD"
        secret_name = "smtp-password"
      }

      env {
        name  = "SMTP_AUTHENTICATION"
        value = var.docuseal_smtp_authentication
      }

      env {
        name  = "SMTP_FROM"
        value = var.docuseal_smtp_from
      }

      env {
        name  = "AZURE_STORAGE_ACCOUNT_NAME"
        value = var.docuseal_azure_storage_account_name
      }

      env {
        name  = "AZURE_CONTAINER"
        value = var.docuseal_azure_container
      }

      env {
        name        = "AZURE_STORAGE_ACCESS_KEY"
        secret_name = "azure-storage-access-key"
      }

      liveness_probe {
        transport        = "HTTP"
        port             = 3000
        path             = "/"
        interval_seconds = 60
      }

      readiness_probe {
        transport = "HTTP"
        port      = 3000
        path      = "/"
      }
    }

    http_scale_rule {
      name                = "attack-docuseal-http-scale-rule"
      concurrent_requests = 10
    }
  }

  ingress {
    allow_insecure_connections = false
    external_enabled           = true

    target_port = 3000
    transport   = "auto"

    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }

  secret {
    name  = "secret-key-base"
    value = var.docuseal_secret_key_base
  }

  secret {
    name  = "database-url"
    value = var.docuseal_postgresql_connection_string
  }

  secret {
    name  = "smtp-username"
    value = var.docuseal_smtp_username
  }

  secret {
    name  = "smtp-password"
    value = var.docuseal_smtp_password
  }

  secret {
    name  = "azure-storage-access-key"
    value = azurerm_storage_account.this.primary_access_key
  }
}
