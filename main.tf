# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

module "aft" {
  source = "github.com/aws-ia/terraform-aws-control_tower_account_factory?ref=1.11.1"
  # Required Vars
  ct_management_account_id    = var.ct_management_account_id
  log_archive_account_id      = var.log_archive_account_id
  audit_account_id            = var.audit_account_id
  aft_management_account_id   = var.aft_management_account_id
  ct_home_region              = data.aws_region.current.name
  aft_vpc_endpoints = false
  # VCS Vars
  vcs_provider                                  = "github"
  account_request_repo_name                     = var.repo_aft_account_requests
  global_customizations_repo_name               = var.repo_aft_global_customizations
  account_customizations_repo_name              = var.repo_aft_account_customizations
  account_provisioning_customizations_repo_name = var.repo_aft_account_provisioning_customizations
  # TF Vars
  terraform_distribution = "tfc"
  terraform_token        = var.terraform_aft_token
  terraform_org_name     = local.tfc_current_organization_name
  # AFT Feature Flags
  aft_feature_delete_default_vpcs_enabled = true
}

# AWS Base OUs
resource "aws_organizations_organizational_unit" "suspended" {
  name = "Suspended"
  parent_id = data.aws_organizations_organization.current_organization.roots[0].id
}

resource "aws_organizations_organizational_unit" "development" {
  name = "Development"
  parent_id = data.aws_organizations_organization.current_organization.roots[0].id
}

resource "aws_organizations_organizational_unit" "production" {
  name = "Production"
  parent_id = data.aws_organizations_organization.current_organization.roots[0].id
}

resource "aws_iam_user" "terraform_organizations_read_only" {
  name = "terraform_organizations_read_only"
}

resource "aws_iam_user_policy_attachment" "attach-user" {
  user = aws_iam_user.terraform_organizations_read_only.name
  policy_arn = data.aws_iam_policy.AWSOrganizationsReadOnlyAccess.arn
}

resource "aws_iam_access_key" "terraform_organizations_read_only" {
  user = aws_iam_user.terraform_organizations_read_only.name
}

resource "tfe_variable" "organizations_read_only_access_key_id" {
  key = "organizations_read_only_access_key_id"
  value = aws_iam_access_key.terraform_organizations_read_only.id
  category = "terraform"
  description = "AWS_ACCESS_KEY_ID for Organization R/O Account"
  variable_set_id = data.tfe_variable_set.aft.id
  sensitive = false
}

resource "tfe_variable" "organizations_read_only_secret_access_key" {
  key = "organizations_read_only_secret_access_key"
  value = aws_iam_access_key.terraform_organizations_read_only.secret
  category = "terraform"
  description = "AWS_SECRET_ACCESS_KEY for Organization R/O Account"
  variable_set_id = data.tfe_variable_set.aft.id
  sensitive = true
}

# AWS Service Quota increase from 10 -> 100 accounts
resource "aws_servicequotas_service_quota" "maximum_accounts" {
  quota_code = "L-29A0C5DF"
  service_code = "organizations"
  value = 100

  lifecycle {
    ignore_changes = all
  }
}

# AWS Service Quota increase from 1 build -> 25 builds
resource "aws_servicequotas_service_quota" "codebuild_concurrency" {
  provider = aws.aft_management
  quota_code = "L-2DC20C30"
  service_code = "codebuild"
  value = 25

  lifecycle {
    ignore_changes = all
  }
}
