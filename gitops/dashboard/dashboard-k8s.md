


k apply -f https://raw.githubusercontent.com/killercoda/scenario-examples/refs/heads/main/kubernetes-dashboard/assets/dashboard.yaml

kubectl -n kubernetes-dashboard patch deploy/dashboard-metrics-scraper --type='json' -p='[{"op": "add", "path": "/spec/template/spec/tolerations", "value": [{"key": "workload-type","operator": "Equal","value": "regular","effect": "NoSchedule"}]}]'

kubectl -n kubernetes-dashboard patch deploy/kubernetes-dashboard --type='json' -p='[{"op": "add", "path": "/spec/template/spec/tolerations", "value": [{"key": "workload-type","operator": "Equal","value": "regular","effect": "NoSchedule"}]}]'
 
k apply -f ./gitops/dashboard/svc.yaml

kubectl -n kubernetes-dashboard create sa admin-user

kubectl create clusterrolebinding admin-user --clusterrole cluster-admin --serviceaccount kubernetes-dashboard:admin-user

kubectl -n kubernetes-dashboard create token admin-user
    token 
        eyJhbGciOiJSUzI1NiIsImtpZCI6ImQ0YjY3YjJlMDYwYWMxZWFhZTRiMGY3M2RjZjU2NmIzNjFhNWJlMDgifQ.eyJhdWQiOlsiaHR0cHM6Ly9rdWJlcm5ldGVzLmRlZmF1bHQuc3ZjIl0sImV4cCI6MTc1MDExMjgyMSwiaWF0IjoxNzUwMTA5MjIxLCJpc3MiOiJodHRwczovL29pZGMuZWtzLnVzLWVhc3QtMS5hbWF6b25hd3MuY29tL2lkL0U0RkNBNkMxMURBRDY4QkJFMjIwMkU0QTAyMzU0REVGIiwianRpIjoiNTY1OGQxNGUtMTdjMi00NGM1LWJkMmUtMDBkNjIwZDlhZjY0Iiwia3ViZXJuZXRlcy5pbyI6eyJuYW1lc3BhY2UiOiJrdWJlcm5ldGVzLWRhc2hib2FyZCIsInNlcnZpY2VhY2NvdW50Ijp7Im5hbWUiOiJhZG1pbi11c2VyIiwidWlkIjoiOWVjMDExMDctY2VjYy00MThlLWI2MWYtMWFjNjg0MWU2NjYxIn19LCJuYmYiOjE3NTAxMDkyMjEsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDprdWJlcm5ldGVzLWRhc2hib2FyZDphZG1pbi11c2VyIn0.gyoAGGxZrLMVNP4-PDS-WDWVipH2UQLRrI56ikrsz-bZPt0BS8vJ31BNTKr1PjvKi-zZPNgfazEUjYjF2ZAsjGvTBCqN0iZbL8UhoGSJdXWGP3yDIiQyaniRmSq_ZRQfrp2diuuuV8eVpnMUFx392pNlCD-87cpE3JdJ5A5CJPS3JViaAxFWUHflv-xyOAIUvtlwFmiCYCtFh1cMsuaNvjU9L-3uKyhJe0fEj4GqI9ac59XffnGu6-hsaY14CWNqzWQlDElHZYkCpaJiswxQaZJafyWyJ93WKrby44ObNgdyXd0cE_uYoJ6WH776dgH8a6Dl5ahRIbnDIFyzuKFB4w



