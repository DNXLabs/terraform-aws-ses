# terraform-aws-ses

[![Lint Status](https://github.com/DNXLabs/terraform-aws-ses/workflows/Lint/badge.svg)](https://github.com/DNXLabs/terraform-aws-ses/actions)
[![LICENSE](https://img.shields.io/github/license/DNXLabs/terraform-aws-ses)](https://github.com/DNXLabs/terraform-aws-ses/blob/master/LICENSE)

<!--- BEGIN_TF_DOCS --->

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create\_amazonses\_verification\_record | Create route 53 verification record for ses | `bool` | `false` | no |
| create\_domain\_mail\_from | Messages sent through Amazon SES will be marked as originating from your domain instead of a subdomain of amazon.com. | `bool` | `true` | no |
| create\_domain\_mail\_from\_mx | Create route53 MX record | `bool` | `false` | no |
| create\_domain\_mail\_from\_txt | Create route 53 TXT record | `bool` | `false` | no |
| domain | The domain name to assign to SES | `string` | n/a | yes |
| is\_route53 | Enable or disable route53 zone retriever | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| amazonses\_dkim\_record | n/a |
| amazonses\_verification\_record | n/a |
| ses\_domain\_mail\_from\_mx | n/a |
| ses\_domain\_mail\_from\_txt | n/a |

<!--- END_TF_DOCS --->

## Authors

Module managed by [DNX Solutions](https://github.com/DNXLabs).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/DNXLabs/terraform-aws-template/blob/master/LICENSE) for full details.