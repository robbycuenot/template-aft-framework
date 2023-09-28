variable "ct_management_account_id" {
  description = "Control Tower Management Account ID"
}

variable "log_archive_account_id" {
  description = "Control Tower Log Archive Account ID"
}

variable "audit_account_id" {
  description = "Control Tower Audit Account ID"
}

variable "aft_management_account_id" {
  description = "Control Tower AFT Management Account ID"
}

variable "github_installation_id" {
  description = "GitHub installation ID"
  default = ""
}

variable "github_owner" {
  description = "Github Owner"
  default = ""
}

variable "github_token" {
  description = "GitHub Token for creating account repos"
  default = ""
}

variable "organizations_read_only_access_key_id" {
  description = "AWS_ACCESS_KEY_ID for Organization R/O Account"
  default = ""
}

variable "organizations_read_only_secret_access_key" {
  description = "AWS_SECRET_ACCESS_KEY for Organization R/O Account"
  default = ""
}

variable "repo_aft_account_customizations" {
  description = "Repository for AFT Account Customizations"
}

variable "repo_aft_account_provisioning_customizations" {
  description = "Repository for AFT Account Provisioning Customizations"
}

variable "repo_aft_account_requests" {
  description = "Repository for AFT Account Requests"
}

variable "repo_aft_framework" {
  description = "Repository for AFT Framework"
}

variable "repo_aft_global_customizations" {
  description = "Repository for AFT Global Customizations"
}

variable "terraform_token" {
  description = "Terraform User API Token"
}

variable "TFC_WORKSPACE_SLUG" {
  description = "DO NOT SET - Managed by TFC - Terraform Cloud workspace slug"
  sensitive    = true
}
