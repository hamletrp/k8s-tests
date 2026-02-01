#!/bin/bash

mkfs -t xfs /dev/nvme1n1
mkdir -p /var/lib/docker
mount /dev/nvme1n1 /var/lib/docker

echo "/dev/nvme1n1 /var/lib/docker xfs defaults,nofail 0 2" >> /etc/fstab

/etc/eks/bootstrap.sh my-eks-cluster
