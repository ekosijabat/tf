variable "region" {
  type = string
}

variable "IsUbuntu" {
  type    = bool
  default = true
}

variable "AZ1" {
  type = string
}

variable "subnet1_cidr" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "root_volume_size" {
  type = number
}

variable "vpc_id" {
  type = string
}

variable "ec2_asg_id" {
  type = string
}

variable "ami_ubuntu" {
  type = string
}

variable "ami_linux" {
  type = string
}

variable "akp_id" {
  type = string
}

variable "rds_endpoint" {
  type = string
}

variable "tls_priv_key" {
  type = string
}