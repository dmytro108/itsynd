### Scenario
As a newly onboarded DevOps engineer, I've received a request to automate the process of setting up Google Workspace for new project teams. The goal was to make the process faster, more efficient, and secure.

Our company needed a better way to handle the growing task of setting up Google Workspace for new project teams. The manual process was slow and prone to errors. This project involved creating an automated system that could quickly set up workspace resources securely for any team.

### Tasks
1. Create a Terraform module to automate the setup of Google Workspace for project teams:
    1. Create a Google Group with the group name derived from the project name and the group email formatted as `<project_name_without_spaces>@<domain>`.
    2. Create user accounts for each team member with email `<first_letter_of_name>.<surname>@<domain>` and temporary passwords.
    3. Add all users to the Google Group.
2. Design the Terraform configuration to support multiple project teams and domains.
3. The main Terraform configuration:
    1. Reads input data from a YAML file containing the domain, project name, and team members' details. 
    2. Utilizes the Terraform module to setup project team in Google Workspace
    3. Generates an output YAML file with the Google Group and user emails.
4.  Ensure that the Terraform module and scripts do not expose sensitive information in plaintext. Utilize tools like SOPS (Secrets OPerationS) to encrypt and securely manage sensitive data such as passwords, API keys, and Google Workspace credentials.