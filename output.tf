output "Public ip" {
  value = "${digitalocean_droplet.monsterend.ipv4_address}"
}

output "Name" {
  value = "${digitalocean_droplet.monsterend.name}"
}