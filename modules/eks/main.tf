resource "aws_eks_cluster" "main" {

  name     = "${var.env}-eks"
  role_arn = aws_iam_role.eks-cluster-role.arn

  vpc_config {
    subnet_ids = var.subnet_ids
  }
    access_config {
    authentication_mode                         = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }
}
resource "aws_eks_access_entry" "main" {
  for_each          = var.access_entries
  cluster_name      = aws_eks_cluster.main.name
  principal_arn     = each.value["principal_arn"]
  kubernetes_groups = each.value["kubernetes_groups"]
  type              = "STANDARD"
}

resource "aws_eks_access_policy_association" "example" {
  for_each      = var.access_entries
  cluster_name  = aws_eks_cluster.main.name
  policy_arn    = each.value["policy_arn"]
  principal_arn = each.value["principal_arn"]

  access_scope {
    type       = each.value["access_scope_type"]
    namespaces = each.value["access_scope_namespaces"]
  }
}


#addons vpc-cni
resource "aws_eks_addon" "vpc-cni" {
  for_each      = var.addons
  cluster_name  = aws_eks_cluster.main.name
  addon_name    = each.key
  addon_version = data.aws_eks_addon_version.add-on-version[each.key].version
}
# adding node group to the cluster
resource "aws_eks_node_group" "main" {
  depends_on      = [aws_eks_addon.vpc-cni]
  for_each        = var.node_groups
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = each.key
  node_role_arn   = aws_iam_role.eks-node-group-role.arn
  subnet_ids      = var.subnet_ids
  capacity_type   = each.value["capacity_type"]
  instance_types  = each.value["instance_types"]

  scaling_config {
    desired_size = each.value["desired_size"]
    max_size     = each.value["max_size"]
    min_size     = each.value["min_size"]
  }
}
