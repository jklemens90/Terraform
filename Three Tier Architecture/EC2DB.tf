#create 2 EC2 instances using SQL Server 2019 AMI. Place them in different AZ within a private subnet. Have the
#ability to failover to the secondary node.

#attach EBS volumes for C drive, F drive, G drive, L drive for both instances. Drive sizes should match on both DB 
#instances 

#C drive= 80, F drive= 200, L drive= 50, G drive= 40




resource "aws_instance" "DB_server1" {  
  instance_type          = "r5a.large"
  ami                    = data.aws_ami.WindowsSQLServer.id
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


resource "aws_instance" "DB_server2" {
  instance_type          = "r5a.large"
  ami                    = data.aws_ami.WindowsSQLServer.id
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
