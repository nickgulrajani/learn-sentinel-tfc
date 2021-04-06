provider "aws" {
  region = var.region
}

terraform {
  backend "remote" {
    organization = "wwtmulticloud"
    workspaces {
      name = "sentinel-policy-tests"
    }
   }
 }


resource "random_pet" "petname" {
  length    = 3
  separator = "-"
}

resource "aws_s3_bucket" "nicksentinelbucket" {
  bucket = "${var.prefix}-${random_pet.petname.id}"
  acl    = "public-read-write"
  tags = {
    Name        = "HashiCorp"
    Environment = "Learn"
  }
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::${var.prefix}-${random_pet.petname.id}/*"
            ]
        }
    ]
}
EOF

  website {
    index_document = "index.html"
    error_document = "error.html"

  }
  force_destroy = true
}

resource "aws_s3_bucket_object" "demo" {
  acl          = "public-read"
  key          = "index.html"
  bucket       = aws_s3_bucket.demo.id
  content      = file("${path.module}/assets/index.html")
  content_type = "text/html"

}
