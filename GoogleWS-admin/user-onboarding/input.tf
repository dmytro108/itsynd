#---------------------
data "local_file" "input" {
  filename = "./projects/${terraform.workspace}/input.yaml"
}

locals {
  input_data = yamldecode(data.local_file.input.content)
}