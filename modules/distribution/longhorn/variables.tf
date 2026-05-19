variable "longhorn_enabled" {
  description = "Specifies whether Longhorn should be installed on the Kubernetes cluster. Default is 'false'."
  type        = bool
  default     = false
}

variable "longhorn_host" {
  description = "Specifies the hostname used to expose Longhorn via Ingress (e.g. sslip.io or custom domain). Default is 'null'."
  type        = string
  default     = null
}

variable "node_ips" {
  description = "Specifies the list of node public IP addresses used to prepare Longhorn dependencies on each cluster node. Default is 'null'."
  type        = list(string)
  default     = []
}

variable "ssh_private_key" {
  description = "Specifies the SSH private key content used to connect to cluster nodes for Longhorn dependency preparation. Default is 'true'."
  type        = string
  sensitive   = true
}

variable "ssh_user" {
  description = "Specifies the SSH username used to connect to cluster nodes. Default is 'opensuse'."
  type        = string
  default     = "opensuse"
}

variable "longhorn_version" {
  description = "Specifies the Longhorn Helm chart version to install. Default is null (latest version). Default is 'null'."
  type        = string
  default     = null
}

variable "kubeconfig_path" {
  description = "Path to kubeconfig file used by kubectl. Default is 'null'."
  type        = string
  default     = null
}
