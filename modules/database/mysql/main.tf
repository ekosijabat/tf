# Create Private subnet for RDS
resource "aws_subnet" "prod-subnet-private-1" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.subnet2_cidr
  map_public_ip_on_launch = "false"
  availability_zone       = var.AZ2
}

# Create second private subnet for RDS
resource "aws_subnet" "prod-subnet-private-2" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.subnet3_cidr
  map_public_ip_on_launch = "false"
  availability_zone       = var.AZ3
}

# Create RDS subnet group
resource "aws_db_subnet_group" "RDS_subnet_grp" {
  subnet_ids = ["${aws_subnet.prod-subnet-private-1.id}", "${aws_subnet.prod-subnet-private-2.id}"]
}

# Create RDS instance
resource "aws_db_instance" "wordpressdb" {
  allocated_storage      = 10
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = var.instance_class
  db_subnet_group_name   = aws_db_subnet_group.RDS_subnet_grp.id
  vpc_security_group_ids = ["${var.rds_asg_id}"]
  db_name                = var.database_name
  username               = var.database_user
  password               = var.database_password
  skip_final_snapshot    = true

  # make sure rds manual password changes is ignored
  lifecycle {
    ignore_changes = [password]
  }
}

# change USERDATA variable value after grabbing RDS endpoint info
/*data "template_file" "user_data" {
  template = var.IsUbuntu ? file("userdata_ubuntu.tpl") : file("user_data.tpl")
  vars = {
    db_username      = var.database_user
    db_user_password = var.database_password
    db_name          = var.database_name
    db_RDS           = aws_db_instance.wordpressdb.endpoint
  }
}*/

output "RDS-Endpoint" {
  value = aws_db_instance.wordpressdb.endpoint
}