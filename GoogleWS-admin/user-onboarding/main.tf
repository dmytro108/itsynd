module "google_ws_team" {
  source = "./modules/google_ws_team"

  domain       = local.input_data.domain
  project_name = local.input_data.project

  team = local.input_data.team

}



