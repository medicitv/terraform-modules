data "aws_cloudwatch_log_group" "test" {
  name = "/aws/lambda/lbd-${var.name}"
}

locals {
  local_existing_package = var.package_path != null ? var.package_path : null
  log_group_exist = length([for b in data.aws_cloudwatch_log_group.test : b.id if b.id != null]) > 0 ? true : false
}

module "simple_lambda" {
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
  use_existing_cloudwatch_log_group = local.log_group_exist
  layers             = var.layers
  attach_policy_json = true
  policy_json = var.policy_document
  environment_variables   = var.environment_variables

  vpc_security_group_ids  = var.vpc_security_group_ids
  vpc_subnet_ids          = var.vpc_subnet_ids
  ignore_source_code_hash = var.ignore_source_code_hash
}

resource "aws_iam_role_policy_attachment" "AWSLambdaVPCAccessExecutionRole" {
    role       = module.simple_lambda.lambda_role_name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

