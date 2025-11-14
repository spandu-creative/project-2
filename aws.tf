resource "aws_instance" "aws_web" {
  ami           = "ami-0e283c43fbff92501"
  instance_type = "t2.micro"

  user_data = <<-EOF
    #!/bin/bash
    sudo apt update
    sudo apt install -y nginx
    echo "<h1>Welcome to AWS Server</h1>" | sudo tee /var/www/html/index.html
  EOF

  tags = {
    Name = "aws-web"
  }
}

output "aws_public_ip" {
  value = aws_instance.aws_web.public_ip
}
