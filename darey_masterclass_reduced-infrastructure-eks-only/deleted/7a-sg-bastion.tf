# security group for alb, to allow acess from any where for HTTP and HTTPS traffic
resource "aws_security_group" "bastion-sg" {
  name        = "p15-bastion-sg"
  vpc_id      = module.networking.vpc_id
  description = "Bastion SG"
  tags = merge(local.tags,
  { Name = "p15-bastion-sg" })
}