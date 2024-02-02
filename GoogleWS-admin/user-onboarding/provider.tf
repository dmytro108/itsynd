terraform {
  required_providers {
    googleworkspace = {
      source  = "hashicorp/googleworkspace"
      version = "0.7.0"
    }
    random = {
      source = "hashicorp/random"
    }
  }
}

# Auth method: Admin roles applied directly to a service account
provider "googleworkspace" {
  credentials = jsonencode(data.external.sops_secrets.result)
  customer_id = var.googleworkspace_customer_id
  oauth_scopes = [
    "https://www.googleapis.com/auth/admin.directory.user",
    "https://www.googleapis.com/auth/admin.directory.userschema",
    "https://www.googleapis.com/auth/admin.directory.group",
    "https://www.googleapis.com/auth/apps.groups.settings"
  ]
}

data "external" "sops_secrets" {
  program = ["sops", "--decrypt", "projects/${terraform.workspace}/credentials-encrypted.json"]
}
