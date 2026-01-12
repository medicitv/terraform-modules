output "lb_lambda_arn" {
  value = module.lb_lambda.lambda_function_arn
}

output "lb_lambda_name" {
  value = module.lb_lambda.lambda_function_name
}

output "lb_lambda_target_group_arn" {
<<<<<<< HEAD
  value = aws_lb_target_group.rest_service.arn
=======
  value = aws_lb_target_group.service.arn
>>>>>>> ef0abcf (add lb_lambda)
}