## ---------------------------------------------------------------------------------------------------------------------
## Static PARAMETERS
## These variables are hard-coded and should not be overridden
## ---------------------------------------------------------------------------------------------------------------------


variable "security_groups" {
  description = "AWS Security Group information, including rule information."
  default = {
    gw = {
      description = "AWS Security Group for Workspot Gateways in DMZ subnets."
      ingress_rules = {
        rule-1 = {
          description = "Secure RDP tunnel."
          cidr_ipv4   = "0.0.0.0/0"
          ip_protocol = "tcp"
          from_port   = 443
          to_port     = 443
          tags = {
            service = "gateway"
          }
        },
        rule-2 = {
          description = "Performance RDP port."
          cidr_ipv4   = "0.0.0.0/0"
          ip_protocol = "udp"
          from_port   = 3391
          to_port     = 3391
          tags = {
            service = "gateway"
          }
        },
        rule-3 = {
          description = "CS IP Address"
          cidr_ipv4   = "73.105.100.170/32"
          ip_protocol = "tcp"
          from_port   = 3389
          to_port     = 3389
          tags = {
            service = "cs-access"
          }
        },
        rule-4 = {
          description = "CS IP Address"
          cidr_ipv4   = "23.126.202.4/32"
          ip_protocol = "tcp"
          from_port   = 3389
          to_port     = 3389
          tags = {
            service = "cs-access"
          }
        }
      }
      egress_rules = {}
      tags = {
        service = "gateway"
      }
    },
    ec = {
      description   = "AWS Security Group for Workspot Enterprise Connectors in ECMGMT subnets."
      ingress_rules = {}
      egress_rules  = {}
      tags = {
        service = "enterprise_connector"
      }
    },
    cloudpc = {
      description   = "AWS Security Group for the Workspot Desktops."
      ingress_rules = {}
      egress_rules  = {}
      tags = {
        service = "cloud_pc"
      }
    }
  }
}

variable "default_tags" {
  description = "Tags applied to resources by default if none specified."
  default = {
    environment = "prod"
    createdBy   = "terraform"
    managedBy   = "workspot"
    team        = "devops"
  }
}


variable "security_group_default_rules" {
  description = "Rules for all the standard Workspot security groups."
  default = {
    ingress_rules = {
      d-i-rule-1 = {
        description = "Allow private IP - 10.0.0.0/8 addresses."
        cidr_ipv4   = "10.0.0.0/8"
        ip_protocol = -1
        from_port   = null
        to_port     = null
        tags = {
          service = "default"
        }
      },
      d-i-rule-2 = {
        description = "Allow private IP - 172.16.0.0/12 addresses."
        cidr_ipv4   = "172.16.0.0/12"
        ip_protocol = -1
        from_port   = null
        to_port     = null
        tags = {
          service = "default"
        }
      },
      d-i-rule-3 = {
        description = "Allow private IP - 192.168.0.0/16 addresses."
        cidr_ipv4   = "192.168.0.0/16"
        ip_protocol = -1
        from_port   = null
        to_port     = null
        tags = {
          service = "default"
        }
      }
    },
    egress_rules = {
      d-e-rule-1 = {
        description = "Allow all outbound traffic."
        cidr_ipv4   = "0.0.0.0/0"
        ip_protocol = -1
        tags = {
          service = "default"
        }
      }
    }
  }
}


variable "ec2_instances" {
  description = "Instances to deploy for Workspot infrastructure."
  default = {
    enterprise_connector = {
      vm_count          = 2
      name              = "ec"
      most_recent       = true
      instance_type     = "t2.large"
      ami_name          = ["Windows_Server-2019-English-Full-Base-*"]
      get_password_data = true
      tags = {
        service = "enterprise_connector"
      }
    },
    gateway = {
      vm_count          = 2
      name              = "gw"
      most_recent       = true
      instance_type     = "t2.large"
      ami_name          = ["Windows_Server-2019-English-Full-Base-*"]
      get_password_data = true
      tags = {
        service = "gateway"
      }
    }
  }
}


variable "nat_gateway" {
  description = "Properties of the NAT gateway."
  default = {
    tags = {
      service = "internet"
      zone    = "dmz"
    }
  }
}


variable "workspaces_az_ids" {
  description = "DO NOT OVERRIDE - Map of AWS Region code to Support AZ IDs for Workspaces"
  default = {
    us-east-1      = ["use1-az2", "use1-az4", "use1-az6"]
    us-west-2      = ["usw2-az1", "usw2-az2", "usw2-az3"]
    ap-south-1     = ["aps1-az1", "aps1-az2", "aps1-az3"]
    ap-northeast-2 = ["apne2-az1", "apne2-az3"]
    ap-southeast-1 = ["apse1-az1", "apse2-az2"]
    ap-southeast-2 = ["apse2-az1", "apse2-az3"]
    ap-northeast-1 = ["apne1-az1", "apne1-az4"]
    ca-central-1   = ["cac1-az1", "cac1-az2"]
    eu-central-1   = ["euc1-az2", "euc1-az3"]
    eu-west-1      = ["euw1-az1", "euw1-az2", "euw1-az3"]
    eu-west-2      = ["euw2-az2", "euw2-az3"]
    sa-east-1      = ["sae1-az1", "sae1-az3"]
    af-south-1     = ["afs1-az1", "afs1-az2", "afs1-az3"]
  }
}