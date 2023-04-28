#-----------------------
# Public Network ACLs
#-----------------------

resource "aws_network_acl" "public_acl" {
    tags = {
    Name       = "public_nacl-${var.environment}"
    Environment = var.environment
  }
  vpc_id = aws_vpc.vpc.id
  
}

resource "aws_network_acl_rule" "public_outgoing" {
   network_acl_id = aws_network_acl.public_acl.id
   rule_number    = 100
   egress         = true
   protocol       = "all"
   rule_action    = "allow"
   cidr_block     = "0.0.0.0/0"
 }
 
 resource "aws_network_acl_rule" "public_incoming" {
  network_acl_id = aws_network_acl.public_acl.id
  rule_number = 200
  egress      = false
  protocol    = "all"  
  rule_action = "allow"  
  cidr_block  = "0.0.0.0/0"
}

resource "aws_network_acl_association" "public" {
  count = length(var.public_subnet_cidrs)
  network_acl_id = aws_network_acl.public_acl.id
  subnet_id      = element(aws_subnet.public.*.id, count.index)
}

#-----------------------
# Private Network ACLs
#-----------------------

resource "aws_network_acl" "private_acl" {
    tags = {
    Name        = "private_nacl-${var.environment}"
    Environment = var.environment
  }
  vpc_id = aws_vpc.vpc.id
  
}

resource "aws_network_acl_rule" "private_outgoing" {
   network_acl_id = aws_network_acl.private_acl.id
   rule_number    = 100
   egress         = true
   protocol       = "all"
   rule_action    = "allow"
   cidr_block     = "0.0.0.0/0"
 }
 
 resource "aws_network_acl_rule" "private_incoming" {
  network_acl_id = aws_network_acl.private_acl.id
  rule_number = 200
  egress      = false
  protocol    = "all"  
  rule_action = "allow"  
  cidr_block  = "0.0.0.0/0"
}

resource "aws_network_acl_association" "private" {
  count          = length(var.private_subnet_cidrs)
  network_acl_id = aws_network_acl.private_acl.id
  subnet_id      = element(aws_subnet.private.*.id, count.index)
}

#-----------------------
# Database Network ACLs
#-----------------------

resource "aws_network_acl" "database_acl" {
    tags = {
    Name        = "database_nacl-${var.environment}"
    Environment = var.environment
  }
  vpc_id = aws_vpc.vpc.id
  
}

resource "aws_network_acl_rule" "database_outgoing" {
   network_acl_id = aws_network_acl.database_acl.id
   rule_number    = 100
   egress         = true
   protocol       = "all"
   rule_action    = "allow"
   cidr_block     = var.database_subnet_allowed_cidrs
 }
 
 resource "aws_network_acl_rule" "database_incoming" {
  network_acl_id = aws_network_acl.database_acl.id
  rule_number = 200
  egress      = false
  protocol    = "all"  
  rule_action = "allow"  
  cidr_block  = var.database_subnet_allowed_cidrs
}

resource "aws_network_acl_association" "database" {
  count          = length(var.database_subnet_cidrs)
  network_acl_id = aws_network_acl.database_acl.id
  subnet_id      = element(aws_subnet.database.*.id, count.index)
}