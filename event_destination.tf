resource "aws_ses_event_destination" "default" {
  for_each               = { for event in var.event_destinations : event.name => event }
  name                   = each.value.name
  configuration_set_name = aws_ses_configuration_set.default[each.value.configuration_set_name].name
  enabled                = true
  matching_types         = each.value.matching_types
  dynamic "sns_destination" {
    for_each = each.value.sns_destination
    content {
      topic_arn = aws_sns_topic.sns[sns_destination.value["name"]].arn
    }
  }
  depends_on = [aws_ses_configuration_set.default]
}
