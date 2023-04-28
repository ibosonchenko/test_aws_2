output "aws_security_group_ecs_fargate_alb_id" {
  value = aws_security_group.ecs_fargate_alb.id
}
output "aws_alb_target_group_ecs_fargate_service_server_arn" {
    value = aws_alb_target_group.ecs_fargate_service_server.arn
}

# output "aws_alb_target_group_ecs_fargate_service_worker_arn" {
#     value = aws_alb_target_group.ecs_fargate_service_worker.arn
# }

output "private_subnet_ids" {
    value = [for subnet in aws_subnet.private : subnet.id]
}
output "public_subnet_ids" {
    value = [for subnet in aws_subnet.public : subnet.id]
}
# ------ vpc ------

#output "vpc_id" {
#    value = aws_vpc.vpc.id
#}

#output "vpc_cidr_block" {
    #value = var.vpc_cidr_block
#    value = aws_vpc.vpc.cidr_block
#}

#output "vpc_name" {
#    value = "${var.vpc_name}"
#}

# ------ internet_gateway ------

#output "internet_gateway_id" {
#    value = aws_internet_gateway.vpc_igw.id
#}

# ------ subnets ------

#output "public_subnet_ids" {
#    value = [aws_subnet.public.*.id]
#}

#output "private_subnet_ids" {
#    value = [aws_subnet.private.*.id]
#}

# ------ route tables ------

#output "public_route_table_ids" {
#    value = [aws_route_table.public.*.id]
#}

#output "private_route_table_ids" {
#    value = [aws_route_table.private.*.id]
#}

# ------ nat ------

#output "nat_gateway_ids" {
#    value = [aws_nat_gateway.vpc_nat.*.id]
#}

#output "nat_gateway_public_ips" {
#    value = [aws_nat_gateway.vpc_nat.*.public_ip]
#}

# ------ security groups ------

#output "security_group_id" {
#    value = aws_security_group.vpc.id
#}