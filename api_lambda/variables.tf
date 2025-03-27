variable "name" {}
variable "function_name" {
    type = string
    default = ""
}
variable "description" {}
variable "package_path" {
    type = string
    default = ""
}
variable "package_type" {
    type = string
    default = "Zip"
}
variable "handler" {}
variable "policy_document" {}
variable "runtime" {
    type = string
    default = "python3.12"
}
variable "memory_size" {
    type        = number
    default     = 2048
}
variable "timeout" {
    type        = number
    default     = 600
}
variable "image_uri" {
    type = string
    default = null
}
variable "reserved_concurrent_executions" {
    type        = number
    default     = -1
}
variable "layers" {
    type        = list(string)
    default     = []
}
variable "environment_variables" {
    type        = map(string)
}
variable "vpc_security_group_ids" {
    type        = list(string)
}
variable "vpc_subnet_ids" {}
variable "ignore_source_code_hash" {
    type = bool
    default = false
}
variable "cloudwatch_log_group_retention_in_days" {
  description = "Specifies the number of days you want to retain log events in log group for Lambda."
  type        = number
  default     = 0
}
variable "cloudwatch_log_group_tags" {
  description = "Additional tags for the Cloudwatch log group"
  type        = map(string)
  default     = {}
}
variable "TAGS" {
    type        = map(string)
}

variable "api_gw_arn" {
    type = string
}
variable "api_gw_id" {
    type = string
}
variable "api_route_key" {
    type = string
}
variable "api_integration_method" {
    type = string
}
variable "api_integration_description" {
    type = string
}
variable "api_integration_connection_type" {
    type = string
}
variable "api_integration_type" {
    type = string
}