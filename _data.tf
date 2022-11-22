data "aws_region" "current" {}

data "aws_route53_zone" "main" {
  name = var.domain
}