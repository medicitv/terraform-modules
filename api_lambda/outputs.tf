output "api_lambda_arn" {
  value = module.api_lambda.lambda_function_arn
}

output "api_lambda_name" {
  value = module.api_lambda.lambda_function_name
}

# output "api_lambda_target_group_arn" {
#     value = aws_api_target_group.api_lambda.arn
# }
