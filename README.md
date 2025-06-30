# Terraform EKS Workspace Module

This module creates and configures a new GitHub repository for EKS cluster configuration, based on a template repository. It uses the terraform-github-repo module to manage the repository and its configuration.

## Features

- Creates a new GitHub repository from a template
- Configures repository settings and permissions
- Injects configuration files using managed_extra_files
- Sets up branch protection and access controls
- Configures CODEOWNERS and other repository files

## Usage

```hcl
module "eks_workspace" {
  source = "HappyPathway/repo/github"

  repository_name        = "my-eks-cluster"
  repository_description = "EKS Cluster configuration for my-eks-cluster"
  
  # Optional: Override template repository settings
  template_repo_org  = "my-org"
  template_repo_name = "custom-template"

  # Configuration for the EKS cluster
  cluster_config = {
    cluster_name    = "my-eks-cluster"
    cluster_version = "1.27"
    region          = "us-east-1"
    # Add other cluster configuration options
  }
}
```

## Requirements

- Terraform >= 1.0.0
- GitHub provider configured with appropriate permissions
- Access to the template repository

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| repository_name | Name of the repository to create | string | - | yes |
| repository_description | Description of the repository | string | null | no |
| template_repo_org | Organization containing the template repository | string | "HappyPathway" | no |
| template_repo_name | Name of the template repository | string | "template-eks-cluster" | no |
| cluster_config | Configuration for the EKS cluster | map(any) | {} | yes |

## Outputs

| Name | Description |
|------|-------------|
| repository_url | URL of the created repository |
| repository_full_name | Full name of the repository (org/name) |
| git_clone_url | Git clone URL of the repository |

## Implementation Details

The module implements the following workflow:

1. Creates a new repository using the terraform-github-repo module
2. Uses the specified template repository (default: HappyPathway/template-eks-cluster)
3. Injects the cluster configuration as a config.json file using managed_extra_files
4. Sets up repository settings, branch protection, and access controls
5. Configures CODEOWNERS and other repository files

This replaces the previous Lambda-based automation with a pure Terraform implementation, making it easier to manage and maintain.

## Migration Notes

This module replaces the previous Lambda-based automation (template-automation-lambda) with the following improvements:

- Pure Terraform implementation - no Lambda functions to maintain
- Direct integration with terraform-github-repo module
- Configuration managed through Terraform variables
- Simplified workflow and reduced complexity
- Better version control and change tracking