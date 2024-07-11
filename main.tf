
resource "aws_wafv2_web_acl" "regional" {
  #   count = (var.enabled && var.scope == "CLOUDFRONT") ? 1 : 0 
  provider = aws

  name        = var.name
  description = var.description
  scope       = var.scope
  tags        = var.tags


  dynamic "custom_response_body" {
    for_each = var.custom_response_bodies
    content {
      key          = custom_response_body.value.key
      content      = custom_response_body.value.content
      content_type = custom_response_body.value.content_type
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = var.visibility_config.cloudwatch_metrics_enabled
    sampled_requests_enabled   = var.visibility_config.sampled_requests_enabled
    metric_name                = var.visibility_config.metric_name
  }


  dynamic "default_action" {
    for_each = [{}]
    content {
      dynamic "allow" {
        for_each = var.default_action.allow != null ? [var.default_action.allow] : []
        content {
          dynamic "custom_request_handling" {
            for_each = try(allow.value.custom_request_handling, null) != null ? [allow.value.custom_request_handling] : []
            content {
              dynamic "insert_header" {
                for_each = try(custom_request_handling.value, null) != null ? [for i in custom_request_handling.value : i] : []
                content {
                  name  = insert_header.value.name
                  value = insert_header.value.value
                }
              }
            }
          }
        }
      }
      dynamic "block" {
        for_each = try(var.default_action.block, null) != null ? [var.default_action.block] : []
        content {
          dynamic "custom_response" {
            for_each = try(block.value.custom_response, null) != null ? [block.value.custom_response] : []
            content {
              custom_response_body_key = try(custom_response.value.custom_response_body_key, null)
              response_code            = custom_response.value.response_code
              dynamic "response_header" {
                for_each = try(custom_response.value.response_header, null) != null ? [custom_response.value.response_header] : []
                content {
                  name  = response_header.value.name
                  value = response_header.value.value
                }
              }
            }
          }
        }
      }
    }
  }

  dynamic "association_config" {
    for_each = try(var.association_config, null) != null ? [var.association_config] : []
    content {
      dynamic "request_body" {
        for_each = try(association_config.value.request_body, null) != null ? [association_config.value.request_body] : []
        content {
          dynamic "api_gateway" {
            for_each = try(request_body.value.api_gateway, null) != null ? [request_body.value.api_gateway] : []
            content {
              default_size_inspection_limit = api_gateway.value.default_size_inspection_limit
            }
          }
          dynamic "app_runner_service" {
            for_each = try(request_body.value.app_runner_service, null) != null ? [request_body.value.app_runner_service] : []
            content {
              default_size_inspection_limit = app_runner_service.value.default_size_inspection_limit
            }
          }
          dynamic "cognito_user_pool" {
            for_each = try(request_body.value.cognito_user_pool, null) != null ? [request_body.value.cognito_user_pool] : []
            content {
              default_size_inspection_limit = cognito_user_pool.value.default_size_inspection_limit
            }
          }
          dynamic "cloudfront" {
            for_each = try(request_body.value.cloudfront, null) != null ? [request_body.value.cloudfront] : []
            content {
              default_size_inspection_limit = cloudfront.value.default_size_inspection_limit
            }
          }
          dynamic "verified_access_instance" {
            for_each = try(request_body.value.verified_access_instance, null) != null ? [request_body.value.verified_access_instance] : []
            content {
              default_size_inspection_limit = verified_access_instance.value.default_size_inspection_limit
            }
          }
        }
      }
    }
  }

  dynamic "captcha_config" {
    for_each = try(var.captcha_config, null) != null ? [var.captcha_config] : []
    content {
      dynamic "immunity_time_property" {
        for_each = try(captcha_config.value.immunity_time_property, null) != null ? [captcha_config.value.immunity_time_property] : []
        content {
          immunity_time = immunity_time_property.value.immunity_time
        }
      }
    }
  }

  dynamic "challenge_config" {
    for_each = try(var.challenge_config, null) != null ? [var.challenge_config] : []
    content {
      dynamic "immunity_time_property" {
        for_each = try(challenge_config.value.immunity_time_property, null) != null ? [challenge_config.value.immunity_time_property] : []
        content {
          immunity_time = immunity_time_property.value.immunity_time
        }
      }
    }
  }


  dynamic "rule" {
    for_each = var.rules != null ? var.rules : []
    content {
      name     = rule.value.name
      priority = rule.value.priority

      dynamic "action" {
        for_each = try(rule.value.action, null) != null ? [{}] : []
        content {
          dynamic "allow" {
            for_each = try(rule.value.action.allow, null) != null ? [rule.value.action.allow] : []
            content {
              dynamic "custom_request_handling" {
                for_each = try(allow.value.custom_request_handling, null) != null ? [allow.value.custom_request_handling] : []
                content {
                  dynamic "insert_header" {
                    for_each = try(custom_request_handling.value.insert_header, null) != null ? [custom_request_handling.value.insert_header] : []
                    content {
                      name  = insert_header.value.name
                      value = insert_header.value.value
                    }
                  }
                }
              }
            }
          }
          dynamic "block" {
            for_each = try(rule.value.action.block, null) != null ? [rule.value.action.block] : []
            content {
              dynamic "custom_response" {
                for_each = try(block.value.custom_response, null) != null ? [block.value.custom_response] : []
                content {
                  custom_response_body_key = custom_response.value.custom_response_body_key
                  response_code            = custom_response.value.response_code
                  dynamic "response_header" {
                    for_each = try(custom_response.value.response_header, null) != null ? [custom_response.value.response_header] : []
                    content {
                      name  = response_header.value.name
                      value = response_header.value.value
                    }
                  }
                }
              }
            }
          }
          dynamic "captcha" {
            for_each = try(rule.value.action.captcha, null) != null ? [rule.value.action.captcha] : []
            content {
              dynamic "custom_request_handling" {
                for_each = try(captcha.value.custom_request_handling, null) != null ? [captcha.value.custom_request_handling] : []
                content {
                  dynamic "insert_header" {
                    for_each = try(custom_request_handling.value.insert_header, null) != null ? [custom_request_handling.value.insert_header] : []
                    content {
                      name  = insert_header.value.name
                      value = insert_header.value.value
                    }
                  }
                }
              }
            }
          }
          dynamic "challenge" {
            for_each = try(rule.value.action.challenge, null) != null ? [rule.value.action.challenge] : []
            content {
              dynamic "custom_request_handling" {
                for_each = try(challenge.value.custom_request_handling, null) != null ? [challenge.value.custom_request_handling] : []
                content {
                  dynamic "insert_header" {
                    for_each = try(custom_request_handling.value.insert_header, null) != null ? [custom_request_handling.value.insert_header] : []
                    content {
                      name  = insert_header.value.name
                      value = insert_header.value.value
                    }
                  }
                }
              }
            }
          }
          dynamic "count" {
            for_each = try(rule.value.action.count, null) != null ? [rule.value.action.count] : []
            content {
              dynamic "custom_request_handling" {
                for_each = try(count.value.custom_request_handling, null) != null ? [count.value.custom_request_handling] : []
                content {
                  dynamic "insert_header" {
                    for_each = try(custom_request_handling.value.insert_header, null) != null ? [custom_request_handling.value.insert_header] : []
                    content {
                      name  = insert_header.value.name
                      value = insert_header.value.value
                    }
                  }
                }
              }
            }
          }
        }
      }
      dynamic "override_action" {
        for_each = try(rule.value.override_action, null) != null ? [rule.value.override_action] : []
        content {
          dynamic "count" {
            for_each = try(override_action.value.count, null) != null ? [override_action.value.count] : []
            content {
            }
          }
          dynamic "none" {
            for_each = try(override_action.value.none, null) != null ? [override_action.value.none] : []
            content {
            }
          }
        }
      }

      dynamic "rule_label" {
        for_each = try(rule.value.rule_label, null) != null ? [rule.value.rule_label] : []
        content {
          name = rule_label.value.name
        }
      }

      dynamic "captcha_config" {
        for_each = try(rule.value.captcha_config, null) != null ? [rule.value.captcha_config] : []
        content {
          dynamic "immunity_time_property" {
            for_each = try(captcha_config.value.immunity_time_property, null) != null ? [captcha_config.value.immunity_time_property] : []
            content {
              immunity_time = immunity_time_property.value.immunity_time
            }
          }
        }
      }

      dynamic "statement" {
        for_each = [rule.value.statement]
        content {
          dynamic "rate_based_statement" {
            for_each = try(statement.value.rate_based_statement, null) != null ? [statement.value.rate_based_statement] : []
            content {
              limit                 = rate_based_statement.value.limit
              aggregate_key_type    = rate_based_statement.value.aggregate_key_type
              evaluation_window_sec = rate_based_statement.value.evaluation_window_sec
              dynamic "custom_key" {
                for_each = try(rate_based_statement.value.custom_key, null) != null ? [rate_based_statement.value.custom_key] : []
                content {
                  dynamic "cookie" {
                    for_each = try(custom_key.value.cookie, null) != null ? [custom_key.value.cookie] : []
                    content {
                      name = cookie.value.name
                      dynamic "text_transformation" {
                        for_each = try(cookie.value.text_transformation, null) != null ? [cookie.value.text_transformation] : []
                        content {
                          priority = text_transformation.value.priority
                          type     = text_transformation.value.type
                        }
                      }
                    }
                  }
                }
                #   http_method = custom_key.value.http_method
                #   header = custom_key.value.header
                #   ip = custom_key.value.ip
                #   label_namespace = custom_key.value.label_namespace
                #   query_argument = custom_key.value.query_argument
                #   query_string = custom_key.value.query_string
                #   uri_path = custom_key.value.uri_path
              }

              dynamic "forwarded_ip_config" {
                for_each = try(rate_based_statement.value.forwarded_ip_config, null) != null ? [rate_based_statement.value.forwarded_ip_config] : []
                content {
                  fallback_behavior = forwarded_ip_config.value.fallback_behavior
                  header_name       = forwarded_ip_config.value.header_name
                }
              }


              dynamic "scope_down_statement" {
                for_each = try(rate_based_statement.value.scope_down_statement, null) != null ? [rate_based_statement.value.scope_down_statement] : []
                content {
                  dynamic "geo_match_statement" {
                    for_each = try(scope_down_statement.value.geo_match_statement, null) != null ? [scope_down_statement.value.geo_match_statement] : []
                    content {
                      country_codes = geo_match_statement.value.country_codes
                    }
                  }
                }
              }
            }
          }

          dynamic "ip_set_reference_statement" {
            for_each = try(statement.value.ip_set_reference_statement, null) != null ? [statement.value.ip_set_reference_statement] : []
            content {
              arn = ip_set_reference_statement.value.arn
              dynamic "ip_set_forwarded_ip_config" {
                for_each = try(ip_set_reference_statement.value.ip_set_forwarded_ip_config, null) != null ? [ip_set_reference_statement.value.ip_set_forwarded_ip_config] : []
                content {
                  fallback_behavior = ip_set_forwarded_ip_config.value.fallback_behavior
                  header_name       = ip_set_forwarded_ip_config.value.header_name
                  position          = ip_set_forwarded_ip_config.value.position
                }
              }
            }
          }

          dynamic "geo_match_statement" {
            for_each = try(statement.value.geo_match_statement, null) != null ? [statement.value.geo_match_statement] : []
            content {
              country_codes = geo_match_statement.value.country_codes
              dynamic "forwarded_ip_config" {
                for_each = try(geo_match_statement.value.forwarded_ip_config, null) != null ? [geo_match_statement.value.forwarded_ip_config] : []
                content {
                  fallback_behavior = forwarded_ip_config.value.fallback_behavior
                  header_name       = forwarded_ip_config.value.header_name
                }
              }
            }

          }

          dynamic "byte_match_statement" {
            for_each = try(statement.value.byte_match_statement, null) != null ? [statement.value.byte_match_statement] : []
            content {
              positional_constraint = byte_match_statement.value.positional_constraint
              search_string         = byte_match_statement.value.search_string

              dynamic "field_to_match" {
                for_each = try(byte_match_statement.value.field_to_match, null) != null ? [byte_match_statement.value.field_to_match] : []
                content {

                  dynamic "body" {
                    for_each = try(field_to_match.value.body, null) != null ? [field_to_match.value.body] : []
                    content {
                      oversize_handling = body.value.oversize_handling
                    }
                  }
                  dynamic "cookies" {
                    for_each = try(field_to_match.value.cookies, null) != null ? [field_to_match.value.cookies] : []
                    content {
                      dynamic "match_pattern" {
                        for_each = try(cookies.value.match_pattern, null) != null ? [cookies.value.match_pattern] : []
                        content {
                          dynamic "all" {
                            for_each = try(match_pattern.value.all, null) != null ? [{}] : []
                            content {
                            }
                          }
                          included_cookies = match_pattern.value.included_cookies
                          excluded_cookies = match_pattern.value.excluded_cookies
                        }
                      }
                      match_scope       = cookies.value.match_scope
                      oversize_handling = cookies.value.oversize_handling
                    }
                  }

                dynamic "header_order" {
                    for_each = try(field_to_match.value.header_order, null) != null ? [field_to_match.value.header_order] : []
                    content {
                      oversize_handling = header_order.value.oversize_handling
                    }
                  }      
                  dynamic "headers" {
                    for_each = try(field_to_match.value.headers, null) != null ? [field_to_match.value.headers] : []
                    content {
                      dynamic "match_pattern" {
                        for_each = try(headers.value.match_pattern, null) != null ? [headers.value.match_pattern] : []
                        content {
                          dynamic "all" {
                            for_each = try(match_pattern.value.all, null) != null ? [{}] : []
                            content {
                            }
                          }
                          included_headers = match_pattern.value.included_headers
                          excluded_headers = match_pattern.value.excluded_headers
                        }
                      }
                      match_scope       = headers.value.match_scope
                      oversize_handling = headers.value.oversize_handling
                    }
                  }              
                  dynamic "ja3_fingerprint" {
                    for_each = try(field_to_match.value.ja3_fingerprint, null) != null ? [field_to_match.value.ja3_fingerprint] : []
                    content {
                      fallback_behavior = ja3_fingerprint.value.fallback_behavior
                    }
                  } 

                  dynamic "json_body" {
                    for_each = try(field_to_match.value.json_body, null) != null ? [field_to_match.value.json_body] : []
                    content {
                      dynamic "match_pattern" {
                        for_each = try(json_body.value.match_pattern, null) != null ? [json_body.value.match_pattern] : []
                        content {
                          dynamic "all" {
                            for_each = try(match_pattern.value.all, null) != null ? [{}] : []
                            content {
                            }
                          }
                          included_paths = match_pattern.value.included_paths
                        }
                      }
                      match_scope               = json_body.value.match_scope
                      invalid_fallback_behavior = json_body.value.invalid_fallback_behavior
                      oversize_handling         = json_body.value.oversize_handling
                    }
                  }             
                  dynamic "single_header" {
                    for_each = try(field_to_match.value.single_header, null) != null ? [field_to_match.value.single_header] : []
                    content {
                      name =  lower(single_header.value.name)
                    }
                  }         
                  dynamic "single_query_argument" {
                    for_each = try(field_to_match.value.single_query_argument, null) != null ? [field_to_match.value.single_query_argument] : []
                    content {
                      name = lower(single_query_argument.value.name)
                    }
                  }
                  dynamic "uri_path" {
                    for_each = try(field_to_match.value.uri_path, null) != null ? [{}] : []
                    content {
                    }
                  }              

                  dynamic "all_query_arguments" {
                    for_each = try(field_to_match.value.all_query_arguments, null) != null ? [field_to_match.value.all_query_arguments] : []
                    content {
                    }
                  }
                  dynamic "method" {
                    for_each = try(field_to_match.value.method, null) != null ? [field_to_match.value.method] : []
                    content {
                    }
                  }
                  dynamic "query_string" {
                    for_each = try(field_to_match.value.query_string, null) != null ? [field_to_match.value.query_string] : []
                    content {
                    }
                  }
                }
              }

              dynamic "text_transformation" {
                for_each = try(byte_match_statement.value.text_transformation, null) != null ? byte_match_statement.value.text_transformation : []
                content {
                  priority = text_transformation.value.priority
                  type     = text_transformation.value.type
                }
              }
            }
          }

          # dynamic "label_match_statement"
          # dynamic "regex_match_statement"
          # dynamic "regex_pattern_set_reference_statement"
          # dynamic "rule_group_reference_statement"
          # dynamic "size_constraint_statement"
          # dynamic "sqli_match_statement"
          # dynamic "xss_match_statement"
          dynamic "managed_rule_group_statement" {
            for_each = try(statement.value.managed_rule_group_statement, null) != null ? [statement.value.managed_rule_group_statement] : []
            content {
              name        = managed_rule_group_statement.value.name
              vendor_name = managed_rule_group_statement.value.vendor_name
            }
          }

        }
      }



      #   rule_label = rule.value.rule_label
      visibility_config {
        cloudwatch_metrics_enabled = rule.value.visibility_config.cloudwatch_metrics_enabled
        sampled_requests_enabled   = rule.value.visibility_config.sampled_requests_enabled
        metric_name                = rule.value.visibility_config.metric_name
      }
    }
  }

}