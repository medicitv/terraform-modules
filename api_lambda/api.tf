resource "aws_lambda_permission" "api_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = module.api_lambda.lambda_function_name
  principal     = "apigateway.amazonaws.com"

  # The /*/*/* part allows invocation from any stage, method and resource path
  # within API Gateway REST API. the last one indicates where to send requests to.
  # see more detail https://docs.aws.amazon.com/lambda/latest/dg/services-apigateway.html
  source_arn = "${var.api_gw_arn}/*/*"
}

resource "aws_apigatewayv2_integration" "api_lambda_integration" {
  api_id           = var.api_gw_id
  integration_type = var.api_integration_type

  connection_type           = var.api_integration_connection_type
  description               = var.api_integration_description
  integration_method        = var.api_integration_method
  integration_uri           = module.api_lambda.lambda_function_invoke_arn

  payload_format_version    = "2.0"
}

resource "aws_apigatewayv2_route" "api_lambda_route" {
  api_id             = var.api_gw_id
  route_key          = var.api_route_key
  authorization_type = "NONE"
  target             = "integrations/${aws_apigatewayv2_integration.api_lambda_integration.id}"
}