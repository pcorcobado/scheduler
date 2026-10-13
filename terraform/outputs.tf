output "vpc_id" {
  value = aws_vpc.poc.id
}

output "certification_subnet_id" {
  value = aws_subnet.certification.id
}

output "preproduction_subnet_id" {
  value = aws_subnet.preproduction.id
}

output "certification_instance_id" {
  value = aws_instance.certification.id
}

output "preproduction_instance_id" {
  value = aws_instance.preproduction.id
}

output "certification_role_arn" {
  value = aws_iam_role.github_certification.arn
}

output "preproduction_role_arn" {
  value = aws_iam_role.github_preproduction.arn
}

output "github_oidc_provider_arn" {
  value = aws_iam_openid_connect_provider.github.arn
}

output "region" {
  value = var.aws_region
}
