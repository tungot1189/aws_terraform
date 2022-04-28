############################
# Set these in variables.tfvars
############################

variable "credentials_file" {
  description = "Shared credentials file"
}

variable "profile" {
  description = "The aws profile"
}

variable "key_name" {
  description = "The name of the Key Pair that can be used to SSH to each instance in the cluster"
}

variable "region" {
  description = "The region to deploy to the resources to"
}

variable "application" {
  description = "The name or name prefix of the application and associated resources"
}

variable "vpc_cidr_block" {
  description = "The VPC CIDR address range"
  #https://docs.docker.com/docker-for-aws/faqs/#recommended-vpc-and-subnet-setup
  default = "172.31.0.0/16"
}

variable "public_subnet_zone" {
  default = "ap-southeast-1a"
}

variable "public_subnet_cidr" {
  description = "The public subnet CIDR address range"
  default     = "172.31.1.0/24"
}

variable "controller_count" {
  default = "1"
}

variable "controller_subnet_cidr" {
  type    = list(string)
  default = ["172.31.10.0/24"]
}

variable "controller_subnet_zones" {
  type    = list(string)
  default = [""]
}

variable "worker_group_count" {
  default = "1"
}

variable "worker_count" {
  default = "1"
}

variable "worker_subnet_cidr" {
  type    = list(string)
  default = ["172.31.20.0/24", "172.31.21.0/24"]
}

variable "worker_subnet_zones" {
  type = list(string)

  default = ["ap-southeast-1a", "ap-southeast-1b"]
}

variable "manager_group_count" {
  default = "1"
}

variable "manager_count" {
  default = "3"
}

variable "manager_subnet_cidr" {
  type = list(string)

  default = ["172.31.30.0/24"]
}

variable "manager_subnet_zones" {
  type = list(string)

  default = ["ap-southeast-1c"]
}

variable "nat_count" {
  default = "1"
}

variable "nat_subnet_cidr" {
   type = list(string)

  default = ["172.31.40.0/24"]
}

variable "nat_subnet_zones" {
  type = list(string)

  default = ["us-east-1c"]
}

variable "connection_user" {
  default = "ubuntu"
}

variable "gluster_volume_size" {
  type    = number
  default = 16
}