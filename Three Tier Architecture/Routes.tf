


resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }

  
  tags = {
    Name = "private"
  }
}


resource "aws_route_table_association" "three-private_assoc-1a" {
  subnet_id      = aws_subnet.private-us-east-1a.id
  route_table_id = aws_route_table.private.id
}


resource "aws_route_table_association" "three-private_assoc-1b" {
  subnet_id      = aws_subnet.private-us-east-1b.id
  route_table_id = aws_route_table.private.id
}



resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id


  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }


#route to shared services VPC and transit gateway target. Fix the target section of code
 route {
    cidr_block = "172.31.0.0/16"
    transit_gateway_id = aws_ec2_transit_gateway.three-tier-transit.id
  }



  route {
    ipv6_cidr_block        = "::/0"
    egress_only_gateway_id = aws_egress_only_internet_gateway.EgressIGW.id
  }

  tags = {
    Name = "public"
  }
}

resource "aws_route_table_association" "three-public_assoc-1a" {
  subnet_id      = aws_subnet.public-us-east-1a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "three-public_assoc-1b" {
  subnet_id      = aws_subnet.public-us-east-1b.id
  route_table_id = aws_route_table.public.id
}


resource "aws_egress_only_internet_gateway" "EgressIGW" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "EgressIGW"
  }
}




#shared services

#private route table


resource "aws_route_table" "private-shared" {
  vpc_id = aws_vpc.shared-services.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-shared.id
  }



#route to main VPC and transit gateway target. Fix the target section of code
  route {
    cidr_block = "10.0.0.0/16"
    transit_gateway_id = aws_ec2_transit_gateway.three-tier-transit.id
  }

  
  tags = {
    Name = "private-shared"
  }
}


resource "aws_route_table_association" "shared-private_assoc-1a" {
  subnet_id      = aws_subnet.shared-private-us-east-1a.id
  route_table_id = aws_route_table.private-shared.id
}


resource "aws_route_table_association" "shared-private_assoc-1b" {
  subnet_id      = aws_subnet.shared-private-us-east-1b.id
  route_table_id = aws_route_table.private-shared.id
}



#public shared route table

resource "aws_route_table" "public-shared" {
  vpc_id = aws_vpc.shared-services.id
  


  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.shared-igw.id
  }

 
  route {
    ipv6_cidr_block        = "::/0"
    egress_only_gateway_id = aws_egress_only_internet_gateway.Shared-EgressIGW.id
  }

  tags = {
    Name = "public-shared"
  }
}

resource "aws_route_table_association" "shared-public_assoc-1a" {
  subnet_id      = aws_subnet.shared-public-us-east-1a.id
  route_table_id = aws_route_table.public-shared.id
}

resource "aws_route_table_association" "shared-public_assoc-1b" {
  subnet_id      = aws_subnet.shared-public-us-east-1b.id
  route_table_id = aws_route_table.public-shared.id
}


resource "aws_egress_only_internet_gateway" "Shared-EgressIGW" {
  vpc_id = aws_vpc.shared-services.id

  tags = {
    Name = "Shared-EgressIGW"
  }
}

