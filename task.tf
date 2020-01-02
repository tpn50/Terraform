provider "aws" {
  profile = "default"
  region = "ap-south-1"
}

resource "aws_instance" "web" {
  ami = "ami-0123b531fc646552f"
  instance_type = "t2.micro"
  key_name = "key1"


  connection {
    user = "ubuntu"
    private_key = file("key1.pem")
    host = self.public_ip
  }

  
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt install docker.io -y",
      "sudo docker pull tpn50/web_app:v1"
    ]
  }
}

