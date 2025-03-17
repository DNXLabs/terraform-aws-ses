resource "aws_ses_configuration_set" "default" {
  for_each                   = { for config in var.configuration_sets : config.name => config }
  name                       = each.value.name
  reputation_metrics_enabled = false
  sending_enabled            = true
  tracking_options {
    custom_redirect_domain = each.value.redirect_domain
  }
}
