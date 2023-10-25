
/*

# AWS Site to Site Private VPN

resource "aws_dx_gateway" "three-tier-dx" {
  name            = "three-tier-dx"
  amazon_side_asn = "64512"
}


#A transit hub that can be used to interconnect multiple VPCs and on-premises networks
#and as a VPN endpoint for the Amazon side
resource "aws_ec2_transit_gateway" "three-tier-transit" {
  amazon_side_asn = "64513"
  description     = "three-tier-transit"  
}


#Provides a customer gateway inside a VPC. These objects can be connected to VPN gateways via VPN connections,
# and allow you to establish tunnels between your network and the VPC.
resource "aws_customer_gateway" "three-tier-customer" {
  bgp_asn    = 64514
  ip_address = "${var.trusted_ip_address2}"  
  type       = "ipsec.1"

  tags = {
    Name = "three-tier-customer"
  }
}

resource "aws_dx_gateway_association" "three-tier-dx-assoc" {
  dx_gateway_id         = aws_dx_gateway.three-tier-dx.id
  associated_gateway_id = aws_ec2_transit_gateway.three-tier-transit.id

  allowed_prefixes = [
    "10.0.0.0/16",
  ]
}

data "aws_ec2_transit_gateway_dx_gateway_attachment" "Transit-DX-gateway-attach" {
  transit_gateway_id = aws_ec2_transit_gateway.three-tier-transit.id
  dx_gateway_id      = aws_dx_gateway.three-tier-dx.id

  depends_on = [
    aws_dx_gateway_association.three-tier-dx-assoc
  ]
}

#Manages a Site-to-Site VPN connection. A Site-to-Site VPN connection is an Internet Protocol 
#security (IPsec) VPN connection between a VPC and an on-premises network.

resource "aws_vpn_connection" "three-tier-vpn" {
  customer_gateway_id                     = aws_customer_gateway.three-tier-customer.id
  transit_gateway_id                      = aws_ec2_transit_gateway.three-tier-transit.id  
  type                                    = "ipsec.1"

  tags = {
    Name = "three-tier-vpn"
  }
}

*/


/*
resource "aws_ec2_transit_gateway" "three-tier-transit-gw" {}

resource "aws_customer_gateway" "three-tier-customer-gw" {
  bgp_asn    = 65000
  ip_address = ""
  type       = "ipsec.1"
}

resource "aws_vpn_connection" "example" {
  customer_gateway_id = aws_customer_gateway.three-tier-customer-gw.id
  transit_gateway_id  = aws_ec2_transit_gateway.three-tier-transit-gw.id
  type                = aws_customer_gateway.three-tier-customer-gw.type
}

*/