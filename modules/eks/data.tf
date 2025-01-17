data "aws_eks_addon_version" "add-on-version" {
  addon_name         = each.key
  kubernetes_version = aws_eks_cluster.main.version
}
output "add-on-version" {
    value= data.aws_eks_addon_version.add-on-version
}