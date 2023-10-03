# ******************************** Common vars
variable "region" {
  description = "AWS region for all recources and providers"
  type        = string
  default     = "us-east-1"
}

variable "env_name" {
  description = "Environment tag"
  type        = string
  default     = "Unknown"
}

