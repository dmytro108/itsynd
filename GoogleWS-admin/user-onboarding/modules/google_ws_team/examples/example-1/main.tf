module "google_ws_team" {
  source        = "./modules/google_ws_team"

  # Google workspace domain
  domain        = "example.com"

  # Project Name
  project_name  = "My Project"

  # Team detailes: 
  team          = [
    {
      name    = "John"
      surname = "Doe"
      role    = "Developer"
    },
    {
      name    = "Jane"
      surname = "Smith"
      role    = "Designer"
    }
  ]

 }