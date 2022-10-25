# security group for alb, to allow acess from any where for HTTP and HTTPS traffic
resource "aws_security_group" "int-alb-sg" {
  name        = "p15-int-alb-sg"
  vpc_id      = module.networking.vpc_id
  description = "Internal SG ALB"
  tags = merge(local.tags,
  { Name = "p15-int-alb-sg" })
}