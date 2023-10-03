# ******************************** Common vars
variable "region" {
  description = "AWS region for all recources and providers"
  type        = string
  default     = "us-east-1"
}
variable "azs" {
  description = "AWS availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
variable "env_name" {
  description = "Environment tag"
  type        = string
  default     = "Unknown"
}
