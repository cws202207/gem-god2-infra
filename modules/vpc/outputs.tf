output "subnet_public" {
  value = aws_subnet.public
}

output "aws_subnet_private_a_id" {
  value = aws_subnet.private["a"].id
}
output "aws_subnet_private_c_id" {
  value = aws_subnet.private["c"].id
}
output "aws_subnet_private_d_id" {
  value = aws_subnet.private["d"].id
}


output "aws_subnet_public_a_id" {
  value = aws_subnet.public["a"].id
}


#output "azs" {
#  value = var.azs
#}

output "public_cidr_block" {
  value = var.azs
}

output "vpc_id" {
	value = aws_vpc.this.id
}

output "public_subnet_cidr" {
  value = aws_subnet.public["a"].cidr_block
}

output "private_subnet_cidr" {
  value = [for value in aws_subnet.private : value.cidr_block]
}

output "region" {
  value = data.aws_region.current.name
}


output "vpc_cidr" {
  value = var.vpc_cidr
}

output "route_table_public" {
	value = aws_route_table.public
}

output "route_table_private" {
	value = aws_route_table.private
}

output "availability_zone" {
	value = [for s in aws_subnet.public : s.availability_zone]
}
