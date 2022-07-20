resource "null_resource" "remote"{
connection {
       type = "ssh"
       user = "ubuntu"
       private_key = file("../ansible/mykey.pem")
       host  = aws_instance.web_server.public_ip
}
provisioner "remote-exec" {
         inline = [
                       "sudo apt update -y",
                       "sudo apt install nginx -y",
                       "sudo ufw allow 'Nginx HTTP'",
		       "sudo systemctl start nginx"
                  ]
  }
}
