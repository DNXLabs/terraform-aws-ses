resource "aws_ses_domain_identity" "ses_domain" {
  domain = var.domain
}

resource "aws_ses_domain_mail_from" "ses_domain_mail_from" {
  count = var.create_domain_mail_from ? 1: 0
  domain           = aws_ses_domain_identity.ses_domain.domain
  mail_from_domain = "mail.${aws_ses_domain_identity.ses_domain.domain}"
}

resource "aws_ses_domain_dkim" "ses_domain_dkim" {
  domain = join("", aws_ses_domain_identity.ses_domain.*.domain)
}

resource "aws_route53_record" "amazonses_verification_record" {
  count   = (var.is_route53 && var.create_amazonses_verification_record ? 1 : 0)
  zone_id = data.aws_route53_zone.main[count.index].zone_id
  name    = "_amazonses.${var.domain}"
  type    = "TXT"
  ttl     = "600"
  records = [join("", aws_ses_domain_identity.ses_domain.*.verification_token)]
}

resource "aws_route53_record" "amazonses_dkim_record" {
  count   = var.is_route53 ? 3 : 0
  zone_id = data.aws_route53_zone.main[0].zone_id
  name    = "${aws_ses_domain_dkim.ses_domain_dkim.dkim_tokens[count.index]}._domainkey"
  type    = "CNAME"
  ttl     = "600"
  records = ["${aws_ses_domain_dkim.ses_domain_dkim.dkim_tokens[count.index]}.dkim.amazonses.com"]
}

resource "aws_route53_record" "ses_domain_mail_from_mx" {
  count   = (var.is_route53 && var.create_domain_mail_from && var.create_domain_mail_from_mx ? 1 : 0)
  zone_id = data.aws_route53_zone.main[count.index].zone_id
  name    = aws_ses_domain_mail_from.ses_domain_mail_from[0].mail_from_domain
  type    = "MX"
  ttl     = "600"
  records = ["10 feedback-smtp.${data.aws_region.current.name}.amazonses.com"]
}

resource "aws_route53_record" "ses_domain_mail_from_txt" {
  count   = (var.is_route53 && var.create_domain_mail_from && var.create_domain_mail_from_txt ? 1 : 0)
  zone_id = data.aws_route53_zone.main[0].zone_id
  name    = aws_ses_domain_mail_from.ses_domain_mail_from[0].mail_from_domain
  type    = "TXT"
  ttl     = "600"
  records = ["v=spf1 include:amazonses.com ~all"]
}

