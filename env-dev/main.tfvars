env="dev"
domain_name= "adevsecops08.online"
zone_id="Z0285213QK7SB76TI5I9"

db_instances = {
  mongodb = {
    app_port      = 27017
    instance_type = "t3.small"
    volume_size   = 20
  }

  redis = {
    app_port      = 6379
    instance_type = "t3.small"
    volume_size   = 20
  }

  rabbitmq = {
    app_port      = 5672
    instance_type = "t3.small"
    volume_size   = 20
  }

  mysql = {
    app_port      = 3306
    instance_type = "t3.small"
    volume_size   = 20
  }
}

app_instances = {

  catalogue = {
    app_port      = 8080
    instance_type = "t3.small"
    volume_size   = 30
  }

  cart = {
    app_port      = 8080
    instance_type = "t3.small"
    volume_size   = 30
  }

  user = {
    app_port      = 8080
    instance_type = "t3.small"
    volume_size   = 30
  }

  shipping = {
    app_port      = 8080
    instance_type = "t3.small"
    volume_size   = 30
  }

  payment = {
    app_port      = 8080
    instance_type = "t3.small"
    volume_size   = 30
  }

}

web_instances = {
  frontend = {
    app_port      = 80
    instance_type = "t3.small"
    volume_size   = 20
  }
}

eks = {
  subnet_ids = ["subnet-02840545e6728ab20","subnet-08eb99a45f136fba3"]
  addons = {
  vpc-cni= {}
  kube-proxy= {}
  eks-pod-identity-agent = {}
  }
    access_entries = {
    workstation = {
      principal_arn           = "arn:aws:iam::529088273616:role/workstation-role"
      kubernetes_groups       = []
      policy_arn              = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
      access_scope_type       = "cluster"
      access_scope_namespaces = []
    }
    # UI Access
    ui-access = {
      principal_arn           = "arn:aws:iam::529088273616:role/aws-reserved/sso.amazonaws.com/AWSReservedSSO_DevOpsEngineers_70a51c5bd23375d3"
      kubernetes_groups       = []
      policy_arn              = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
      access_scope_type       = "cluster"
      access_scope_namespaces = []
    }
  }

    node_groups = {
    g2 = {
      desired_size   = 2
      max_size       = 10
      min_size       = 2
      capacity_type  = "SPOT"
      instance_types = ["t3.large", "t3.2xlarge"]
    }
  }
}


