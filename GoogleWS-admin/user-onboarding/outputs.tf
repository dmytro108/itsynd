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
