variable "suse_observability_enabled" {
  description = "Specifies whether SUSE Observability should be installed on the Kubernetes cluster. Default is 'false'."
  type        = bool
  default     = false
}

variable "suse_observability_host" {
  description = "Specifies the hostname used to expose SUSE Observability via Ingress (e.g. sslip.io or custom domain). Default is 'null'."
  type        = string
  default     = null
}

variable "suse_observability_version" {
  description = "Specifies the SUSE Observability Helm chart version to install. Default is 'null' (latest version)."
  type        = string
  default     = null
}

variable "suse_observability_license" {
  description = "Specifies the SUSE Observability license key required for installation. Default is 'null'."
  type        = string
  default     = null
  sensitive   = true
  validation {
    condition = (
      var.suse_observability_enabled == false ||
      (
        var.suse_observability_license != null &&
        length(var.suse_observability_license) > 0
      )
    )
    error_message = "When suse_observability_enabled is true, suse_observability_license must be specified."
  }
}

variable "suse_observability_admin_password" {
  description = "Specifies the SUSE Observability administrator password used during installation. Must be at least 12 characters when enabled. Default is 'null'."
  type        = string
  default     = null
  sensitive   = true
  validation {
    condition = (
      var.suse_observability_enabled == false ||
      (
        var.suse_observability_admin_password != null &&
        length(var.suse_observability_admin_password) >= 12
      )
    )
    error_message = "When enabled is true, suse_observability_admin_password must be specified and contain at least 12 characters."
  }
}

variable "kubeconfig_path" {
  description = "Path to kubeconfig file used by kubectl. Default is 'null'."
  type        = string
  default     = null
}
