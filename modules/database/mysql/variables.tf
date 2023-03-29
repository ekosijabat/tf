variable "database_name" {
  type = string
}

variable "database_password" {
  type = string
}

variable "database_user" {
  type = string
}

variable "instance_class" {
  type = string
}

variable "IsUbuntu" {
  type    = bool
  default = true
}

variable "AZ2" {
  type = string
}

variable "AZ3" {
  type = string
}

variable "subnet2_cidr" {
  type = string
}

variable "subnet3_cidr" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "rds_asg_id" {
  type = string
}