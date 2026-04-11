**Azure Terraform Multi-Environment Setup**

**Overview**

This project demonstrates a reusable Terraform module design for provisioning Azure infrastructure along with a GitHub Actions CI/CD pipeline.

The solution includes:

Reusable VNet module

Environment-based structure (dev)

VM deployment using module outputs

Remote backend configuration

GitHub Actions pipeline with validation and deployment stages

**Architecture**

Azure Virtual Network (VNet)

Subnets with NSG rules

Virtual Machine

Storage Account (for backend/state)

**GitHub Actions pipeline for CI/CD**

The pipeline includes:

Stage 1: Validate

Terraform Init
 Terraform Format Check
 
 Terraform Validate

Terraform Plan

Stage 2: Deploy (POC)

Deployment stage included

terraform apply is intentionally skipped to avoid Azure cost

**Authentication**

Authentication is handled using:

Azure App Registration, 
GitHub OIDC

**Implementation Details**

1.	What outputs you would add and why? 
I exposed outputs in this POC that are commonly consumed by other modules, especially Resource_Group ,subnet IDs, VNet ID and Storage account name because reusable modules should not only create resources but also make integration with higher-level infrastructure easier.
2.	What information would someone need in order to use this module?
To make the module easy to consume, I would document the required inputs, optional inputs, input object structure, example usage, and outputs. This helps others adopt the module without reading all the internal code.
3.	Bonus: how would I automate documentation? - 
For documentation automation, I would use terraform-docs. It reads variables and outputs from the module and generates a README section automatically, which keeps documentation consistent with the code.
4.	Super extra points if your module is tested - 
Yes. I tested it by consuming the module from the dev environment and running Terraform validation and planning successfully. I also included those checks in the GitHub pipeline so the module is continuously validated.
5.	Argument why would you use Resource Groups or Subscriptions for multiple environments. - 
When designing multiple environments in Azure (like dev, test, prod), choosing between Resource Groups (RGs) and Subscriptions depends on isolation, governance, cost, and scale.
6.	Name and label resources to make environment and region clear - 
I use a naming convention like prefix-environment-region-resource (e.g., tf-dev-eastus-vnet) and apply tags such as Environment, Region, and ManagedBy for easy identification and tracking.
7.	Avoid repeating values—how can you make this flexible? -  
I use variables, terraform.tfvars, and locals to centralize reusable values, so only environment-specific inputs change while the core code remains reusable.
8.	How might you label resources for better tracking? How would you enforce this? -  
I define standard tags like Environment, Owner, and Project in locals and enforce them by merging with input tags; this can be further enforced using Azure Policy.
9.	What outputs might be useful and why? -  
I exposed outputs like VNet ID, subnet IDs, and VM details, as they are commonly required by downstream modules and for operational visibility.
10.	Bonus: GitHub pipeline and release lifecycle -  
I implemented a GitHub Actions pipeline with validation and deployment stages, where code is validated first and then deployed with optional approvals, enabling a scalable multi-environment release flow.
