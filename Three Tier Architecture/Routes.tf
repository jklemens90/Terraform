


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


/*

#shared services

#private route table


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



#public route table

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id


  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
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

*/