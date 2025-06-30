output "repository_url" {
  description = "URL of the created repository"
  value       = module.repository.html_url
}

output "repository_full_name" {
  description = "Full name of the repository (org/name)"
  value       = module.repository.full_name
}

output "git_clone_url" {
  description = "Git clone URL of the repository"
  value       = module.repository.git_clone_url
}