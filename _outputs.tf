output "amazonses_dkim_record" {
  #   value = join("", aws_ses_domain_dkim.ses_domain_dkim.dkim_tokens) + ".dkim.amazonses.com"
  value = aws_ses_domain_dkim.ses_domain_dkim
}

output "amazonses_verification_record" {
  value = join("", aws_ses_domain_identity.ses_domain.*.verification_token)
}

output "ses_domain_mail_from_mx" {
  value = ["10 feedback-smtp.${data.aws_region.current.name}.amazonses.com"]
}

output "ses_domain_mail_from_txt" {
  value = ["v=spf1 include:amazonses.com ~all"]
}
