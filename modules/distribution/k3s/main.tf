locals {
  install_type = var.node_role
  disk_device  = var.volume_device
  disk_part    = length(regexall("nvme", var.volume_device)) > 0 ? "${var.volume_device}p1" : "${var.volume_device}1"
  disable_config = length(var.disable_components) > 0 ? join("\n", [
    for component in var.disable_components :
    "disable:\n  - ${component}"
  ]) : ""
  base_config = <<-EOF
token: ${var.k3s_token}
write-kubeconfig-mode: "0644"
EOF
  join_config = (
    var.server_url != null && var.node_role == "server"
    ? "server: ${var.server_url}"
    : ""
  )
  final_config = trimspace(
    join("\n", compact([
      local.base_config,
      local.join_config,
      local.disable_config,
      var.k3s_config
    ]))
  )
}

locals {
  install_exec = (
    var.node_role == "server" && var.server_url == null
    ? "server --cluster-init"
    : var.node_role == "server" && var.server_url != null
    ? "server --server ${var.server_url}"
    : "agent"
  )
  service_name = local.install_exec == "agent" ? "k3s-agent" : "k3s"
  user_data    = <<-EOF
#cloud-config
write_files:
  - path: /etc/rancher/k3s/config.yaml
    permissions: "0600"
    content: |
      ${replace(local.final_config, "\n", "\n      ")}
runcmd:
  # Wait volume attachment
  - |
      for i in $(seq 1 60); do
        if [ -b ${local.disk_device} ]; then
          echo "Disk ${local.disk_device} found"
          break
        fi
        echo "Waiting for ${local.disk_device}..."
        sleep 2
      done
  - udevadm settle
  # Partition disk
  - |
      if ! blkid ${local.disk_part}; then
        echo "Partitioning disk..."
        parted ${local.disk_device} --script mklabel gpt
        parted ${local.disk_device} --script mkpart primary xfs 0% 100%
        mkfs.xfs -f ${local.disk_part}
      fi
  - mkdir -p /var/lib/rancher
  - |
      UUID=$(blkid -s UUID -o value ${local.disk_part})
      grep -q "$UUID" /etc/fstab || \
      echo "UUID=$UUID /var/lib/rancher xfs defaults,noatime,nodiratime,nofail,x-systemd.device-timeout=30 0 2" >> /etc/fstab
  - systemctl daemon-reload
  - mount /var/lib/rancher
  - df -h /var/lib/rancher
  - |
      curl -sfL https://get.k3s.io | \
      INSTALL_K3S_VERSION=${var.k3s_version} \
      INSTALL_K3S_EXEC="${local.install_exec}" \
      sh -
  - |
      for i in $(seq 1 60); do
        if [ -f /etc/rancher/k3s/k3s.yaml ]; then
          break
        fi
        sleep 2
      done
  - |
      for i in $(seq 1 90); do
        k3s kubectl \
          --kubeconfig /etc/rancher/k3s/k3s.yaml \
          get nodes >/dev/null 2>&1 && break
        sleep 2
      done
EOF
}
