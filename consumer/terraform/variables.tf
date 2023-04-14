variable "repository_name" {
  type = string
}

variable "aca_environment_id" {
  type = string
}

variable "aca_user_identity_id" {
  type = string
}

variable "acr_url" {
  type = string
}

variable "build_number" {
  type = string
}

variable "cpu" {
  type = number
}

variable "memory" {
  type = string
}

variable "liveness_probe_path" {
  type = string
}

variable "readiness_probe_path" {
  type = string
}

variable "startup_probe_path" {
  type = string
}

variable "cron_jobs" {
  type = list(object({
    name     = string
    schedule = string
  }))
}
