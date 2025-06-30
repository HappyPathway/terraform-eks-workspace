
locals {
  # Convert repository config to JSON for config.json
  config_json = jsonencode(var.repository_config)
}

module "repository" {
  source = "HappyPathway/repo/github"

  name     = var.repository_name
  repo_org = var.github_org

  # Template repository configuration
  template_repo     = var.template_repository
  template_repo_org = var.template_organization

  github_default_branch = "repo-init"
  files_branch          = var.files_branch
  # Repository settings
  enforce_prs            = var.enforce_prs
  github_auto_init       = false # Not needed since we're using a template
  create_codeowners      = true
  github_codeowners_team = var.github_team
  admin_teams            = [var.github_team]

  # Branch protection and merge settings
  github_allow_merge_commit              = false
  github_allow_squash_merge              = true
  github_allow_rebase_merge              = false
  github_delete_branch_on_merge          = true
  github_required_approving_review_count = 1

  # Inject config.json using managed_extra_files
  managed_extra_files = [
    {
      path    = "config.json"
      content = local.config_json
    }
  ]
}

locals {
  created_repo = module.repository.github_repo
}

resource "github_repository_pull_request" "pr" {
  count           = var.pr.create ? 1 : 0
  base_repository = local.created_repo.name
  base_ref        = "main"
  head_ref        = var.files_branch
  title           = var.pr.title
  body            = var.pr.body
}