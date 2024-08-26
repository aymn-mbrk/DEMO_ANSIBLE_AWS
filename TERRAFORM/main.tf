provider "aws" {
  region  = "eu-north-1"
}


resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("~/.ssh/id_ed25519.pub")
}



resource "aws_instance" "vm" {
  count        = 3
  ami         = "ami-07c8c1b18ca66bb07"
  instance_type = "t3.micro"
  key_name      = aws_key_pair.deployer.key_name
  vpc_security_group_ids = ["sg-01587701668fc7246"]

tags = {
  Name = "${element(["db", "web1", "web2"], count.index)}"
 }

}



output "instance_ips" {
  value       = { for i in aws_instance.vm : i.tags["Name"] => i.public_ip }
  description = "The public IP addresses of the VM instances, mapped by name"
}
