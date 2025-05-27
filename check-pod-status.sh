echo "👉 Checking VPC CNI Add-on..." && \
eksctl get addon --name vpc-cni --cluster <your-cluster-name> --region <your-region> && \
echo -e "\n👉 aws-node DaemonSet status:" && \
kubectl get daemonset aws-node -n kube-system -o wide && \
echo -e "\n👉 VPC CNI Image Version(s):" && \
kubectl get daemonset aws-node -n kube-system -o jsonpath='{.spec.template.spec.containers[*].image}' && echo && \
echo -e "\n👉 VPC CNI Pod Health:" && \
kubectl get pods -n kube-system -l k8s-app=aws-node -o wide
