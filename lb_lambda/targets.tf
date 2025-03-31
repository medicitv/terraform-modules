// Targets and listeners
resource "aws_lb_target_group" "rest_service" {
  name        = var.name_alt == "" ? "lbt-${var.name}" : "lbt-${var.name_alt}"
  target_type = "lambda"

  tags = merge(
    var.TAGS,
    {
      "Name" = var.name_alt == "" ? "lbt-${var.name}" : "lbt-${var.name_alt}"
    },
  )
}

resource "aws_lambda_permission" "rest_service" {
  statement_id  = "AllowExecutionFromLoadBalancer"
  action        = "lambda:InvokeFunction"
  function_name = module.lb_lambda.lambda_function_name
  principal     = "elasticloadbalancing.amazonaws.com"
  source_arn    = aws_lb_target_group.rest_service.arn
}

resource "aws_lb_target_group_attachment" "rest_service" {
  target_group_arn = aws_lb_target_group.rest_service.arn
  target_id        = module.lb_lambda.lambda_function_arn

  depends_on = [aws_lambda_permission.rest_service]
}

// Listener rule
resource "aws_lb_listener_rule" "rest_service_alt" {
  listener_arn = var.lb_listener_arn
  priority     = var.lb_listener_priority
  condition {
    path_pattern {
      values = var.lb_listener_path_pattern
    }
  }
  condition {
    host_header {
      values = var.lb_listener_host_header
    }
  }
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.rest_service.arn
  }
}