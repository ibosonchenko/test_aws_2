#-----------------------------------------------------------------------
# Public subnets
#-----------------------------------------------------------------------

resource "aws_subnet" "public" {
    count = length(var.public_subnet_cidrs)

    vpc_id            = aws_vpc.vpc.id
    cidr_block        = element(var.public_subnet_cidrs, count.index)
    availability_zone = element(var.availability_zones, count.index)
    map_public_ip_on_launch = true

    tags = {
        Name = "public-subnet-${count.index + 1}-${var.environment}"
        Environment = var.environment
    }
}

resource "aws_route_table" "public" {
  
   # count = length(var.public_subnet_cidrs)
    vpc_id = aws_vpc.vpc.id
    
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.vpc_igw.id
    }
    
    tags = {
        Name = "rt-public-${var.environment}"
        Environment = var.environment
    }
}

resource "aws_route_table_association" "public" {
    count = length(var.public_subnet_cidrs)

    subnet_id      = element(aws_subnet.public.*.id, count.index)
    route_table_id = aws_route_table.public.id
        
}

#-----------------------------------------------------------------------
# Private subnets
#-----------------------------------------------------------------------

resource "aws_subnet" "private" {
    count = length(var.private_subnet_cidrs)
    
    vpc_id            = aws_vpc.vpc.id
    cidr_block        = element(var.private_subnet_cidrs, count.index)
    availability_zone = element(var.availability_zones, count.index)

    tags = {
        Name = "private-subnet-${count.index + 1}-${var.environment}"
    }
}

resource "aws_route_table" "private" {
   # count = length(var.private_subnet_cidrs)
    vpc_id           = aws_vpc.vpc.id

    route {
        cidr_block     = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.vpc_nat.id
    }    


    tags = {
        Name = "rt-private-${var.environment}"
    }
}

resource "aws_route_table_association" "private" {
    count = length(var.private_subnet_cidrs)

    subnet_id      = element(aws_subnet.private.*.id, count.index)
    route_table_id = aws_route_table.private.id
 
}

#-----------------------------------------------------------------------
# Database subnets
#-----------------------------------------------------------------------

resource "aws_subnet" "database" {
    count = length(var.database_subnet_cidrs)
    
    vpc_id            = aws_vpc.vpc.id
    cidr_block        = element(var.database_subnet_cidrs, count.index)
    availability_zone = element(var.availability_zones, count.index)

    tags = {
        Name = "database-subnet-${count.index + 1}-${var.environment}"
        Environment = var.environment
    }
}

resource "aws_route_table" "database" {
    
    vpc_id           = aws_vpc.vpc.id

    tags = {
        Name = "rt-database-${var.environment}"
        Environment = var.environment
    }
}

resource "aws_route_table_association" "database" {
    count = length(var.database_subnet_cidrs)

    subnet_id      = element(aws_subnet.database.*.id, count.index)
    route_table_id = aws_route_table.database.id
   
}
