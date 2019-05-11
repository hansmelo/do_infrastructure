resource "digitalocean_droplet" "monsterend" {
  image = "ubuntu-18-04-x64"
  name = "monsterend"
  region = "nyc1"
  size = "1gb"
  private_networking = true
  ssh_keys = [
    "${var.ssh_fingerprint}"
  ]
  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "sudo apt update",
      "sudo apt install -y docker docker-compose",
      "git clone https://github.com/hansmelo/monsterend-deploy-docker-compose.git",
      "cd monsterend-deploy-docker-compose",
      "chmod a+x init-letsencrypt.sh",
      "sudo apt remove -y nginx"
    ]

    connection {
      type     = "ssh"
      private_key = "${file(var.pvt_key)}"
      user     = "root"
      timeout  = "2m"
    }
  }
}

resource "digitalocean_domain" "wwwmonsterendcom" {
  name       = "www.monsterend.com"
  ip_address = "${digitalocean_droplet.monsterend.ipv4_address}"
}

resource "digitalocean_domain" "monsterend" {
  name       = "monsterend.com"
  ip_address = "${digitalocean_droplet.monsterend.ipv4_address}"
}