echo "👉 Checking VPC CNI Add-on..." && \
eksctl get addon --name vpc-cni --cluster cluster-lab-11 --region us-east-1 && \
echo -e "\n👉 aws-node DaemonSet status:" && \
kubectl get daemonset aws-node -n kube-system -o wide && \
echo -e "\n👉 VPC CNI Image Version(s):" && \
kubectl get daemonset aws-node -n kube-system -o jsonpath='{.spec.template.spec.containers[*].image}' && echo && \
echo -e "\n👉 VPC CNI Pod Health:" && \
kubectl get pods -n kube-system -l k8s-app=aws-node -o wide

# eksctl get addon --name vpc-cni --cluster cluster-lab-11

# k logs -n kube-system -l app.kubernetes.io/instance: aws-vpc-cni
