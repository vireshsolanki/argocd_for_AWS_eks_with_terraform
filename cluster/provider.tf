terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
        helm = {
      source  = "hashicorp/helm"
      version = "2.10.1"
        }
  }
}

provider "aws" {
  region = var.region
}

provider "kubernetes" {
  config_path = "~/.kube/config"  
}

provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
    }
}


