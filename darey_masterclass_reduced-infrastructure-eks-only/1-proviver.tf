terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

############################
#creating bucket for s3 backend
########################

resource "aws_s3_bucket" "global" {
  bucket = "topesan-dev-terraform-buckett"
  # Enable versioning so we can see the full revision history of our state files
  versioning {
    enabled = true
  }
}
# Enable server-side encryption by default
# server_side_encryption_configuration {
#     rule {
#       apply_server_side_encryption_by_default {
#         kms_master_key_id = aws_kms_key.mykey.arn
#         sse_algorithm     = "AES256"
#       }
#     }
#   }
# }


# resource "aws_dynamodb_tag" "global" {
#   resource_arn = replace(aws_dynamodb_table.example.arn, data.aws_region.current.name, data.aws_region.alternate.name)
#   key          = "Architect"
#   value        = "Gigi"
# }