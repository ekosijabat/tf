output "ami_ubuntu" {
  value = data.aws_ami.ubuntu.id
}

output "ami_linux" {
  value = data.aws_ami.linux2.id
}