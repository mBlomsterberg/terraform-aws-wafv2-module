module "geo_match" {
    source = "../../waf"
    name = "geo_match_rule_waf"
    description = "Geographical match rule"
    scope = "REGIONAL"

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
        "Name" = "GeoMatchRuleWAF"
    }
}