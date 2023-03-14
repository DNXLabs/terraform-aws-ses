variable "domain" {
  type        = string
  description = "The domain name to assign to SES"
}

variable "create_domain_mail_from_mx" {
  type        = bool
  description = "Create route53 MX record"
  default     = false
}
variable "create_domain_mail_from_txt" {
  type        = bool
  description = "Create route 53 TXT record"
  default     = false
}

variable "create_amazonses_verification_record" {
  type        = bool
  description = "Create route 53 verification record for ses"
  default     = false
}