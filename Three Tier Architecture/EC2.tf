#Create 2 web servers with Windows 2019 AMI
#place in public subnet
#Web servers should have C drive
#C drive = 80

#create 2 application servers with Windows 2019 AMI
#place in private subnet.   
#app servers should have a C and D drive
#C drive = 80, D drive = 100


#reference the keyname "threetier_auth"
resource "aws_instance" "web_server1" {
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.windows.id
  key_name               = aws_key_pair.threetier_auth.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  subnet_id              = aws_subnet.public-us-east-1a.id

  root_block_device {
    volume_size = 80
  }

  tags = {
    Name = "web_server1"
  }
}


resource "aws_instance" "web_server2" {
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.windows.id
  key_name               = aws_key_pair.threetier_auth.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  subnet_id              = aws_subnet.public-us-east-1b.id

  root_block_device {
    volume_size = 80
  }

  tags = {
    Name = "web_server2"
  }
}


resource "aws_instance" "app_server1" {
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.windows.id
  key_name               = aws_key_pair.threetier_auth.id
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  subnet_id              = aws_subnet.private-us-east-1a.id

  root_block_device {
    volume_size = 80
  }

  tags = {
    Name = "app_server1"
  }



}



resource "aws_instance" "app_server2" {
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.windows.id
  key_name               = aws_key_pair.threetier_auth.id
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  subnet_id              = aws_subnet.private-us-east-1b.id

  root_block_device {
    volume_size = 80
  }

  tags = {
    Name = "app_server2"
  }




}
