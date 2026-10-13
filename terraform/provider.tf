provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project   = "github-aws-oidc-poc"
      ManagedBy = "terraform"
      Purpose   = "OIDC-lab"
    }
  }
}
