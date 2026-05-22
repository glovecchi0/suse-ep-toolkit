resource "helm_release" "suse_observability" {
  count            = var.suse_observability_enabled ? 1 : 0
  depends_on       = [null_resource.suse_obs_tls_secret]
  name             = "suse-observability"
  repository       = "https://charts.rancher.com/server-charts/prime/suse-observability"
  chart            = "suse-observability"
  namespace        = "suse-observability"
  create_namespace = true
  version          = var.suse_observability_version
  values = [
    <<EOF
global:
  suseObservability:
    license: "${var.suse_observability_license}"
    baseUrl: "https://${var.suse_observability_host}"
    adminPassword: "${var.suse_observability_admin_password}"
    sizing:
      profile: "${var.suse_observability_profile}"

ingress:
  enabled: true
  ingressClassName: traefik
  hosts:
    - host: ${var.suse_observability_host}
      paths:
        - /
  tls:
    - secretName: suse-observability-tls
      hosts:
        - ${var.suse_observability_host}
EOF
  ]
}
