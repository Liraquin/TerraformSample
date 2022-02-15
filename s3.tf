
# AWS Bucket AdmApp
resource "aws_s3_bucket" "tfbucket" {
  for_each = var.bucketName
  bucket = each.key
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "AES256"
      }
    }
  }

  versioning {
    enabled = true
  }

}

# Bucket public access rules
resource "aws_s3_bucket_public_access_block" "bucketAccessBlock" {
  for_each = var.bucketName
  bucket = each.key
  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
  depends_on = [
  aws_s3_bucket.tfbucket,
  ]
}

# AWS Bucket Policy
resource "aws_s3_bucket_policy" "bucketPolicy" {
  for_each = aws_s3_bucket.tfbucket
  bucket = each.key
  policy = (jsonencode({
    Version = "2008-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = var.azionUser
        }
        Action = "s3:Get*"
        Resource = "${each.value.arn}/*"
      },
      {
        Sid = "AllowSSLRequestsOnly"
        Effect = "Deny"
        Principal = {
          AWS = "*"
        }
        Action = "s3:*"
        Resource = [
          "${each.value.arn}",
          "${each.value.arn}/*",
        ]
        Condition = {
          Bool = {
            "aws:SecureTransport": "false"
          }
        }
      }      
    ]
  }))
  depends_on = [
  aws_s3_bucket_public_access_block.bucketAccessBlock,
  ]
}