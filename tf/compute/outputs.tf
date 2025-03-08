output "jumpbox" {
  value = aws_instance.jumpbox
}

output "server" {
  value = aws_instance.server
}

output "node_0" {
  value = aws_instance.node-0
}

output "node_1" {
  value = aws_instance.node-1
} 

output "ssh_key_name" {
  value = aws_key_pair.generated_key.key_name
}

output "ssh_key_private_key" {
  value = tls_private_key.ssh_key.private_key_pem
  sensitive = true
}

