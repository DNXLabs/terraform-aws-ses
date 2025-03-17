variable "domain" {
  type        = string
  description = "The domain name to assign to SES"
}

variable "email_identities" {
  type        = list(string)
  description = ""
  default     = []
}

variable "create_domain_mail_from" {
  type        = bool
  description = "Messages sent through Amazon SES will be marked as originating from your domain instead of a subdomain of amazon.com."
  default     = true
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

variable "is_route53" {
  type        = bool
  description = "Enable or disable route53 zone retriever"
  default     = true
}

variable "configuration_sets" {
  type = list(object({
    name            = string
    redirect_domain = string
  }))
  description = ""
  default     = []
}
