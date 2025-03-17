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

variable "event_destinations" {
  type = list(object({
    name                   = string
    configuration_set_name = string
    enabled                = optional(bool, true)
    matching_types         = list(string)
    sns_destination        = optional(any, [])
  }))
  description = "value"
  default     = []
  validation {
    error_message = "Invalid value for matching_types. Should be one of: send, reject, bounce, complaint, delivery, open, click or renderingFailure"
    condition = alltrue([
      for event in var.event_destinations : alltrue([
        for type in event.matching_types : contains(local.valid_matching_types, type)
      ])
    ])
  }
  validation {
    error_message = "Invalid configuration_set_name."
    condition = alltrue([
      for event in var.event_destinations : contains(flatten([for config_set in var.configuration_sets: config_set.name]), event.configuration_set_name)
    ])
  }
}
