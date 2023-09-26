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
  default     = "ITS-week4-task1"
}

# ***************************** Ansible inventory template
variable "inventory_template" {
  description = "Path to template to produce Ansible inventory file"
  type        = string
  default     = "inventory.tftpl"
}
variable "inventory_file" {
  description = "Path to Ansible inventory file"
  type        = string
  default     = "ansible/inventory/hosts.ini"
}
