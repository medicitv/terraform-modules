locals {
  local_existing_package = var.package_path != null ? var.package_path : null
}

module "scheduled_lambda" {
  source                         = "terraform-aws-modules/lambda/aws"
  version                        = "7.20.1"
  function_name                  = "lbd-${var.name}"
  description                    = var.description
  handler                        = var.handler
  runtime                        = var.runtime
  timeout                        = var.timeout
  memory_size                    = var.memory_size
  reserved_concurrent_executions = var.reserved_concurrent_executions

  create_package = false
  package_type = var.package_type
  local_existing_package = local.local_existing_package
  use_existing_cloudwatch_log_group = true
  layers             = var.layers
  attach_policy_json = true
  policy_json = var.policy_document
  environment_variables   = var.environment_variables

  vpc_security_group_ids  = var.vpc_security_group_ids
  vpc_subnet_ids          = var.vpc_subnet_ids
  ignore_source_code_hash = var.ignore_source_code_hash

  depends_on = [ aws_cloudwatch_log_group.scheduled_lambda ]
}

resource "aws_iam_role_policy_attachment" "AWSLambdaVPCAccessExecutionRole" {
    role       = module.scheduled_lambda.lambda_role_name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

resource "aws_cloudwatch_event_rule" "fire_scheduled_lambda" {
  name                = "cwr-${var.name}"
  description         = var.cron_description
  schedule_expression = var.cron_definition

  tags = merge(
    var.TAGS,
    {
      "Name" = "cwr-${var.name}"
    },
  )
}

resource "aws_cloudwatch_event_target" "scheduled_lambda" {
  rule = aws_cloudwatch_event_rule.fire_scheduled_lambda.name
  arn  = module.scheduled_lambda.lambda_function_arn
}

resource "aws_lambda_permission" "scheduled_lambda_permission" {
  statement_id  = "AllowExecutionFromCloudwatch"
  action        = "lambda:InvokeFunction"
  function_name = module.scheduled_lambda.lambda_function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.fire_scheduled_lambda.arn
}

resource "aws_cloudwatch_log_group" "scheduled_lambda" {
  name              = "/aws/lambda/lbd-${var.name}"
  retention_in_days = var.cloudwatch_log_group_retention_in_days
  # kms_key_id        = var.cloudwatch_log_group_kms_key_id

  tags = merge(var.TAGS, var.cloudwatch_log_group_tags)
}