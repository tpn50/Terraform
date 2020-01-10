variable "region" {
  default = "ap-south-1"
}

variable "amis" {
  type = "map"
  default =  {
    "ap-south-1" = "ami-0123b531fc646552f"
    "us-east-1" = "ami-04b9e92b5572fa0d1"
  }
}

provider "aws" {
  profile = "default"
  region = var.region
}

resource "aws_instance" "web" {
  ami = var.amis[var.region]
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
      "sudo docker run -p 8080:8080 tpn50/web_app:v1"
    ]
  }
}
