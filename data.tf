data "aws_organizations_organization" "current_organization" {}

data "aws_partition" "current" {}

data "aws_region" "current" {}

data "aws_iam_policy" "AWSOrganizationsReadOnlyAccess" {
  name = "AWSOrganizationsReadOnlyAccess"
}

data "tfe_organization" "current_organization" {
  name = local.tfc_current_organization_name
}

data "tfe_workspace" "current_workspace" {
  name         = local.tfc_current_workspace_name
  organization = data.tfe_organization.current_organization.name
}

data "tfe_variable_set" "aft" {
  name         = "aft"
  organization = data.tfe_organization.current_organization.name
}