Azure Terraform Multi-Environment Setup
📖 Overview

This project demonstrates a reusable Terraform module design for provisioning Azure infrastructure along with a GitHub Actions CI/CD pipeline.

The solution includes:

Reusable VNet module
Environment-based structure (dev)
VM deployment using module outputs
Remote backend configuration
GitHub Actions pipeline with validation and deployment stages
🏗️ Architecture
Azure Virtual Network (VNet)
Subnets with NSG rules
Virtual Machine
Storage Account (for backend/state)
GitHub Actions pipeline for CI/CD
📂 Repository Structure
.
├── addons/
│   ├── vnet/        # Reusable VNet module
│   └── vm/          # VM module
├── env/
│   └── dev/         # Environment-specific configuration
├── .github/
│   └── workflows/   # CI/CD pipeline
⚙️ Prerequisites
Azure Subscription
Terraform installed
Azure CLI installed
GitHub repository with Actions enabled
🚀 How to Use
1. Clone the repository
git clone https://github.com/praveen-terraform/azure-terraform.git
cd azure-terraform
2. Configure variables

Update values in:

env/dev/terraform.tfvars
3. Initialize Terraform
cd env/dev
terraform init
4. Validate and plan
terraform validate
terraform plan
🔁 CI/CD Pipeline (GitHub Actions)

The pipeline includes:

Stage 1: Validate
Terraform Init
Terraform Format Check
Terraform Validate
Terraform Plan
Stage 2: Deploy (POC)
Deployment stage included
terraform apply is intentionally skipped to avoid Azure cost
🔐 Authentication

Authentication is handled using:

Azure App Registration (Service Principal)
GitHub OIDC (no secrets required for credentials)
📘 Design Decisions & Implementation Details
1. Outputs and their purpose

I exposed outputs such as Resource Group name, VNet ID, subnet IDs, and storage account name, as these are commonly consumed by downstream modules. This ensures the module supports integration with other infrastructure components.

2. Module usability

To make the module easy to consume, I documented required inputs, optional inputs, input structure, example usage, and outputs. This allows users to use the module without understanding internal implementation details.

3. Documentation automation

Documentation is automated using terraform-docs, which generates README sections from variables and outputs. This ensures documentation remains consistent with the code.

4. Module testing

The module is tested by consuming it in the dev environment and running:

terraform validate
terraform plan

These checks are also integrated into the GitHub pipeline for continuous validation.

5. Environment design (Resource Groups vs Subscriptions)

For this POC, Resource Groups are used to separate environments due to simplicity and cost efficiency. For production systems, separate subscriptions can be used for stronger isolation and governance.

6. Naming and tagging strategy

Naming convention:

prefix-environment-region-resource

Example:

tf-dev-eastus-vnet

Tags used:

Environment
Region
ManagedBy
7. Flexibility and reusability

To avoid repetition, I used:

Variables
terraform.tfvars
locals

This allows reuse of the same code across environments with minimal changes.

8. Tagging and enforcement

Standard tags are defined in locals and merged with user input.
Enforcement can be strengthened using Azure Policy.

9. Useful outputs

Outputs such as VNet ID, subnet IDs, and VM details are exposed to support downstream integrations and operational visibility.

10. Release lifecycle

The GitHub Actions pipeline follows a structured lifecycle:

Validate Terraform configuration
Generate execution plan
Deploy infrastructure (skipped in POC)

This design supports scaling to multiple environments like QA and Production.

⚠️ Note

Deployment steps are included but skipped in this POC to avoid unnecessary Azure costs. They can be enabled by uncommenting the terraform apply step in the pipeline.

🏆 Conclusion

This project demonstrates:

Reusable Terraform module design
Environment-based infrastructure setup
CI/CD pipeline using GitHub Actions
Best practices for naming, tagging, and validation# azure-terraform
To test azure infra provisioning using terraform 
