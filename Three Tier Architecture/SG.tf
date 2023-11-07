

#create a security group for AD Management instance
resource "aws_security_group" "AD_SG" {
  name        = "AD_SG"
  description = "Enable AD access from trusted IP"
  vpc_id      = aws_vpc.shared-services.id

ingress {
		from_port = 3389
		to_port = 3389
		protocol = "tcp"
		cidr_blocks = [
			"172.31.0.0/16"
		]
	}


ingress {
		from_port = 3389
		to_port = 3389
		protocol = "tcp"
		cidr_blocks = [
			"10.0.0.0/16"
		]
	}



/*
ingress {
		from_port = 3389
		to_port = 3389
		protocol = "tcp"
		cidr_blocks = [
			"${var.trusted_ip_address}"
		]
	}
*/


	egress {
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
}



resource "aws_security_group" "DB_sg" {
  name        = "DB_sg"
  description = "enable SQL server access on port 1433"
  vpc_id      = aws_vpc.main.id

 ingress {
    description = "SQL server access"
    from_port   = 1433
    to_port     = 1433
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]  
  }

  ingress {
    description = "SQL server access"
    from_port   = 1433
    to_port     = 1433
    protocol    = "tcp"
    security_groups = [aws_security_group.web_sg.id] 
  }

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "app_sg" {
  name        = "app_sg"
  description = "app security group"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 0 
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "enable http access on port 80"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "http access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]    
  }

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}