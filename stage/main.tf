
resource "aws_apigatewayv2_stage" "main" {
  #not for the default / which is alerady in the default stage
  count = var.default ? 0 : 1

  api_id      = data.terraform_remote_state.api.outputs.rest_id
  name        = var.app
  auto_deploy = true

  stage_variables = merge(
    data.terraform_remote_state.api.outputs.stage_variables,
    {
      (var.variable) = var.app,
      stageName      = var.app,
      baseURL        = "https://${data.terraform_remote_state.api.outputs.rest_domain}/${var.app}",
    }
  )

  default_route_settings {
    data_trace_enabled       = true
    detailed_metrics_enabled = true
    logging_level            = "INFO"

    throttling_burst_limit   = 10
    throttling_rate_limit    = 10
  }

  access_log_settings {
    destination_arn = data.terraform_remote_state.api.outputs.rest_log_group
    format          = data.terraform_remote_state.api.outputs.rest_log_format
  }

  tags = merge(
    var.tags,
    {
      "Name" = "agws-${var.app}"
    },
  )
}
