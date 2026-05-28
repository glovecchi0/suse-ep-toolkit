# suse-ep-toolkit

A modular Terraform/OpenTofu toolkit for deploying and managing SUSE Emerging Products tools on cloud providers.

The project provides reusable infrastructure and distribution modules for deploying Kubernetes clusters and SUSE Emerging Products components such as NeuVector and SUSE Observability.

## Why?

To simplify the deployment of complete SUSE Emerging Products environments on cloud providers using reusable and composable Terraform/OpenTofu modules.

The toolkit focuses on:

- Rapid Kubernetes cluster provisioning
- SUSE Emerging Products integration
- Infrastructure modularity
- Reusable deployment recipes
- Easy lab and PoC environments
- Cloud-native automation

:warning: **Not intended for production use.**

## Currently supported components

### Kubernetes Distribution

- RKE2

### SUSE Products

- Rancher 
- Longhorn

### SUSE Emerging Products

- NeuVector
- SUSE Observability

### Infrastructure Providers

- DigitalOcean

## How the repository is structured

```console
.
├── modules/
│   ├── custom-os-image/
│   ├── distribution/
│   │   ├── longhorn/
│   │   ├── neuvector/
│   │   ├── rancher/
│   │   ├── rke2/
│   │   └── suse-observability/
│   ├── identity/
│   │   └── ssh/
│   └── infrastructure/
│       └── digitalocean/
├── projects/
│   └── digitalocean/
│       └── rke2/
└── README.md
```

The `modules/` directory contains reusable Terraform/OpenTofu modules organized by category:

- `distribution/` contains Kubernetes and SUSE platform deployment modules
- `infrastructure/` contains cloud provider infrastructure modules
- `identity/` contains identity and SSH-related modules
- `custom-os-image/` contains modules used to prepare and manage custom operating system images

The `projects/` directory combines multiple modules together to provide ready-to-use deployment recipes for specific environments and use cases.

## Available modules

### Distribution modules

- `rke2`
- `rancher`
- `longhorn`
- `neuvector`
- `suse-observability`

### Infrastructure modules

- `digitalocean/droplet`

### Identity modules

- `ssh`

## Documentation

Each module contains its own `docs.md` file with:
- Usage examples
- Variables description
- Outputs
- Configuration notes
- Deployment requirements

## Available projects

### DigitalOcean

- `projects/digitalocean/rke2`

This project can deploy:

- Single-node RKE2 clusters
- Multi-node HA RKE2 clusters
- Longhorn storage
- Rancher
- NeuVector
- SUSE Observability

using DigitalOcean Droplets.

## Features

- Modular architecture
- Terraform and OpenTofu compatible
- Multi-node RKE2 support
- Automatic TLS generation
- Traefik ingress integration
- Longhorn persistent storage
- Rancher integration
- NeuVector Rancher SSO integration
- Longhorn UI basic authentication
- Customizable Helm chart versions
- Cloud-init support
- Custom OS image support

## Getting started

Example:

```bash
cd projects/digitalocean/rke2

cp terraform.tfvars.example terraform.tfvars

terraform init
terraform plan
terraform apply
```

## Requirements

- Terraform or OpenTofu
- kubectl
