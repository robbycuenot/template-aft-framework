provider "tfe" {
  token    = var.terraform_aft_token
}

provider "aws" {
  alias  = "aft_management"
  region = data.aws_region.current.name
  assume_role {
    role_arn     = "arn:${data.aws_partition.current.partition}:iam::${var.aft_management_account_id}:role/AWSControlTowerExecution"
    session_name = local.aft_session_name
  }
  default_tags {
    tags = {
      managed_by = "AFT"
    }
  }
}