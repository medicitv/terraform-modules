output "event_source_lambda_arn" {
  value = module.event_source_lambda.lambda_function_arn
}

output "event_source_lambda_name" {
  value = module.event_source_lambda.lambda_function_name
}