resource "azurerm_container_app" "aca" {
  name                         = var.repository_name
  container_app_environment_id = var.aca_environment_id
  resource_group_name          = "example-platform-azure-kubernetes"
  revision_mode                = "Single"

  identity {
    type         = "UserAssigned"
    identity_ids = [var.aca_user_identity_id]
  }

  registry {
    server   = var.acr_url
    identity = var.aca_user_identity_id
  }

  template {
    container {
      name   = var.repository_name
      image  = "${var.acr_url}/${var.repository_name}:${var.build_number}"
      cpu    = 0.25
      memory = "0.5Gi"

      liveness_probe {
        transport = "HTTP"
        port      = 8080
        path      = "/health"
      }

      readiness_probe {
        transport = "HTTP"
        port      = 8080
        path      = "/health"
      }

      startup_probe {
        transport = "HTTP"
        port      = 8080
        path      = "/health"
      }
    }
  }

  ingress {
    allow_insecure_connections = false
    external_enabled           = true
    target_port                = 8080
    transport                  = "auto"
  }
}
