output "jumpbox_public_ip" {
  value = module.compute.jumpbox.public_ip
}

output "jumpbox_private_ip" {
  value = module.compute.jumpbox.private_ip
}

output "server_private_ip" {
  value = module.compute.server.private_ip
}

output "node_0_private_ip" {
  value = module.compute.node_0.private_ip
}

output "node_1_private_ip" {
  value = module.compute.node_1.private_ip
}

output "ssh_private_key_pem" {
  value = module.compute.ssh_key_private_key
  sensitive = true
}
