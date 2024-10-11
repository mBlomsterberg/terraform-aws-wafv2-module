
<br />
<div id="readme-top" align="center">
  <a href="https://github.com/mBlomsterberg/">
    <picture>
      <source srcset="logo_inv.png" media="(prefers-color-scheme: dark)">
      <img src="logo.png" width="200" height="200">
    </picture>
  </a>

  <h3 align="center">terraform-aws-wafv2-module</h3>

  <p align="center">
    Terraform Module for AWS WAFv2 creation.
    <br />
    <br />
    <a href="https://github.com/mBlomsterberg/hanayama-repository-standard">Github Workflows</a>
    ·
    <a href="https://github.com/mBlomsterberg/hanayama-repository-standard">Repository Configuration</a>
    ·
    <a href="https://github.com/mBlomsterberg/hanayama-repository-standard">Versioning</a>
  </p>
  <br />
</div>

<div align="center">
<img src="https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white"><img src="https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white">
</div>
<br>

# About
This Terraform module creates an AWS WAFv2 WebACL with associated rules and conditions. 

## Limitations
1. Regional vs Global rules: This module only supports `regional` rules for now.
2. Recursive rules are not supported by this module(`and_statement`, `not_statement` and `or_statement`).
3. Statements not yet implemented: 
    * `label_match_statement`
    * `regex_match_statement`
    * `size_constraint_statement`
    * `sqli_match_statement`
    * `xss_match_statement`
    * `managed_rule_group_statement`
    * `rule_group_reference_statement`


# Contact 
**Github** [mBlomsterberg](https://github.com/mBlomsterberg) 

# Repository overview
| `File`                        | `description` |
| ------------------            | ------------- |
| .github/ISSUE_TEMPLATE        | Configuring issue templates for your repository |
| .github/pull_request_template.yml | Configuring default PR template for your repository    |
| .github/dependabot.yml        | Customize how Dependabot maintains your repositories  |
| CODE_OF_CONDUCT.md            | Defines standards for how to engage in a community    | 
| CONTRIBUTING.md               | Contribution guidelines to your project's repository  |
| SECURITY.md                   | To give people instructions on how to report security vulnerabilities | 
| SUPPORT.md                    | Let people know about ways to get help with your project  |
| CODEOWNERS                    | Define individuals or teams that are responsible for code in a repository |
| LICENSE                       | A software license tells others what they can and can't do with your source code  |


# Contribution guidelines
Should your repository be open to an external or onboarding new members you can create guidelines to communicate how people should contribute to your project. [Example](https://github.com/github/docs/blob/main/CONTRIBUTING.md).

# Code of Conduct

This project has adopted the Hanayama Co. Code of Conduct. For more information see the Code of Conduct FAQ or contact [mBlomsterberg](https://github.com/mBlomsterberg) with any additional questions or comments.

# License

Copyright (c) mBlomsterberg All rights reserved.

Licensed under the MIT license.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | <= 1.5.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.57.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.57.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_wafv2_web_acl.regional](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_association_config"></a> [association\_config](#input\_association\_config) | (Optional) Configuration block defining the association configuration. | <pre>object({<br/>    request_body = optional(object({<br/>      cloudfront = optional(object({<br/>        default_size_inspection_limit = string<br/>      }), null)<br/>      api_gateway = optional(object({<br/>        default_size_inspection_limit = string<br/>      }), null)<br/>      app_runner_service = optional(object({<br/>        default_size_inspection_limit = string<br/>      }), null)<br/>      cognito_user_pool = optional(object({<br/>        default_size_inspection_limit = string<br/>      }), null)<br/>      verified_access_instance = optional(object({<br/>        default_size_inspection_limit = string<br/>      }), null)<br/>    }), null)<br/>  })</pre> | `null` | no |
| <a name="input_captcha_config"></a> [captcha\_config](#input\_captcha\_config) | (Optional) Configuration block defining the captcha configuration. | <pre>object({<br/>    immunity_time_property = optional(object({<br/>      immunity_time = optional(number, 300)<br/>    }), null)<br/>  })</pre> | `null` | no |
| <a name="input_challenge_config"></a> [challenge\_config](#input\_challenge\_config) | (Optional) Configuration block defining the challenge configuration. | <pre>object({<br/>    immunity_time_property = optional(object({<br/>      immunity_time = optional(number, 300)<br/>    }), null)<br/>  })</pre> | `null` | no |
| <a name="input_custom_response_bodies"></a> [custom\_response\_bodies](#input\_custom\_response\_bodies) | (Optional) Configuration block to define custom response body. | <pre>list(object({<br/>    key          = string<br/>    content      = string<br/>    content_type = string<br/>  }))</pre> | `[]` | no |
| <a name="input_default_action"></a> [default\_action](#input\_default\_action) | (Required) Configuration block defining the default action to take when a request doesn't match any rule. | <pre>object({<br/>    allow = optional(object({<br/>      custom_request_handling = optional(object({<br/>        insert_header = optional(object({<br/>          name  = string<br/>          value = string<br/>        }), null)<br/>      }), null)<br/>    }), null)<br/>    block = optional(object({<br/>      custom_response = optional(object({<br/>        custom_response_body_key = string<br/>        response_code            = string<br/>        response_header          = optional(map(any), null)<br/>      }), null)<br/>    }), null)<br/>  })</pre> | <pre>{<br/>  "allow": null,<br/>  "block": {}<br/>}</pre> | no |
| <a name="input_description"></a> [description](#input\_description) | (Optional) The description of the WAF WebACL. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the WAF WebACL. | `string` | n/a | yes |
| <a name="input_rules"></a> [rules](#input\_rules) | (Optional) Configuration block defining a rule. | <pre>list(object({<br/>    name = string<br/>    captcha_config = optional(object({<br/>      immunity_time_property = optional(object({<br/>        immunity_time = optional(number, 300)<br/>      }), null)<br/>    }), null)<br/><br/>    action = optional(object({<br/>      allow = optional(object({<br/>        custom_request_handling = optional(object({<br/>          insert_header = optional(object({<br/>            name  = string<br/>            value = string<br/>          }), null)<br/>        }), null)<br/>      }), null)<br/>      block = optional(object({<br/>        custom_response = optional(object({<br/>          custom_response_body_key = string<br/>          response_code            = string<br/>          response_header          = optional(map(any), null)<br/>        }), null)<br/>      }), null)<br/>      captcha = optional(object({<br/>        custom_request_handling = optional(object({<br/>          insert_header = optional(object({<br/>            name  = string<br/>            value = string<br/>          }), null)<br/>        }), null)<br/>      }), null)<br/>      challenge = optional(object({<br/>        custom_request_handling = optional(object({<br/>          insert_header = optional(object({<br/>            name  = string<br/>            value = string<br/>          }), null)<br/>        }), null)<br/>      }), null)<br/>      count = optional(object({<br/>        custom_request_handling = optional(object({<br/>          insert_header = optional(object({<br/>            name  = string<br/>            value = string<br/>          }), null)<br/>        }), null)<br/>      }), null)<br/>    }), null)<br/><br/>    priority = number<br/>    override_action = optional(object({<br/>      count = optional(object({}), null)<br/>      none  = optional(object({}), null)<br/>    }), null)<br/>    rule_label = optional(object({<br/>      name = string<br/>    }), null)<br/><br/>    statement = object({<br/>      rate_based_statement = optional(object({<br/>        limit                 = number<br/>        aggregate_key_type    = string<br/>        evaluation_window_sec = optional(number, null)<br/>        custom_key = optional(object({<br/>          cookies           = optional(object({}), null)<br/>          query_string_keys = optional(list(string), null)<br/>          single_header     = optional(list(string), null)<br/>          single_query_arg  = optional(list(string), null)<br/>          uri_path          = optional(list(string), null)<br/>        }), null)<br/>        scope_down_statement = optional(object({<br/>          geo_match_statement = optional(object({<br/>            country_codes = optional(list(string), null)<br/>            forward_ip_config = optional(object({<br/>              header_name = optional(string, null)<br/>              position    = optional(string, null)<br/>            }), null)<br/>          }), null)<br/>          byte_match_statement = optional(object({<br/>            field_to_match = optional(object({<br/>              data = optional(string, null)<br/>              type = optional(string, null)<br/>            }), null)<br/>            positional_constraint = optional(string, null)<br/>            search_string         = optional(string, null)<br/>          }), null)<br/>        }), null)<br/>        forwarded_ip_config = optional(object({<br/>          header_name       = optional(string, null)<br/>          fallback_behavior = optional(string, null)<br/>        }), null)<br/>      }), null)<br/><br/>      ip_set_reference_statement = optional(object({<br/>        arn = string<br/>        forward_ip_config = optional(object({<br/>          header_name       = optional(string, null)<br/>          fallback_behavior = optional(string, null)<br/>        }), null)<br/>      }), null)<br/><br/>      rule_group_reference_statement = optional(object({<br/>        arn = string<br/>        rule_action_override = optional(object({<br/>          name = string<br/>          action_to_use = object({<br/>            allow = optional(object({<br/>              custom_request_handling = optional(object({<br/>                insert_header = optional(object({<br/>                  name  = string<br/>                  value = string<br/>                }), null)<br/>              }), null)<br/>            }), null)<br/>            block = optional(object({<br/>              custom_response = optional(object({<br/>                custom_response_body_key = string<br/>                response_code            = string<br/>                response_header          = optional(map(any), null)<br/>              }), null)<br/>            }), null)<br/>            captcha = optional(object({<br/>              custom_request_handling = optional(object({<br/>                insert_header = optional(object({<br/>                  name  = string<br/>                  value = string<br/>                }), null)<br/>              }), null)<br/>            }), null)<br/>            challenge = optional(object({<br/>              custom_request_handling = optional(object({<br/>                insert_header = optional(object({<br/>                  name  = string<br/>                  value = string<br/>                }), null)<br/>              }), null)<br/>            }), null)<br/>            count = optional(object({<br/>              custom_request_handling = optional(object({<br/>                insert_header = optional(object({<br/>                  name  = string<br/>                  value = string<br/>                }), null)<br/>              }), null)<br/>            }), null)<br/>          })<br/>        }), null)<br/>      }), null)<br/><br/>      byte_match_statement = optional(object({<br/>        field_to_match = optional(object({<br/>            all_query_arguments = optional(object({}), null)<br/>            body = optional(object({<br/>              oversize_handling = optional(string, null)<br/>            }), null)<br/>            cookies = optional(object({<br/>              match_pattern = optional(object({<br/>                all = optional(object({}), null)<br/>                included_cookies = optional(list(string), null)<br/>                excluded_cookies = optional(list(string), null)<br/>              }), null)<br/>              match_scope = optional(string, null)<br/>              oversize_handling = optional(string, null)<br/>            }), null)<br/>            header_order = optional(object({<br/>              oversize_handling = optional(string, null)<br/>            }), null)<br/>            headers = optional(object({<br/>              match_pattern = optional(object({<br/>                all = optional(object({}), null)<br/>                included_headers = optional(list(string), null)<br/>                excluded_headers = optional(list(string), null)<br/>              }), null)<br/>              match_scope = optional(string, null)<br/>              oversize_handling = optional(string, null)<br/>            }), null)<br/>            ja3_fingerprint = optional(object({<br/>              fallback_behavior = string<br/>            }), null)<br/>            json_body = optional(object({<br/>              match_pattern = optional(object({<br/>                all = optional(object({}), null)<br/>                included_paths = optional(list(string), null)<br/>              }), null)<br/>              match_scope = optional(string, null)<br/>              invalid_fallback_behavior = optional(string, null)<br/>              oversize_handling = optional(string, null)<br/>            }), null)<br/>            method = optional(object({}), null)<br/>            query_string = optional(object({<br/>              match_pattern = optional(object({<br/>                all = optional(list(object({})), null)<br/>                included_query_strings = optional(list(string), null)<br/>                excluded_query_strings = optional(list(string), null)<br/>              }), null)<br/>              oversize_handling = optional(string, null)<br/>            }), null)<br/>            single_header = optional(object({<br/>              name = string<br/>            }), null)<br/>            single_query_argument = optional(object({<br/>              name = string<br/>            }), null)<br/>            uri_path = optional(object({}), null)<br/>        }), null)<br/>        positional_constraint = optional(string, null)<br/>        search_string         = optional(string, null)<br/>        text_transformation = optional(list(object({<br/>          priority = optional(number, null)<br/>          type     = optional(string, null)<br/>        })), null)<br/>      }), null)<br/><br/>      geo_match_statement = optional(object({<br/>        country_codes = optional(list(string), null)<br/>        forward_ip_config = optional(object({<br/>          header_name = optional(string, null)<br/>          position    = optional(string, null)<br/>        }), null)<br/>      }), null)<br/>    })<br/><br/>    visibility_config = optional(object({<br/>      cloudwatch_metrics_enabled = optional(bool, false)<br/>      sampled_requests_enabled   = optional(bool, false)<br/>      metric_name                = optional(string, "test_allowed_ips")<br/>    }), null)<br/><br/>  }))</pre> | `null` | no |
| <a name="input_scope"></a> [scope](#input\_scope) | (Optional) The scope of the WAF WebACL. Valid values are REGIONAL or CLOUDFRONT. Defaults to REGIONAL. | `string` | `"REGIONAL"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_visibility_config"></a> [visibility\_config](#input\_visibility\_config) | (Optional) Configuration block to enable CloudWatch metrics and sample requests. | <pre>object({<br/>    cloudwatch_metrics_enabled = bool<br/>    sampled_requests_enabled   = bool<br/>    metric_name                = string<br/>  })</pre> | <pre>{<br/>  "cloudwatch_metrics_enabled": false,<br/>  "metric_name": "test_allowed_ips",<br/>  "sampled_requests_enabled": false<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_application_integration_url"></a> [application\_integration\_url](#output\_application\_integration\_url) | n/a |
| <a name="output_arn"></a> [arn](#output\_arn) | n/a |
| <a name="output_capacity"></a> [capacity](#output\_capacity) | n/a |
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_tags_all"></a> [tags\_all](#output\_tags\_all) | n/a |
<!-- END_TF_DOCS -->