output "vpc_id" {
  value = aws_vpc.k8s-hard-way-vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.k8s-hard-way-public-subnet.id
}

output "private_subnet_id" {
  value = aws_subnet.k8s-hard-way-private-subnet.id
}

output "ssh_access_sg_id" {
  value = aws_security_group.k8s-hard-way-ssh-access.id
}

output "internet_egress_sg_id" {
  value = aws_security_group.k8s-hard-way-internet-egress.id
}
