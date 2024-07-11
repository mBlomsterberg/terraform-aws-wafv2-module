
variable "name" {
  type        = string
  description = "(Required) The name of the WAF WebACL."
}

variable "description" {
  type        = string
  default     = null
  description = "(Optional) The description of the WAF WebACL."
}

variable "scope" {
  type        = string
  default     = "REGIONAL"
  description = "(Optional) The scope of the WAF WebACL. Valid values are REGIONAL or CLOUDFRONT. Defaults to REGIONAL."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "(Optional) A mapping of tags to assign to the resource."
}

variable "visibility_config" {
  type = object({
    cloudwatch_metrics_enabled = bool
    sampled_requests_enabled   = bool
    metric_name                = string
  })
  default = {
    cloudwatch_metrics_enabled = false
    sampled_requests_enabled   = false
    metric_name                = "test_allowed_ips"
  }
  description = "(Optional) Configuration block to enable CloudWatch metrics and sample requests."
}


variable "custom_response_bodies" {
  type = list(object({
    key          = string
    content      = string
    content_type = string
  }))
  default     = []
  description = "(Optional) Configuration block to define custom response body."
}


variable "default_action" {
  type = object({
    allow = optional(object({
      custom_request_handling = optional(object({
        insert_header = optional(object({
          name  = string
          value = string
        }), null)
      }), null)
    }), null)
    block = optional(object({
      custom_response = optional(object({
        custom_response_body_key = string
        response_code            = string
        response_header          = optional(map(any), null)
      }), null)
    }), null)
  })
  default = {
    allow = null
    block = {}
  }
  description = "(Required) Configuration block defining the default action to take when a request doesn't match any rule."
}

variable "association_config" {
  type = object({
    request_body = optional(object({
      cloudfront = optional(object({
        default_size_inspection_limit = string
      }), null)
      api_gateway = optional(object({
        default_size_inspection_limit = string
      }), null)
      app_runner_service = optional(object({
        default_size_inspection_limit = string
      }), null)
      cognito_user_pool = optional(object({
        default_size_inspection_limit = string
      }), null)
      verified_access_instance = optional(object({
        default_size_inspection_limit = string
      }), null)
    }), null)
  })
  default     = null
  description = "(Optional) Configuration block defining the association configuration."
}

variable "captcha_config" {
  type = object({
    immunity_time_property = optional(object({
      immunity_time = optional(number, 300)
    }), null)
  })
  default     = null
  description = "(Optional) Configuration block defining the captcha configuration."
}

variable "challenge_config" {
  type = object({
    immunity_time_property = optional(object({
      immunity_time = optional(number, 300)
    }), null)
  })
  default     = null
  description = "(Optional) Configuration block defining the challenge configuration."
}

variable "rules" {
  type = list(object({
    name = string
    captcha_config = optional(object({
      immunity_time_property = optional(object({
        immunity_time = optional(number, 300)
      }), null)
    }), null)

    action = optional(object({
      allow = optional(object({
        custom_request_handling = optional(object({
          insert_header = optional(object({
            name  = string
            value = string
          }), null)
        }), null)
      }), null)
      block = optional(object({
        custom_response = optional(object({
          custom_response_body_key = string
          response_code            = string
          response_header          = optional(map(any), null)
        }), null)
      }), null)
      captcha = optional(object({
        custom_request_handling = optional(object({
          insert_header = optional(object({
            name  = string
            value = string
          }), null)
        }), null)
      }), null)
      challenge = optional(object({
        custom_request_handling = optional(object({
          insert_header = optional(object({
            name  = string
            value = string
          }), null)
        }), null)
      }), null)
      count = optional(object({
        custom_request_handling = optional(object({
          insert_header = optional(object({
            name  = string
            value = string
          }), null)
        }), null)
      }), null)
    }), null)

    priority = number
    override_action = optional(object({
      count = optional(object({}), null)
      none  = optional(object({}), null)
    }), null)
    rule_label = optional(object({
      name = string
    }), null)

    statement = object({
      rate_based_statement = optional(object({
        limit                 = number
        aggregate_key_type    = string
        evaluation_window_sec = optional(number, null)
        custom_key = optional(object({
          cookies           = optional(object({}), null)
          query_string_keys = optional(list(string), null)
          single_header     = optional(list(string), null)
          single_query_arg  = optional(list(string), null)
          uri_path          = optional(list(string), null)
        }), null)
        scope_down_statement = optional(object({
          geo_match_statement = optional(object({
            country_codes = optional(list(string), null)
            forward_ip_config = optional(object({
              header_name = optional(string, null)
              position    = optional(string, null)
            }), null)
          }), null)
          byte_match_statement = optional(object({
            field_to_match = optional(object({
              data = optional(string, null)
              type = optional(string, null)
            }), null)
            positional_constraint = optional(string, null)
            search_string         = optional(string, null)
          }), null)
        }), null)
        forwarded_ip_config = optional(object({
          header_name       = optional(string, null)
          fallback_behavior = optional(string, null)
        }), null)
      }), null)

      ip_set_reference_statement = optional(object({
        arn = string
        forward_ip_config = optional(object({
          header_name       = optional(string, null)
          fallback_behavior = optional(string, null)
        }), null)
      }), null)

      rule_group_reference_statement = optional(object({
        arn = string
        rule_action_override = optional(object({
          name = string
          action_to_use = object({
            allow = optional(object({
              custom_request_handling = optional(object({
                insert_header = optional(object({
                  name  = string
                  value = string
                }), null)
              }), null)
            }), null)
            block = optional(object({
              custom_response = optional(object({
                custom_response_body_key = string
                response_code            = string
                response_header          = optional(map(any), null)
              }), null)
            }), null)
            captcha = optional(object({
              custom_request_handling = optional(object({
                insert_header = optional(object({
                  name  = string
                  value = string
                }), null)
              }), null)
            }), null)
            challenge = optional(object({
              custom_request_handling = optional(object({
                insert_header = optional(object({
                  name  = string
                  value = string
                }), null)
              }), null)
            }), null)
            count = optional(object({
              custom_request_handling = optional(object({
                insert_header = optional(object({
                  name  = string
                  value = string
                }), null)
              }), null)
            }), null)
          })
        }), null)
      }), null)

      byte_match_statement = optional(object({
        field_to_match = optional(object({
            all_query_arguments = optional(object({}), null)
            body = optional(object({
              oversize_handling = optional(string, null)
            }), null)
            cookies = optional(object({
              match_pattern = optional(object({
                all = optional(object({}), null)
                included_cookies = optional(list(string), null)
                excluded_cookies = optional(list(string), null)
              }), null)
              match_scope = optional(string, null)
              oversize_handling = optional(string, null)
            }), null)
            header_order = optional(object({
              oversize_handling = optional(string, null)
            }), null)
            headers = optional(object({
              match_pattern = optional(object({
                all = optional(object({}), null)
                included_headers = optional(list(string), null)
                excluded_headers = optional(list(string), null)
              }), null)
              match_scope = optional(string, null)
              oversize_handling = optional(string, null)
            }), null)
            ja3_fingerprint = optional(object({
              fallback_behavior = string
            }), null)
            json_body = optional(object({
              match_pattern = optional(object({
                all = optional(object({}), null)
                included_paths = optional(list(string), null)
              }), null)
              match_scope = optional(string, null)
              invalid_fallback_behavior = optional(string, null)
              oversize_handling = optional(string, null)
            }), null)
            method = optional(object({}), null)
            query_string = optional(object({
              match_pattern = optional(object({
                all = optional(list(object({})), null)
                included_query_strings = optional(list(string), null)
                excluded_query_strings = optional(list(string), null)
              }), null)
              oversize_handling = optional(string, null)
            }), null)
            single_header = optional(object({
              name = string
            }), null)
            single_query_argument = optional(object({
              name = string
            }), null)
            uri_path = optional(object({}), null)
        }), null)
        positional_constraint = optional(string, null)
        search_string         = optional(string, null)
        text_transformation = optional(list(object({
          priority = optional(number, null)
          type     = optional(string, null)
        })), null)
      }), null)

      geo_match_statement = optional(object({
        country_codes = optional(list(string), null)
        forward_ip_config = optional(object({
          header_name = optional(string, null)
          position    = optional(string, null)
        }), null)
      }), null)
    })

    visibility_config = optional(object({
      cloudwatch_metrics_enabled = optional(bool, false)
      sampled_requests_enabled   = optional(bool, false)
      metric_name                = optional(string, "test_allowed_ips")
    }), null)

  }))
  default     = null
  description = "(Optional) Configuration block defining a rule."
}