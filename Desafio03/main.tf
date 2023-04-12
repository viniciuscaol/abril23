terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.27.1"
    }
  }
}

provider "digitalocean" {
    token = file("~/devops/terraform/do_token vinicius@telemedicina.com.br.txt")
}

resource "digitalocean_kubernetes_cluster" "desafio03" {
  name   = "elite"
  region = var.region
  version = "1.26.3-do.0"

  node_pool {
    name       = "worker-pool"
    size       = "s-2vcpu-4gb"
    node_count = 2
  }
}

resource "local_file" "kube_config" {
  content  = digitalocean_kubernetes_cluster.desafio03.kube_config.0.raw_config
  filename = "/home/vinicius/devops/terraform/kube_config.yaml"
}

resource "null_resource" "kubeconfig" {
  provisioner "local-exec" {
    command = "./kubeconfig.sh"
  }
  depends_on = [
    local_file.kube_config
  ]
}