output "ec2" {
  value = {
    public_ip = [ for v in aws_instance.app_server : v.public_ip]
  }
}