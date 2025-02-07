data "aws_caller_identity" "current" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.0"

  name               = "${var.cluster_name}-vpc"
  cidr               = var.vpc_cidr
  private_subnets    = var.private_subnets
  enable_nat_gateway = true
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.30.2"

  cluster_name    = var.cluster_name
  cluster_version = "1.24"
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnets

  eks_managed_node_groups = {
    eks-workers = {
      min_size      = 1
      max_size      = 2
      desired_size  = 1
      instance_type = "t3.medium"
    }
  }
}

resource "helm_release" "atlantis" {
  name             = "atlantis"
  repository       = "https://runatlantis.github.io/helm-charts"
  chart            = "atlantis"
  namespace        = "atlantis"
  create_namespace = true

  set {
    name  = "github.user"
    value = var.github_user
  }
  set {
    name  = "github.token"
    value = var.github_token
  }
  set {
    name  = "orgWhitelist"
    value = "github.com/${var.github_user}"
  }
  set {
    name  = "repoWhitelist"
    value = "github.com/${var.github_user}/${var.github_repo}"
  }

  provider = kubernetes.eks
}
