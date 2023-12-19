module "eks-cluster" {
  source           = "terraform-aws-modules/eks/aws"
  version          = "17.1.0"
  cluster_name     = var.cluster_name
  cluster_version  = "1.28"
  write_kubeconfig = true

  subnets = [module.vpc.private_subnets[0], module.vpc.private_subnets[1]] # use subnets in us-east-1a and us-east-1b
  vpc_id  = module.vpc.vpc_id

  worker_groups_launch_template = local.worker_groups_launch_template

  # map developer & admin ARNs as kubernetes Users
  map_users = concat(local.admin_user_map_users, local.developer_user_map_users)
}
