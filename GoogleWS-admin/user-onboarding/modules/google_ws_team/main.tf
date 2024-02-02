# This file contains the main configuration for the Google Workspace team module.
# This Terraform module is responsible for onboarding a team of users to Google Workspace.
# It creates a Google Workspace group for the project, generates a random password for each team member,
# creates Google Workspace users for each team member, and adds them to the project group.

# Inputs:
# - var.team: A list of objects representing team members, each with the following attributes:
#   - name: The first name of the team member.
#   - surname: The last name of the team member.
#   - role: The role of the team member.
# - var.project_name: The name of the project.
# - var.domain: The domain for the email addresses.

# Outputs:
# - googleworkspace_group.project_group: The created Google Workspace group for the project.
# - googleworkspace_user.team_members: A map of the created Google Workspace users for each team member.

# Example usage:
# module "google_ws_team" {
#   source        = "./modules/google_ws_team"
#   team          = [
#     {
#       name    = "John"
#       surname = "Doe"
#       role    = "Developer"
#     },
#     {
#       name    = "Jane"
#       surname = "Smith"
#       role    = "Designer"
#     }
#   ]
#   project_name  = "My Project"
#   domain        = "example.com"
# }
locals {
# The team_members_list is a list of strings that combines the name and surname of 
# each team member. This is used as a iteration parameter (for_each) for resources such as
# team member random passwords and Google Workspace user accounts.
    team_members_list = [for member in var.team : "${member.name}.${member.surname}"]

# The team_members is a map that contains detailed information about each team member, 
# including their name, surname, role, and generated email address like
#  <name_first_letter>.<surname_without_spaces>@<domain>
    team_members = { for member in var.team : "${member.name}.${member.surname}" => {
      name    = member.name
      surname = member.surname
      role    = member.role
      email   = "${lower(substr(member.name, 0, 1))}.${lower(replace(member.surname, " ", ""))}@${var.domain}"
    } }

# generated group email address like
#  <project_name_without_spaces>@<domain>
    group_email = "${lower(replace(var.project_name, " ", ""))}@${var.domain}"
}

# Generate a random password for each team member
resource "random_password" "password" {
  for_each = toset(local.team_members_list)

  length           = 16
  special          = true
  override_special = "_%@"
}

# Create a Google Workspace group for the project
resource "googleworkspace_group" "project_group" {
  email       = local.group_email
  name        = "${var.project_name} team"
  description = "Group for project ${var.project_name}"
}

# Create Google Workspace users for each team member
resource "googleworkspace_user" "team_members" {
  for_each = toset(local.team_members_list)

  primary_email                 = local.team_members[each.key].email
  password                      = md5(random_password.password[each.key].result)
  change_password_at_next_login = true
  name {
    family_name = local.team_members[each.key].surname
    given_name  = local.team_members[each.key].name
  }
}

# Add team members to the project group
resource "googleworkspace_group_member" "group_members" {
  for_each = toset(local.team_members_list)

  group_id = googleworkspace_group.project_group.id
  email    = googleworkspace_user.team_members[each.key].primary_email
  role     = "MEMBER"
}

