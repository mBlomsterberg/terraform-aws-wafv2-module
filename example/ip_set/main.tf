module "waf" {
    source = "../waf"

    name = "ip_set_waf"
    description = "IP Set WAF"
    scope = "CLOUDFRONT"

    visibility_config = {
        cloudwatch_metrics_enabled = false
        sampled_requests_enabled   = false
        metric_name                = "metric_ip_set"
    }

    custom_response_bodies = [
        {
            key          = "_default_"
            content      = "{\"message\":\"Forbidden\"}"
            content_type = "APPLICATION_JSON"
        }
    ]

    default_action = {
        block = {
            custom_response = {
                custom_response_body_key = "_default_"
                response_code            = "403"
            }
        }
    }

    rules = [
        {
            name = "ip_set_rule"
            action = {
                allow = {
                }
            }
            priority = 1
            statement = {
                ip_set_reference_statement = {
                    arn = "arn:aws:wafv2:us-east-1:00000000000:global/ipset/"
                }
            }

            visibility_config = {
                cloudwatch_metrics_enabled = false
                sampled_requests_enabled   = false
                metric_name                = "metric_ip_set_rule"
            }
        }
    ]

    tags = {
        "project" = "IP Set WAF"
    }
}
