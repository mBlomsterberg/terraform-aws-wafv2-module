module "waf" {
    source = "../waf"

    name = "rate_base_waf"
    description = "Rate limiting WAF"
    scope = "CLOUDFRONT"

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
            priority = 1
            statement = {
                rate_based_statement = {
                    limit              = 1000
                    aggregate_key_type = "IP"
                    scope_down_statement = {
                        geo_match_statement = {
                            country_codes = ["US"]
                        }
                    }
                }
            }

            visibility_config = {
                cloudwatch_metrics_enabled = false
                sampled_requests_enabled   = false
                metric_name                = "metric_rate_base_rule"
            }
        }
    ]

    tags = {
        "project" = "Rate Base WAF"
    }
}
