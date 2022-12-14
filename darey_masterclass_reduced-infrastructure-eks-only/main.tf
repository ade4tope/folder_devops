module "networking" {
  source   = "./modules/networking"
  vpc_cidr = var.vpc_cidr
  tags     = local.tags
}


module "security_group" {
  source = "./modules/security_groups"
  vpc_id = module.networking.vpc_id
  tags   = local.tags
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}


module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "17.24.0"
  cluster_version = "1.21"
  cluster_name    = "tope-cluster"
  vpc_id          = module.networking.vpc_id
  subnets         = [aws_subnet.PrivateSubnet-1.id, aws_subnet.PrivateSubnet-2.id]

  worker_groups = [
    {
      instance_type = "m4.large"
      asg_desired_capacity = 2
      asg_max_size  = 2
    }
  ]
}