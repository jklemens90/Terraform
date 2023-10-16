/*
create 2 EC2 instances using SQL Server 2019 AMI. Place them in different AZ within a private subnet. Have the
ability to failover.

attach EBS volumes for C drive, F drive, G drive, L drive for both instances. Drive sizes should match on both DB 
instances 

C drive= 80, F drive= 200, L drive= 50, G drive= 40
*/


/*

resource "aws_instance" "DB_server1" {  
  instance_type          = "r5a.large"
  ami                    = data.aws_ami.WindowsSQLServer.id
  iam_instance_profile   = aws_iam_instance_profile.EC2-Active-Directory.name
  key_name               = aws_key_pair.threetier_auth.id
  vpc_security_group_ids = [aws_security_group.DB_sg.id]
  subnet_id              = aws_subnet.private-us-east-1a.id

  root_block_device {
    volume_size = 80
  }

  tags = {
    Name = "DB_server1"    
  }

}

#F drive (Data) attachment for DB_server1

resource "aws_volume_attachment" "db_server1_att_F" {
  device_name = "xvdf"
  volume_id   = aws_ebs_volume.DB_server1_vol_F.id
  instance_id = aws_instance.DB_server1.id

}


resource "aws_ebs_volume" "DB_server1_vol_F" {
  availability_zone = "us-east-1a"
  size              = 200

tags = {
    Name = "F-drive"
  }

}

#L drive (Log) attachment for DB_server1

resource "aws_volume_attachment" "db_server1_att_L" {
  device_name = "xvdl"
  volume_id   = aws_ebs_volume.DB_server1_vol_L.id
  instance_id = aws_instance.DB_server1.id

}


resource "aws_ebs_volume" "DB_server1_vol_L" {
  availability_zone = "us-east-1a"
  size              = 50

tags = {
    Name = "L-drive"
  }

}



#G drive (TempDB) attachment for DB_server1

resource "aws_volume_attachment" "db_server1_att_G" {
  device_name = "xvdg"
  volume_id   = aws_ebs_volume.DB_server1_vol_G.id
  instance_id = aws_instance.DB_server1.id

}


resource "aws_ebs_volume" "DB_server1_vol_G" {
  availability_zone = "us-east-1a"
  size              = 40

tags = {
    Name = "G-drive"
  }

}


#-----------------------------------------

resource "aws_instance" "DB_server2" {
  instance_type          = "r5a.large"
  ami                    = data.aws_ami.WindowsSQLServer.id
  iam_instance_profile   = aws_iam_instance_profile.EC2-Active-Directory.name
  key_name               = aws_key_pair.threetier_auth.id
  vpc_security_group_ids = [aws_security_group.DB_sg.id]
  subnet_id              = aws_subnet.private-us-east-1b.id

  root_block_device {
    volume_size = 80
  }

  tags = {
    Name = "DB_server2"    
  }

}

#F drive (Data) attachment for DB_server2

resource "aws_volume_attachment" "db_server2_att_F" {
  device_name = "xvdf"
  volume_id   = aws_ebs_volume.DB_server2_vol_F.id
  instance_id = aws_instance.DB_server2.id

}


resource "aws_ebs_volume" "DB_server2_vol_F" {
  availability_zone = "us-east-1b"
  size              = 200

tags = {
    Name = "F-drive"
  }

}


#L drive (Log) attachment for DB_server2

resource "aws_volume_attachment" "db_server2_att_L" {
  device_name = "xvdl"
  volume_id   = aws_ebs_volume.DB_server2_vol_L.id
  instance_id = aws_instance.DB_server2.id

}


resource "aws_ebs_volume" "DB_server2_vol_L" {
  availability_zone = "us-east-1b"
  size              = 50

tags = {
    Name = "L-drive"
  }

}



#G drive (TempDB) attachment for DB_server2

resource "aws_volume_attachment" "db_server2_att_G" {
  device_name = "xvdg"
  volume_id   = aws_ebs_volume.DB_server2_vol_G.id
  instance_id = aws_instance.DB_server2.id

}


resource "aws_ebs_volume" "DB_server2_vol_G" {
  availability_zone = "us-east-1b"
  size              = 40

tags = {
    Name = "G-drive"
  }

}



*/