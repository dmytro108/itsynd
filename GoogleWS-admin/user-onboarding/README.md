<!-- BEGIN_TF_DOCS -->
# Portfolio project: Automating Google Workspace Setup with Terraform and AI tools
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
## Solution
### AI tools assistance
I decided to develop the automation tool with a twist – I added AI insights to make the process smarter and safer. 

With AI's help, I was able to make the development process quicker and protect sensitive information better. The success of this project showed my ability to use technology creatively to improve my work.

As an AI assistans I choose two tools integrated into VS Code - [CodeGPT](https://docs.codegpt.co/docs/intro) powered with OpenAI ChatGPT 4.0 and [GitHub Copilot](https://copilot.github.com/).

CodeGPT is a powerful AI tool that uses natural language processing to generate code based on the given prompt. GitHub Copilot is another AI tool that uses machine learning to suggest code snippets and complete lines of code as you type.

Overall, the AI tools' assistance helped me deliver a more efficient and secure solution for setting up Google Workspace for new project teams. It also showcased my ability to leverage technology and think outside the box to improve processes and workflows.

#### Prompt for AI GPT Tool:
I prepared the prompt for CodeGPT to generate Terraform code. The prompt includes all functional requirements as well asrequirements to the code quality like DRY, self-documenting, adherence to best practices, and avoidance of deprecated features.

Although I created a comprehensive prompt, this approach was not successful. The generated code did not covered all functional requirements but it gave the basic structure to build upon.

Much better worked approach where you feed the AI tool with non-functional requirements first and then prompt every functional requirements separately.

GitHub Copilot was exellent to generate code snippets directly in the code editor as I was coding. 

**Prompt:**
Generate Terraform code to automate the setup of Google Workspace for project teams, with an emphasis on modularity, security, and flexibility for handling multiple project teams across various domains. The solution must encompass the following enhanced requirements:

1. **Functional Requirements**:
   - **Read Input Data from a YAML File**: The module should accept a path to a YAML file containing the domain, project name, and team members' details. The main script should start by reading a YAML file named `input.yaml`, stored in the specified environment's folder. This file contains the domain, project name, and a list of team members. The format of the file is as follows:
    ```yaml
    Domain: "example.com"
    Project: "e-cars website"
    Team:
      - surname: Doe
        name: John
        role: developer
      - surname: Grant
        name: Alex
        role: designer
    ```
   - **Create a Google Group**: The module should create a Google Group with the group name derived from the project name (spaces removed and lowercase) and the group email formatted as `<project_name_without_spaces>@<domain>`. For example, for the project "e-cars website", the group email should be `e-carswebsite@example.com`.
   - **Create User Accounts**: The module needs to create a user account for each team member. The format for the user email should be `<first_letter_of_name>.<surname>@<domain>`, in lowercase and without spaces in the surname. Each user should have a temporary password, which is sent to the Google server in MD5 encoding. 
   - **Add Users to the Group**: Include all created users in the Google Group.
   - **Output YAML File**: Generate an `output.yaml` file detailing the Google Group and user emails, stored in the specified environment's folder. The format should be:
    ```yaml
    Group: <google group name>
    Email: <google group email>
    Team:
      - name: <full name>
        email: <user email>
        password: <temporary password>
    ```
2. **Provider Configuration Placeholder**: The Terraform code should include placeholders for necessary provider configurations, guiding users on how to supply their Google Workspace credentials securely.

3. **Terraform Module**: Implement the Google Workspace setup logic as a Terraform module. This module should encapsulate the functionality for creating Google Groups, user accounts, and adding users to the group based on the project details provided in an input YAML file.

4. **Multiple Environments Support**: Design the Terraform configuration to support multiple project teams and domains efficiently. This should include:
   - The ability to switch between different environments easily, with distinct configurations for each project team or domain.
   - Separate directories for input files, Google Workspace credentials, and output files for each environment to ensure organization and isolation.

5. **Security for Sensitive Data**:
   - Utilize tools like SOPS (Secrets OPerationS) to encrypt and securely manage sensitive data such as passwords, API keys, and Google Workspace credentials.
   - Ensure that the Terraform module and scripts do not expose sensitive information in plaintext, especially in state files or outputs.

6. **Self-Documenting and Well-Commented Code**:
   - The Terraform code should be self-documented, with clear and concise comments explaining the purpose and functionality of each section or resource.
   - Include comments on how to use the Terraform module, specifying any prerequisites and how to configure the module for different environments.

7. **DRY (Don't Repeat Yourself) Principle**:
   - Adhere to the DRY principle to avoid redundancy. Utilize Terraform's features such as variables, locals, and modules to abstract and reuse code efficiently.
   - Ensure that the module design allows for easy updates and maintenance, with reusable components for creating users, groups, and managing memberships.

8. **Best Practices and Security**: Ensure the script adheres to Terraform best practices, including the use of locals for repeated expressions, clear resource naming, and secure handling of sensitive data. 
   
9. **Avoidance of Deprecated Features:**
  - The Terraform code must avoid deprecated methods, functions, and approaches. Ensure compatibility with the latest version of Terraform and follow the latest recommendations for resource management, data handling, and provider usage.
  - Regularly review Terraform and provider documentation to ensure the code remains up-to-date with best practices and features.

Create Terraform code that meets these comprehensive specifications, focusing on security, modularity, environmental flexibility, documentation, and code efficiency.

### Reference
#### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_googleworkspace"></a> [googleworkspace](#requirement\_googleworkspace) | 0.7.0 |
#### Providers

| Name | Version |
|------|---------|
| <a name="provider_external"></a> [external](#provider\_external) | 2.3.2 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.4.1 |
#### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_googleworkspace_customer_id"></a> [googleworkspace\_customer\_id](#input\_googleworkspace\_customer\_id) | Google Workspace customer ID, needed for the Google Workspace provider | `string` | `""` | no |
#### Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_google_ws_team"></a> [google\_ws\_team](modules/google_ws_team) | ./modules/google_ws_team | n/a |
#### Outputs

No outputs.
#### Resources

| Name | Type |
|------|------|
| [local_file.output_file](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
### Results

<!-- END_TF_DOCS -->