resource "aws_vpc" "vpc" {
    cidr_block           = var.vpc_cidr_block
    enable_dns_support   = true
    enable_dns_hostnames = true 

    tags = {
        Name = var.vpc_name
        Environment = var.environment
    }
}

resource "aws_internet_gateway" "vpc_igw" {
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = "internet-gateway-${var.vpc_name}"
        Environment = var.environment
    }
}

resource "aws_eip" "vpc_nat_eip" {
    #count = var.number_of_nat_gateways

    vpc = true
    depends_on = [aws_internet_gateway.vpc_igw]   
}

resource "aws_nat_gateway" "vpc_nat" {
    #count = var.number_of_nat_gateways
    #allocation_id = element(aws_eip.vpc_nat_eip.*.id, count.index)    
    #subnet_id     = element(aws_subnet.private.*.id, count.index)    
    #count = length(var.private_subnet_cidrs)
    allocation_id = aws_eip.vpc_nat_eip.id
    subnet_id     = element(aws_subnet.public.*.id, 0)
    tags = {
        Name = "nat-gateway-${var.vpc_name}"
        Environment = var.environment
    }    
}