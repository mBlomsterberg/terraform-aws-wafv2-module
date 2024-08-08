module "waf" {
    source = "../../waf"
    name = "config"
    description = "Config WAF"
    scope = "REGIONAL"

    default_action = {
        allow = {}
    }

    association_config = {
        request_body = {
            # cloudfront = {
            #     default_size_inspection_limit = "KB_64"
            # }
            api_gateway = {
                default_size_inspection_limit = "KB_64"
            }
            app_runner_service = {
                default_size_inspection_limit = "KB_64"
            }
            cognito_user_pool = {
                default_size_inspection_limit = "KB_64"
            }
            verified_access_instance = {
                default_size_inspection_limit = "KB_64"
            }
        }
    }

    captcha_config = {
        immunity_time_property = {
            immunity_time = 300
        }
    }

    challenge_config = {
        immunity_time_property = {
            immunity_time = 300
        }
    }

    visibility_config = {
        cloudwatch_metrics_enabled = false
        sampled_requests_enabled   = false
        metric_name                = "metric_name_test"
    }

    tags = {
        "Name" = "testing"
    }
}
