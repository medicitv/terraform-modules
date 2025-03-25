variable "name" {}
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
variable "use_existing_cloudwatch_log_group" {
    type = bool
    default = false
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
variable "TAGS" {
    type        = map(string)
}