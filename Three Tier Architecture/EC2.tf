/*

Create AD management instances in both private subnets.

Create 2 web servers with Windows 2019 AMI
place in public subnet

Web servers should have C drive
C drive = 80

create 2 application servers with Windows 2019 AMI
place in private subnet.   

app servers should have a C and D drive
C drive = 80, D drive = 100

*/




#encrypt all EBS volumes
resource "aws_ebs_encryption_by_default" "example" { 
  enabled = true
}




#web servers
#------------------------------------------

resource "aws_instance" "web_server1" {
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.Windows-2019.id
  iam_instance_profile   = aws_iam_instance_profile.EC2-Active-Directory.name
  key_name               = aws_key_pair.threetierkey.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  subnet_id              = aws_subnet.public-us-east-1a.id   
  #user_data              = file("")
  
  root_block_device {
    volume_size = 80
  }


  tags = {
    Name = "web_server1"    
  }

  
}


resource "aws_instance" "web_server2" {
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.Windows-2019.id
  iam_instance_profile   = aws_iam_instance_profile.EC2-Active-Directory.name
  key_name               = aws_key_pair.threetierkey.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  subnet_id              = aws_subnet.public-us-east-1b.id  
  #user_data              = file("")
  
  root_block_device {
    volume_size = 80
  }

  tags = {
    Name = "web_server2"    
  }
}




#app servers. 
#--------------------------------------------
resource "aws_instance" "app_server1" {
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.Windows-2019.id
  iam_instance_profile   = aws_iam_instance_profile.EC2-Active-Directory.name
  key_name               = aws_key_pair.threetierkey.id
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  subnet_id              = aws_subnet.private-us-east-1a.id
  #user_data              = file("")
  
  

  root_block_device {
    volume_size = 80
  }

  tags = {
    Name = "app_server1"    
  }

  
}

#D drive (app) attachment for app_server1

resource "aws_volume_attachment" "app_server1_att_D" {
  device_name = "xvdd"
  volume_id   = aws_ebs_volume.app_server1_vol_D.id
  instance_id = aws_instance.app_server1.id

}


resource "aws_ebs_volume" "app_server1_vol_D" {
  availability_zone = "us-east-1a"
  size              = 100

tags = {
    Name = "D-drive"
  }



}


#---------------------------------

resource "aws_instance" "app_server2" {
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.Windows-2019.id
  iam_instance_profile   = aws_iam_instance_profile.EC2-Active-Directory.name
  key_name               = aws_key_pair.threetierkey.id
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  subnet_id              = aws_subnet.private-us-east-1b.id
  #user_data              = file("")
  
  

  root_block_device {
    volume_size = 80  
  }

  tags = {
    Name = "app_server2"    
  }


}

#D drive (app) attachment for app_server2

resource "aws_volume_attachment" "app_server2_att_D" { 
  device_name = "xvdd"
  volume_id   = aws_ebs_volume.app_server2_vol_D.id
  instance_id = aws_instance.app_server2.id

}


resource "aws_ebs_volume" "app_server2_vol_D" {
  availability_zone = "us-east-1b"
  size              = 100

tags = {
    Name = "D-drive"
  }

}

#---------------------------------


resource "aws_instance" "AD_management1a" {
  instance_type          = "t2.small"
  ami                    = data.aws_ami.Windows-2019.id
  iam_instance_profile   = aws_iam_instance_profile.EC2-Active-Directory.name
  key_name               = aws_key_pair.threetierkey.id
  vpc_security_group_ids = [aws_security_group.AD_SG.id]
  subnet_id              = aws_subnet.private-us-east-1a.id   
  #user_data              = file("")
  
  root_block_device {
    volume_size = 80
  }


  tags = {
    Name = "AD_management_1a"    
  }

  
}


resource "aws_instance" "AD_management1b" {
  instance_type          = "t2.small"
  ami                    = data.aws_ami.Windows-2019.id
  iam_instance_profile   = aws_iam_instance_profile.EC2-Active-Directory.name
  key_name               = aws_key_pair.threetierkey.id
  vpc_security_group_ids = [aws_security_group.AD_SG.id]
  subnet_id              = aws_subnet.private-us-east-1b.id   
  #user_data              = file("")
  
  root_block_device {
    volume_size = 80
  }


  tags = {
    Name = "AD_management_1b"    
  }

  
}