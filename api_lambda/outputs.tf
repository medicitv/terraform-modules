output "api_lambda_arn" {
  value = module.api_lambda.lambda_function_arn
}

output "api_lambda_name" {
  value = module.api_lambda.lambda_function_name
}

output "api_lambda_integration_id" {
  value = aws_apigatewayv2_integration.api_lambda_integration.id
}