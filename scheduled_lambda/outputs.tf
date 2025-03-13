output "scheduled_lambda_arn" {
  value = module.data-automation_scheduled_lambda.lambda_function_arn
}

output "scheduled_lambda_name" {
  value = module.data-automation_scheduled_lambda.lambda_function_name
}