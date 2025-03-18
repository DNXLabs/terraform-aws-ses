data "aws_region" "current" {}

data "aws_route53_zone" "main" {
  for_each = { for domain in var.var.domain_identities : domain.domain => domain }
  name     = each.key
}

