variable "region" {
  description = "This is the cloud hosting region where Terraform deploys your webapp"
  default = "us-west-1"
  
}

variable "prefix" {
  description = "This is the environemnt where Terraform deploys your webapp"
  default = "dev"
}
