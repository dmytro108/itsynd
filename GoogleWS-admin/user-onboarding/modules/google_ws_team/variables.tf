variable "domain" {
  description = "E-mail domain"
  type        = string
  default     = ""
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = ""
}

variable "team" {
  description = "Map of team members"
  type = list(object({
    role    = string
    name    = string
    surname = string
  }))
  default = [{
    name    = ""
    role    = ""
    surname = ""
  }]
}

