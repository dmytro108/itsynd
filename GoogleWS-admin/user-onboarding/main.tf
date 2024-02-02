/*
This Terraform configuration file is used for user onboarding in Google Workspace.
It retrieves input data from a local file, creates a Google Workspace team using a custom module,
and generates an output file with the project group details and team member information.
*/

data "local_file" "input" {
  filename = "./projects/${terraform.workspace}/input.yaml"
}

# Decoding the content of the "input.yaml" file 
locals {
  input_data = yamldecode(data.local_file.input.content)
}

/*
This module creates a Google Workspace team.
Inputs:
- domain: The domain name for the Google Workspace.
- project_name: The name of the project.
- team: list of team members, each with the following attributes:
  - name: The first name of the team member.
  - surname: The surname of the team member.
  - role: The team member's role in the project.
*/
module "google_ws_team" {
  source = "./modules/google_ws_team"

  domain       = local.input_data.domain
  project_name = local.input_data.project

  team = local.input_data.team
}

/*
Creating a local output YAML file named "output.yaml". The filename is dynamically 
generated based on the current Terraform workspace.
The content includes information about the project group, email, and team members.
Each team member is represented as a dictionary with name, email, and password.
*/
resource "local_file" "output_file" {
  filename = "./projects/${terraform.workspace}/output.yaml"

  content = yamlencode({
    group: module.google_ws_team.project_group_name,
    email: module.google_ws_team.project_group_email, 
    team: [ for member in module.google_ws_team.team_members : {
      name: member.name,
      email: member.email,
      password: member.password
    }],
  })
}