variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "eu-north-1"
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default     = "atlantis-eks"
}

variable "github_user" {
  description = "GitHub username for Atlantis configuration"
  type        = string
}

variable "github_token" {
  description = "GitHub personal access token for Atlantis"
  type        = string
  sensitive   = true
}

variable "github_repo" {
  description = "GitHub repository name for Atlantis to monitor"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "private_subnets" {
  description = "List of private subnets for the VPC"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "eks_admin_role_name" {
  description = "Name of the IAM role for EKS admin access"
  type        = string
  default     = "eks-admin"
}

variable "eks_read_only_role_name" {
  description = "Name of the IAM role for EKS read-only access"
  type        = string
  default     = "eks-read-only"
}
