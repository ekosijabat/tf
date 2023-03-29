#output "rds_template" {
#  value = data.template_file.user_data.rendered
#}

output "rds_endpoint" {
  value = aws_db_instance.wordpressdb.endpoint
}