## ---------------------------------------------------------------------------------------------------------------------
## MODULE PARAMETERS
## These variables are expected to be passed in by the operator
## ---------------------------------------------------------------------------------------------------------------------


/* variable "region" {
  description = "Region for deployment"
  default     = "us-east-1"
} */

/* variable "customer_shortname" {
  description = "Short name used to name cloud components."
  default     = "acme"
} */

/* variable "vpc" {
  description = "AWS VPC for Workspot resources."
  default = {
    cidr_block         = "10.100.0.0/22"
    enable_dns_support = true
    tags = {
      Name = "acme-workspot-vpc"
    }
  }
} */

/* variable "subnets" {
  description = "AWS subnets for Workspot infrastructure components."
  default = {
    dmz = {
      cidr_blocks = ["10.100.3.224/28", "10.100.3.240/28"]
      name        = "subnet-dmz"
      tags = {
        service = "gateway"
        zone    = "dmz"
      }
    },
    ec_mgmt = {
      cidr_blocks = ["10.100.3.192/28", "10.100.3.208/28"]
      name        = "subnet-ecmgmt"
      tags = {
        service = "enterprise_connector"
        zone    = "internal"
      }
    },
    ad_connector = {
      cidr_blocks = ["10.100.3.160/28", "10.100.3.176/28"]
      name        = "subnet-adconnector"
      tags = {
        service = "ad_connector"
        zone    = "internal"
      }
    }
    cloud_pc = {
      cidr_blocks = ["10.100.0.0/24", "10.100.1.0/24"]
      name        = "subnet-cloudpc"
      tags = {
        service = "cloud_pc"
        zone    = "internal"
      }
    }
  }
} */


/* variable "route_table" {
  description = "Properties of the route table."
  default = {
    cidr_block = "0.0.0.0/0"
  }
} */


/* variable "key_pair" {
  description = "Key_pair to access created EC2 instances."
  default     = "cs-justin-keypair"
} */


## ---------------------------------------------------------------------------------------------------------------------
## VAR FILE VARIABLES
## Define these secrets as var file variables and use with parameter: -var-file
## Example: terraform apply -var-file="secrets.tfvars"
## ---------------------------------------------------------------------------------------------------------------------

/* variable "aws_access_key" {
  description = "AWS Access Key for Terraform. "
} */


/* variable "aws_secret_key" {
  description = "AWS Secret Key for Terraform."
} */