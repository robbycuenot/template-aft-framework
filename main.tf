# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

module "aft" {
  source = "github.com/aws-ia/terraform-aws-control_tower_account_factory?ref=1.10.3"
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
  terraform_token        = var.terraform_token
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

# AWS Service Quota increase from 10 -> 100 accounts
# resource "aws_servicequotas_service_quota" "maximum_accounts" {
#   quota_code = "L-29A0C5DF"
#   service_code = "organizations"
#   value = 100
# }
