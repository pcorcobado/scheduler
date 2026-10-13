variable "aws_region" {
  description = "AWS region for the PoC."
  type        = string
  default     = "eu-west-1"
}

variable "github_repository" {
  description = "GitHub repository in OWNER/REPOSITORY format."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR for the PoC VPC."
  type        = string
  default     = "10.10.0.0/16"
}

variable "certification_subnet_cidr" {
  description = "CIDR for the certification subnet."
  type        = string
  default     = "10.10.10.0/24"
}

variable "preproduction_subnet_cidr" {
  description = "CIDR for the preproduction subnet."
  type        = string
  default     = "10.10.20.0/24"
}

variable "instance_type" {
  description = "Small EC2 instance type. Keep standard CPU credits to avoid T3 Unlimited charges."
  type        = string
  default     = "t3.micro"
}

variable "root_volume_size_gb" {
  description = "Small gp3 root volume."
  type        = number
  default     = 8
}
