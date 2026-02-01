resource "aws_launch_template" "eks_nodes_launch_template" {
  name_prefix   = "eks-nodes-"
  image_id      = "ami-0f123456789abcde0"  # EKS-optimized AMI or Bottlerocket
  instance_type = "m5.large"

  update_default_version = true

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = 100          # OS/kubelet volume size
      volume_type           = "gp3"
      iops                  = 3000         # Default for gp3
      throughput            = 125          # MiB/s
      encrypted             = true
      kms_key_id            = "arn:aws:kms:us-east-1:111122223333:key/your-key"
      delete_on_termination = true
    }
  }

  user_data = base64encode(<<-EOT
    #!/bin/bash
    /etc/eks/bootstrap.sh my-eks-cluster \
      --kubelet-extra-args '--node-labels=role=app,type=custom --max-pods=110'
  EOT
  )

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name                         = "eks-node"
      "kubernetes.io/cluster/my-eks-cluster" = "owned"
    }
  }
}
