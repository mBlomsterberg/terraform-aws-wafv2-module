module "multi_rule_waf" {
    source = "../../waf"

    name = "multi_rule_waf"
    description = "Multi rule WAF"
    scope = "REGIONAL"

    visibility_config = {
        cloudwatch_metrics_enabled = false
        sampled_requests_enabled   = false
        metric_name                = "metric_rate_base"
    }

    default_action = {
        allow = {}
    }

    rules = [
        {
            name = "rate_base_rule"
            action = {
                block = {}
            }
            priority = 2
            statement = {
                rate_based_statement = {
                    limit              = 1000
                    aggregate_key_type = "IP"
                }
            }

            visibility_config = {
                cloudwatch_metrics_enabled = false
                sampled_requests_enabled   = false
                metric_name                = "metric_rate_base_rule"
            }
        },
         {
            name = "geo_match_rule"
            action = {
                block = {
                }
            }

            priority = 1

            statement = {
                geo_match_statement = {
                    country_codes = ["US"]
                    forward_ip_config = {
                        header_name = "X-Forwarded-For"
                        position    = "ANY"
                    }
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
        "project" = "Multi Rule WAF"
    }
}
