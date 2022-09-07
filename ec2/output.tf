output "ec2" {
  value = {
    public_ip = aws_instance.app_server.public_ip
  }
}