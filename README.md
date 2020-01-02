# Terraform




Creating a Docker Image and Pushing to DockerHub:

Step-1: Creating a docker file (dockerfile)

FROM nginx:alpine
MAINTAINER tpn
COPY html/. /usr/share/nginx/html
RUN ["echo","Docker Image Built"]

Step-2: Build the docker file
                     
		sudo docker build -t web-app:1.0 .

Step-3: Check docker image and check weather it is running properly using command
		
		sudo docker images (to check image)
		sudo docker run -p 80:80 web-app (to check is it running)

Step-4: Login to docker hub using terminal

		sudo docker login

Step-5: Push the image to docker hub

		Sudo docker push tpn50/web-app:latest (dockerid/imagename:tag)


Creating Instance using Terraform:

2 Ways:
    1) Downloading Key in AWS console for connecting pod.
    2) Generating key in CLI and uploading key in AWS console.

1) By Downloading key in AWS console:

Step-1: Create a new folder for the project.

Step-2: Download access key pair from the AWS console for authentication and connecting to AWS console using terraform. (Each access key pair is provided to each user. While giving access key pair, we have to give necessary permissions to the user. )
The user with a key-pair can only has permissions which are provided to access key pair while creating the access-key pair.

Step-3: Note down the access_key and secret_key from xls file downloaded

Step-4: Create a .tf file to build an instance
		
		 


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


Step-5: Download a key  from AWS console in ec2>resources>key-pairs and create a new key pair.(This key pair is required to connect to the Instance created)

Step-6: Make sure that the key is situated in the same folder as .tf file (project file)

terraform init
		terraform plan
		terraform apply

This will create the instance in the AWS .


Step-7: To enable ssh for connection, We have to go to security groups of instance and edit inbound and add ssh to enable connection through outer world. {This was my blocker----I did not enable ssh connection}

Step-8: Now connect to the instance in Aws console by selecting instance and follow the steps given.












