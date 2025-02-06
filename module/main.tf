resource "azurerm_resource_group" "this" {
  name     = "attack-docuseal"
  location = "UK South"
}

resource "azurerm_log_analytics_workspace" "this" {
  name                = "attack-docuseal-log-analytics-workspace"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_container_app_environment" "this" {
  name                       = "attack-docuseal-cae"
  location                   = azurerm_resource_group.this.location
  resource_group_name        = azurerm_resource_group.this.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id

  logs_destination         = "log-analytics"
  infrastructure_subnet_id = var.azure_infrastructure_subnet_id # Production VNet

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

      liveness_probe {
        transport = "HTTP"
        port      = 3000
        path      = "/"
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

  secret {
    name  = "secret-key-base"
    value = var.docuseal_secret_key_base
  }

  secret {
    name  = "database-url"
    value = var.docuseal_postgresql_connection_string
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
}
