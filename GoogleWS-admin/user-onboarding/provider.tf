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
  credentials = "${terraform.workspace}/credentials.json"
  customer_id = "C01hmn5i2"
  oauth_scopes = [
    "https://www.googleapis.com/auth/admin.directory.user",
    "https://www.googleapis.com/auth/admin.directory.userschema",
    "https://www.googleapis.com/auth/admin.directory.group",
    "https://www.googleapis.com/auth/apps.groups.settings"
    # include scopes as needed
  ]
}