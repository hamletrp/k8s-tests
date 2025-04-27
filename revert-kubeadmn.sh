sudo kubeadm reset --force

sudo iptables -F && sudo iptables -t nat -F && sudo iptables -t mangle -F && sudo iptables -X

sudo rm -rf /etc/cni/net.d && sudo rm -rf /var/lib/etcd && sudo rm -rf /var/lib/kubelet && sudo rm -rf /etc/kubernetes && sudo rm -rf ~/.kube

sudo rm -rf /etc/cni/net.d/*

# sudo reboot
