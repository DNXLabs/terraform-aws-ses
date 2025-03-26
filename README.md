## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.91.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_route53_record.amazonses_dkim_record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.amazonses_verification_record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.ses_domain_mail_from_mx](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.ses_domain_mail_from_txt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_ses_configuration_set.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_configuration_set) | resource |
| [aws_ses_domain_dkim.ses_domain_dkim](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_dkim) | resource |
| [aws_ses_domain_identity.ses_domain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_identity) | resource |
| [aws_ses_domain_mail_from.ses_domain_mail_from](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_mail_from) | resource |
| [aws_ses_email_identity.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_email_identity) | resource |
| [aws_ses_event_destination.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_event_destination) | resource |
| [aws_ses_receipt_rule.lambda_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_receipt_rule) | resource |
| [aws_ses_receipt_rule_set.rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_receipt_rule_set) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_route53_zone.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_configuration_sets"></a> [configuration\_sets](#input\_configuration\_sets) | Configuration Sets for SES | <pre>list(object({<br/>    name            = string<br/>    redirect_domain = string<br/>  }))</pre> | `[]` | no |
| <a name="input_create_amazonses_verification_record"></a> [create\_amazonses\_verification\_record](#input\_create\_amazonses\_verification\_record) | Create route 53 verification record for ses | `bool` | `false` | no |
| <a name="input_create_domain_mail_from"></a> [create\_domain\_mail\_from](#input\_create\_domain\_mail\_from) | Messages sent through Amazon SES will be marked as originating from your domain instead of a subdomain of amazon.com. | `bool` | `true` | no |
| <a name="input_create_domain_mail_from_mx"></a> [create\_domain\_mail\_from\_mx](#input\_create\_domain\_mail\_from\_mx) | Create route53 MX record | `bool` | `false` | no |
| <a name="input_create_domain_mail_from_txt"></a> [create\_domain\_mail\_from\_txt](#input\_create\_domain\_mail\_from\_txt) | Create route 53 TXT record | `bool` | `false` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | The domain name to assign to SES | `string` | n/a | yes |
| <a name="input_email_identities"></a> [email\_identities](#input\_email\_identities) | n/a | `list(string)` | `[]` | no |
| <a name="input_event_destinations"></a> [event\_destinations](#input\_event\_destinations) | Event destinations for SES | <pre>list(object({<br/>    name                   = string<br/>    configuration_set_name = string<br/>    enabled                = optional(bool, true)<br/>    matching_types         = list(string)<br/>    sns_destination        = optional(any, [])<br/>  }))</pre> | `[]` | no |
| <a name="input_is_route53"></a> [is\_route53](#input\_is\_route53) | Enable or disable route53 zone retriever | `bool` | `true` | no |
| <a name="input_receipt_rule_sets"></a> [receipt\_rule\_sets](#input\_receipt\_rule\_sets) | n/a | `list(string)` | `[]` | no |
| <a name="input_receipt_rules"></a> [receipt\_rules](#input\_receipt\_rules) | n/a | <pre>list(object({<br/>    name          = string<br/>    rule_set_name = string<br/>    enabled       = bool<br/>    recipients    = list(string)<br/>    lambda_actions = optional(list(object({<br/>      function_arn    = string<br/>      position        = number<br/>      invocation_type = string<br/>    })), [])<br/>    s3_actions = optional(list(object({<br/>      position    = number<br/>      bucket_name = string<br/>    })), [])<br/>    stop_actions = optional(list(object({<br/>      position = number<br/>      scope    = string<br/>    })), [])<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_amazonses_dkim_record"></a> [amazonses\_dkim\_record](#output\_amazonses\_dkim\_record) | n/a |
| <a name="output_amazonses_verification_record"></a> [amazonses\_verification\_record](#output\_amazonses\_verification\_record) | n/a |
| <a name="output_ses_domain_mail_from_mx"></a> [ses\_domain\_mail\_from\_mx](#output\_ses\_domain\_mail\_from\_mx) | n/a |
| <a name="output_ses_domain_mail_from_txt"></a> [ses\_domain\_mail\_from\_txt](#output\_ses\_domain\_mail\_from\_txt) | n/a |
