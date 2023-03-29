# Create Public Subnet for EC2
resource "aws_subnet" "prod-subnet-public-1" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.subnet1_cidr
  map_public_ip_on_launch = "true"
  availability_zone       = var.AZ1
}

# Create IGW for internet connection
resource "aws_internet_gateway" "prod-igw" {
  vpc_id = var.vpc_id
}

# Creating Route table
resource "aws_route_table" "prod-public-crt" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod-igw.id
  }
}

# Associating route table to public subnet
resource "aws_route_table_association" "prod-crta-public-subnet-1" {
  subnet_id      = aws_subnet.prod-subnet-public-1.id
  route_table_id = aws_route_table.prod-public-crt.id
}

# Create EC2 (only after RDS is provisioned)
resource "aws_instance" "wordpressec2" {
  ami                    = var.IsUbuntu ? var.ami_ubuntu : var.ami_linux
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.prod-subnet-public-1.id
  vpc_security_group_ids = ["${var.ec2_asg_id}"]
  user_data              = file("userdata_ubuntu.tpl")
  key_name               = var.akp_id

  tags = {
    Name = "Wordress.web"
  }

  root_block_device {
    volume_size = var.root_volume_size # in GB
  }

  # this will stop creating EC2 before RDS is provisioned
  //depends_on = [aws_db_instance.wordpressdb]
}

# creating Elastic IP for EC2
resource "aws_eip" "eip" {
  instance = aws_instance.wordpressec2.id
}

output "IP" {
  value = aws_eip.eip.public_ip
}

output "INFO" {
  value = "AWS Resources and Wordpress has been provisioned. Go to http://${aws_eip.eip.public_ip}"
}

resource "null_resource" "Wordpress_Installation_Waiting" {
  # trigger will create new null-resource if ec2 id or rds id is changed
  triggers = {
    ec2_id       = aws_instance.wordpressec2.id,
    rds_endpoint = var.rds_endpoint
  }

  connection {
    type        = "ssh"
    user        = var.IsUbuntu ? "ubuntu" : "ec2-user"
    private_key = var.tls_priv_key
    host        = aws_eip.eip.public_ip
  }

  provisioner "remote-exec" {
    inline = ["sudo tail -f -n0 /var/log/cloud-init-output.log | grep -q 'Wordress Installed'"]
  }
}