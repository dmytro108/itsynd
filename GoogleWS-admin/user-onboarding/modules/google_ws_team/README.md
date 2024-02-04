<!-- BEGIN_TF_DOCS -->
## Module: google\_ws\_team
This Terraform module is responsible for onboarding a team of users to Google Workspace.
It creates a Google Workspace group for the project, generates a random password for each team member,
creates Google Workspace users for each team member, and adds them to the project group.
Inputs:
- var.team: A list of objects representing team members, each with the following attributes:
  - name: The first name of the team member.
  - surname: The last name of the team member.
  - role: The role of the team member.
- var.project\_name: The name of the project.
- var.domain: The domain for the email addresses.
Outputs:
- googleworkspace\_group.project\_group: The created Google Workspace group for the project.
- googleworkspace\_user.team\_members: A map of the created Google Workspace users for each team member.
### Example

```hcl
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
```
### Reference
#### Requirements

No requirements.
#### Providers

| Name | Version |
|------|---------|
| <a name="provider_googleworkspace"></a> [googleworkspace](#provider\_googleworkspace) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
#### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain"></a> [domain](#input\_domain) | E-mail domain | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of the project | `string` | n/a | yes |
| <a name="input_team"></a> [team](#input\_team) | Map of team members | <pre>list(object({<br>    role    = string<br>    name    = string<br>    surname = string<br>  }))</pre> | n/a | yes |

#### Outputs

| Name | Description |
|------|-------------|
| <a name="output_project_group_email"></a> [project\_group\_email](#output\_project\_group\_email) | The email of the Google group |
| <a name="output_project_group_id"></a> [project\_group\_id](#output\_project\_group\_id) | Output the project group ID |
| <a name="output_project_group_name"></a> [project\_group\_name](#output\_project\_group\_name) | The name of the Google group |
| <a name="output_team_members"></a> [team\_members](#output\_team\_members) | List of team members with their emails and passwords |
#### Resources

| Name | Type |
|------|------|
| [googleworkspace_group.project_group](https://registry.terraform.io/providers/hashicorp/googleworkspace/latest/docs/resources/group) | resource |
| [googleworkspace_group_member.group_members](https://registry.terraform.io/providers/hashicorp/googleworkspace/latest/docs/resources/group_member) | resource |
| [googleworkspace_user.team_members](https://registry.terraform.io/providers/hashicorp/googleworkspace/latest/docs/resources/user) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
<!-- END_TF_DOCS -->