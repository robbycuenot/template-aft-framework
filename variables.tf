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
