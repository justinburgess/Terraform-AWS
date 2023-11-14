resource "aws_s3_bucket" "bucket" {
  bucket = "workspot-bucket"

  tags = var.tags
}

resource "aws_iam_role" "acme_vmimport" {
  name = "acme_vmimport_role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "vmie.amazonaws.com"
        }
        Condition = {
          StringEquals = {
            "sts:Externalid" = "vmimport"
          }
        }
      },
    ]
  })

  inline_policy {
    name = "acme_vmimport_inline_policy"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = [
            "s3:GetBucketLocation",
            "s3:GetObject",
            "s3:ListBucket"
          ]
          Effect = "Allow"
          Resource = [
            aws_s3_bucket.bucket.arn,
            "${aws_s3_bucket.bucket.arn}/*"
          ]
        },
        {
          Effect = "Allow",
          Action = [
            "ec2:ModifySnapshotAttribute",
            "ec2:CopySnapshot",
            "ec2:RegisterImage",
            "ec2:Describe*"
          ],
          Resource = "*"
        }
      ]
    })
  }


  tags = var.tags
}