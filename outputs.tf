output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_ids" {
  value = values(aws_subnet.public_subnets)[*].id
}

output "private_subnet_ids" {
  value = values(aws_subnet.private_subnets)[*].id
}

output "instance_ids" {
  value = aws_instance.ec2.*.id
}

output "public_ip" {
  value = aws_eip.eip_ec2.*.public_ip
}

output "rds_endpoint" {
  value = aws_db_instance.rds_db_instance.endpoint
}