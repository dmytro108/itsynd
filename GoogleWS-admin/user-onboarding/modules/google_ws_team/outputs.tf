# Output the project group ID
output "project_group_id" {
  value = googleworkspace_group.project_group.id
}

# Output the project group name
output "project_group_name" {
  description = "The name of the Google group"
  value       = googleworkspace_group.project_group.name
}

# Output the project group email
output "project_group_email" {
  description = "The email of the Google group"
  value       = googleworkspace_group.project_group.email
}

# Output the list of team members with their emails and passwords
output "team_members" {
  description = "List of team members with their emails and passwords"
  value = [for member in local.team_members_list : {
    name     = googleworkspace_user.team_members[member].name[0].full_name
    email    = googleworkspace_user.team_members[member].primary_email
    password = random_password.password[member].result
  }]
}