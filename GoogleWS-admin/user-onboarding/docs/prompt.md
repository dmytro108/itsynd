## Prompt for AI GPT Tool:

Generate Terraform code to automate the setup of Google Workspace for project teams, with an emphasis on modularity, security, and flexibility for handling multiple project teams across various domains. The solution must encompass the following enhanced requirements:

1. **Terraform Module**: Implement the Google Workspace setup logic as a Terraform module. This module should encapsulate the functionality for creating Google Groups, user accounts, and adding users to the group based on the project details provided in an input YAML file.

2. **Multiple Environments Support**: Design the Terraform configuration to support multiple project teams and domains efficiently. This should include:
   - The ability to switch between different environments easily, with distinct configurations for each project team or domain.
   - Separate directories for input files, Google Workspace credentials, and output files for each environment to ensure organization and isolation.

3. **Security for Sensitive Data**:
   - Utilize tools like SOPS (Secrets OPerationS) to encrypt and securely manage sensitive data such as passwords, API keys, and Google Workspace credentials.
   - Ensure that the Terraform module and scripts do not expose sensitive information in plaintext, especially in state files or outputs.

4. **Self-Documenting and Well-Commented Code**:
   - The Terraform code should be self-documented, with clear and concise comments explaining the purpose and functionality of each section or resource.
   - Include comments on how to use the Terraform module, specifying any prerequisites and how to configure the module for different environments.

5. **DRY (Don't Repeat Yourself) Principle**:
   - Adhere to the DRY principle to avoid redundancy. Utilize Terraform's features such as variables, locals, and modules to abstract and reuse code efficiently.
   - Ensure that the module design allows for easy updates and maintenance, with reusable components for creating users, groups, and managing memberships.

6. **Best Practices and Security**: Ensure the script adheres to Terraform best practices, including the use of locals for repeated expressions, clear resource naming, and secure handling of sensitive data. 
   
7. **Avoidance of Deprecated Features:**
  - The Terraform code must avoid deprecated methods, functions, and approaches. Ensure compatibility with the latest version of Terraform and follow the latest recommendations for resource management, data handling, and provider usage.
  - Regularly review Terraform and provider documentation to ensure the code remains up-to-date with best practices and features.

8. **Functional Requirements**:
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

9.  **Provider Configuration Placeholder**: The Terraform code should include placeholders for necessary provider configurations, guiding users on how to supply their Google Workspace credentials securely.

Create Terraform code that meets these comprehensive specifications, focusing on security, modularity, environmental flexibility, documentation, and code efficiency.

---
