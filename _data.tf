data "aws_region" "current" {}

data "aws_route53_zone" "main" {
  count = var.is_route53 == false ? 0 : 1
  name = var.domain
}