resource "aws_ses_domain_identity" "ses_domain" {
  for_each = { for domain in var.domain_identities : domain.domain => domain }
  domain   = each.key
}

resource "aws_ses_email_identity" "default" {
  for_each = toset(var.email_identities)
  email    = each.key
}

resource "aws_ses_domain_mail_from" "ses_domain_mail_from" {
  for_each = {
    for domain in var.domain_identities : domain.domain => domain
    if domain.create_domain_mail_from && domain.is_route53
  }
  domain           = aws_ses_domain_identity.ses_domain[each.key].domain
  mail_from_domain = "mail.${aws_ses_domain_identity.ses_domain[each.key].domain}"
}

resource "aws_ses_domain_dkim" "ses_domain_dkim" {
  for_each = { for domain in var.domain_identities : domain.domain => domain }
  domain   = aws_ses_domain_identity.ses_domain[each.key].domain
}

resource "aws_route53_record" "verification_record" {
  for_each = {
    for domain in var.domain_identities : domain.domain => domain
    if domain.create_verification_record && domain.is_route53
  }
  zone_id = data.aws_route53_zone.main[each.key].zone_id
  name    = "_amazonses.${each.key}"
  type    = "TXT"
  ttl     = "600"
  records = [aws_ses_domain_identity.ses_domain[each.key].verification_token]
}

resource "aws_route53_record" "amazonses_dkim_record" {
  count = toset(flatten([
    for domain in var.domain_identities : aws_ses_domain_dkim.ses_domain_dkim[each.key].tokens
  ]))

  # for_each = {
  #   for domain in var.domain_identities : domain.domain => domain
  #   if domain.is_route53
  # }
  zone_id = data.aws_route53_zone.main[each.key].zone_id
  name    = "${each.key}._domainkey"
  type    = "CNAME"
  ttl     = "600"
  records = ["${each.key}.dkim.amazonses.com"]
}

resource "aws_route53_record" "ses_domain_mail_from_mx" {
  for_each = {
    for domain in var.domain_identities : domain.domain => domain
    if domain.create_domain_mail_from_mx && domain.is_route53
  }
  zone_id = data.aws_route53_zone.main[each.key].zone_id
  name    = aws_ses_domain_mail_from.ses_domain_mail_from[each.key].mail_from_domain
  type    = "MX"
  ttl     = "600"
  records = ["10 feedback-smtp.${data.aws_region.current.name}.amazonses.com"]
}

resource "aws_route53_record" "ses_domain_mail_from_txt" {
  for_each = {
    for domain in var.domain_identities : domain.domain => domain
    if domain.create_domain_mail_from_txt && domain.is_route53
  }
  zone_id = data.aws_route53_zone.main[each.key].zone_id
  name    = aws_ses_domain_mail_from.ses_domain_mail_from[each.key].mail_from_domain
  type    = "TXT"
  ttl     = "600"
  records = ["v=spf1 include:amazonses.com ~all"]
}

