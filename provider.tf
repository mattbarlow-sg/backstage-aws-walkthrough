provider "aws" {
//  allowed_account_ids = var.account_numbers
    region              = var.region
      default_tags {
    tags = local.common_tags
  }
}

// Use these blocks when you need to deploy resources across regions from a single apply

//provider "aws" {
//  allowed_account_ids = var.account_numbers
//  region              = "us-east-1"
//  alias               = "us-east-1"
//  access_key          = var.access_key
//  secret_key          = var.secret_key
//  token               = var.token
//  profile             = var.aws_profile
//}
//
//provider "aws" {
//  allowed_account_ids = var.account_numbers
//  region              = "us-east-2"
//  alias               = "us-east-2"
//  access_key          = var.access_key
//  secret_key          = var.secret_key
//  token               = var.token
//  profile             = var.aws_profile
//}
//
//provider "aws" {
//  allowed_account_ids = var.account_numbers
//  region              = "us-west-1"
//  alias               = "us-west-1"
//  access_key          = var.access_key
//  secret_key          = var.secret_key
//  token               = var.token
//  profile             = var.aws_profile
//}
//
//provider "aws" {
//  allowed_account_ids = var.account_numbers
//  region              = "us-west-2"
//  alias               = "us-west-2"
//  access_key          = var.access_key
//  secret_key          = var.secret_key
//  token               = var.token
//  profile             = var.aws_profile
//}
//
//provider "aws" {
//  allowed_account_ids = var.account_numbers
//  region              = "ap-southeast-2"
//  alias               = "ap-southeast-2"
//  access_key          = var.access_key
//  secret_key          = var.secret_key
//  token               = var.token
//  profile             = var.aws_profile
//}
