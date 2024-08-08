module "byte_match" {
  source      = "../../"
  name        = "byte_match_rule_waf"
  description = "Byte matching rule"
  scope       = "REGIONAL"

  visibility_config = {
    cloudwatch_metrics_enabled = false
    sampled_requests_enabled   = false
    metric_name                = "metric_name_test"
  }

  default_action = {
    allow = {
    }
  }

  rules = [
    {
      name = "byte_match_rule"
      action = {
        block = {
        }
      }

      priority = 1

      statement = {
        byte_match_statement = {
          field_to_match = {
            # all_query_arguments = {
            # }
            # body = {
            #     oversize_handling = "NO_MATCH"
            # }
            cookies = {
                match_scope = "ALL"
                match_pattern = {
                    all = {}
                    # excluded_cookies = ["session-id-time"]
                    # excluded_cookies = ["session-id"]
                }
                oversize_handling = "NO_MATCH"
            }
            # header_order = {
            #     oversize_handling = "NO_MATCH"
            # }
            # headers = {
            #     match_pattern = {
            #         all = {}
            #         # included_headers = ["Host"]
            #         # excluded_headers = ["User-Agent"]
            #     }
            #     match_scope = "ALL"
            #     oversize_handling = "NO_MATCH"
            # }
            # ja3_fingerprint = {
            #   fallback_behavior = "NO_MATCH"
            # }
            # json_body = {
            #   match_pattern = {
            #     all = {}
            #     # included_paths = ["/login"]
            #   }
            #   match_scope = "ALL"
            #   invalid_fallback_behavior = "MATCH"
            #   oversize_handling = "NO_MATCH"
            # }
            # single_header = {
            #   name = "User-Agent"
            # }
            # single_query_argument = {
            #     name = "SalesRegion"
            # }
            # uri_path = {}
            # method = {}
          }
          positional_constraint = "CONTAINS"
          search_string         = "test"
          text_transformation = [
            {
              priority = 1
              type     = "NONE"
            }
          ]

        }
      }

      visibility_config = {
        cloudwatch_metrics_enabled = false
        sampled_requests_enabled   = false
        metric_name                = "metric_allowed_ip_set_test"
      }
    }
  ]

  tags = {
    "Name" = "ByteMatchRuleWAF"
  }
}