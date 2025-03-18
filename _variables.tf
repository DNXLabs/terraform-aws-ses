variable "domain_identities" {
  type = list(object({
    domain                      = string
    is_route53                  = optional(bool, true)
    create_domain_mail_from     = optional(bool, true)
    create_verification_record  = optional(bool, true)
    create_domain_mail_from_mx  = optional(bool, true)
    create_domain_mail_from_txt = optional(bool, true)
  }))
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
  description = "Configuration Sets for SES"
  default     = []
  # TO-DO: Add validation for delivery_options.tls_policy. Can be Optional or Require
}

variable "event_destinations" {
  type = list(object({
    name                   = string
    configuration_set_name = string
    enabled                = optional(bool, true)
    matching_types         = list(string)
    sns_destination        = optional(any, [])
  }))
  description = "Event destinations for SES"
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
      for event in var.event_destinations : contains(flatten([for config_set in var.configuration_sets : config_set.name]), event.configuration_set_name)
    ])
  }
}

variable "receipt_rule_sets" {
  type    = list(string)
  default = []
}

variable "receipt_rules" {
  type = list(object({
    name          = string
    rule_set_name = string
    enabled       = bool
    recipients    = list(string)
    lambda_actions = optional(list(object({
      function_arn    = string
      position        = number
      invocation_type = string
    })), [])
    s3_actions = optional(list(object({
      position    = number
      bucket_name = string
    })), [])
    stop_actions = optional(list(object({
      position = number
      scope    = string
    })), [])
  }))
  default = []
  # TO-DO: Add validation if rule_set_name exists
}

