resource "azurerm_container_app" "aca" {
  count                        = var.cron_expression == "" ? 1 : 0
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

    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }
}

resource "azurerm_container_app" "aca_cron" {
  count                        = var.cron_expression != "" ? 1 : 0
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

  dapr {
    app_id = var.repository_name
  }
}

resource "azurerm_container_app_environment_dapr_component" "dapr_cronjob_bindings" {
  count = var.cron_expression != "" ? 1 : 0

  name                         = "recipes"
  container_app_environment_id = var.aca_environment_id
  component_type               = "bindings.cron"
  version                      = "v1"
  scopes                       = [azurerm_container_app.aca_cron[0].name]

  metadata {
    name  = "schedule"
    value = var.cron_expression
  }
}
