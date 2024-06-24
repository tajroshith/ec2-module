variable "ami_ids" {
  description = "AMI's for instance"
  type = string

  validation {
    condition = length(var.ami_ids) >= 8 && substr(var.ami_ids, 0,4) == "ami-"
    error_message = "Please check the AMI that you specified."
  }
}

variable "azone" {
    description = "availability zone for the instances"
    type = string

    validation {
      condition = contains(["ap-south-1a","ap-south-1b"], var.azone)
      error_message = "Availability zone should either be ap-south-1a or ap-south-1b"
    }
}

variable "instance_type" {
  description = "Instance types"
  type = string
}

variable "key_name" {
  description = "Key name"
  type = string
}

variable "sg_name" {
    description = "security group name"
    type = string
    default = ""
}

variable "sg_description" {
    description = "description for security group"
    type = string
    default = null
}

variable "ingress" {
  description = "Ingress parameters"
  type = list(object({
    from_port = number
    to_port = number
    protocol = string
    cidr_blocks = list(string)
    description = string 
  }))
  default = [ {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    description = "Allow SSH"
    cidr_blocks = [ "0.0.0.0/0" ]
  } ]
}

variable "common-tags" {
  description = "common-tags for resources"
  type = map(string)
}

