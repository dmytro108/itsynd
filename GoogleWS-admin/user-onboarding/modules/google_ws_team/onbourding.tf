locals {
  team_members_list = [for member in var.team : "${member.name}.${member.surname}"]

  team_members = { for member in var.team : "${member.name}.${member.surname}" => {
    name    = member.name
    surname = member.surname
    role    = member.role
    email   = "${lower(substr(member.name, 0, 1))}.${lower(replace(member.surname, " ", ""))}@${var.domain}"
  } }

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

