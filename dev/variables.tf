variable "access_key" {}

variable "secret_key" {}

variable "database_name" {
  default = "wordpress_db"
}

variable "database_user" {
  default = "wordpress_user"
}

variable "database_password" {
  default = "PassWord4-user"
}

variable "region" {
  default = "us-east-1"
}

variable "IsUbuntu" {
  default = true
}

variable "AZ1" {
  default = "us-east-1a"
}

variable "AZ2" {
  default = "us-east-1b"
}

variable "AZ3" {
  default = "us-east-1c"
}

variable "VPC_cidr" {
  default = "10.0.0.0/16"
}

variable "subnet1_cidr" {
  default = "10.0.1.0/24"
}

variable "subnet2_cidr" {
  default = "10.0.2.0/24"
}

variable "subnet3_cidr" {
  default = "10.0.3.0/24"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "instance_class" {
  default = "db.t2.micro"
}

variable "root_volume_size" {
  default = 22
}