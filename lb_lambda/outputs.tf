output "lb_lambda_arn" {
  value = module.data-automation_lb_lambda.lambda_function_arn
}

output "lb_lambda_name" {
  value = module.data-automation_lb_lambda.lambda_function_name
}

output "lb_lambda_target_group_arn" {
  value = aws_lb_target_group.rest_service.arn
}