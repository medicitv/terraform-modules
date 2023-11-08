
variable "region" {
  type        = string
  description = "aws region"
  default     = "eu-west-1"
}

variable "state_role_arn" {
  type        = string
  description = "Role ARN to used during pulling remote state"
  default     = null
}

variable "state_ci_bucket" {
  type    = string
  default = "medicitv-ci-tfstate"
}

variable "tags" {
  type = map(any)
}

variable "domain" {
  type        = string
  description = "api domain"
}

variable "app" {
  type        = string
  description = "application identification"
}

variable "variable" {
  type        = string
  description = "stage variable name"
}

variable "default" {
  type        = bool
  description = "is default version"
  default     = false
}
