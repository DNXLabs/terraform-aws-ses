resource "aws_ses_receipt_rule_set" "rule" {
  for_each      = { for sets in var.receipt_rule_sets : sets.name => sets }
  rule_set_name = each.key
}

resource "aws_ses_receipt_rule" "lambda_rule" {
  for_each      = { for receipt_rule in var.receipt_rules : receipt_rule.name => receipt_rule }
  name          = each.value.name
  rule_set_name = each.value.rule_set_name
  enabled       = each.value.enabled
  recipients    = each.value.recipients
  scan_enabled  = true

  dynamic "lambda_action" {
    for_each = each.value.lambda_actions
    content {
      function_arn    = lambda_action.value.function_arn
      position        = lambda_action.value.position
      invocation_type = lambda_action.value.invocation_type
    }
  }
  dynamic "s3_action" {
    for_each = each.value.s3_actions
    content {
      position    = s3_action.value.position
      bucket_name = s3_action.value.bucket_name
    }
  }
  dynamic "stop_action" {
    for_each = each.value.stop_actions
    content {
      position = stop_action.value.position
      scope    = stop_action.value.scope
    }
  }
}
