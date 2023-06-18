resource "azurerm_container_app" "aca" {
  name                         = var.http_stub_server_name
  container_app_environment_id = var.aca_environment_id
  resource_group_name          = var.resource_group_name
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
      name   = "http-stub-server"
      image  = "${var.acr_url}/http-stub-server:latest"
      cpu    = 0.25
      memory = "0.5Gi"
    }

    container {
      name   = "http-stub-server-proxy"
      image  = "${var.acr_url}/http-stub-server-proxy:latest"
      cpu    = 0.25
      memory = "0.5Gi"
    }
  }

  ingress {
    allow_insecure_connections = false
    external_enabled           = true
    target_port                = 80
    transport                  = "auto"

    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }
}
