variable "repository_name" {
  description = "Name of the repository to create"
  type        = string
}

variable "template_organization" {
  description = "GitHub organization containing the template repository"
  type        = string
  default     = "HappyPathway"
}

variable "template_repository" {
  description = "Name of the template repository to use"
  type        = string
  default     = "template-eks-cluster"
}

variable "repository_config" {
  description = "Configuration map that will be written to config.json"
  type        = map(any)

  validation {
    condition     = length(var.repository_config) > 0
    error_message = "repository_config must not be empty"
  }
}

variable "github_team" {
  description = "GitHub team to grant admin access"
  type        = string
  default     = "tf-module-admins"
}

variable "enforce_prs" {
  description = "Enforce pull request reviews"
  type        = bool
  default     = true
}

variable "github_org" {
  description = "GitHub organization where repository will be created"
  type        = string
  default     = "HappyPathway"
}

variable files_branch {
  description = "Branch to manage files on"
  type        = string
  default     = "repo-init"
}

variable pr {
  description = "Pull request configuration"
  type = object({
    create = bool
    title  = string
    body   = string
  })
  default = {
    create = true
    title  = "Initial commit"
    body   = "This PR initializes the repository with the template configuration."
  }
}