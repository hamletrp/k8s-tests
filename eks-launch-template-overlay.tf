resource "aws_launch_template" "eks_overlay_optimized" {
  name_prefix   = "eks-nodes-overlay-"
  image_id      = "ami-xxxxxxxxxxxxxxxxx" # Replace with latest EKS-optimized AMI
  # ami-0ab8b9aed40e77e9e
  instance_type = "m5.large"

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 100
      volume_type = "gp3"
      iops        = 3000
      throughput  = 125
      encrypted   = true
    }
  }

  block_device_mappings {
    device_name = "/dev/xvdb"
    ebs {
      volume_size = 200
      volume_type = "gp3"
      encrypted   = true
    }
  }

  user_data = base64encode(<<-EOT
    #!/bin/bash
    mkfs -t xfs /dev/xvdb
    mkdir -p /var/lib/containerd
    mount /dev/xvdb /var/lib/containerd
    echo "/dev/xvdb /var/lib/containerd xfs defaults,nofail 0 2" >> /etc/fstab
    /etc/eks/bootstrap.sh my-eks-cluster
  EOT
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "eks-overlay-optimized-node"
      "kubernetes.io/cluster/my-eks-cluster" = "owned"
    }
  }
}
