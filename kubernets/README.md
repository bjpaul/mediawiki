*** Kube Config***
```
aws eks --region us-east-1 update-kubeconfig --name media-wiki-eks --profile bijoy-own

~ $ kubectl get nodes
NAME                             STATUS   ROLES    AGE     VERSION
ip-192-168-100-83.ec2.internal   Ready    <none>   8m35s   v1.14.7-eks-1861c5
ip-192-168-205-23.ec2.internal   Ready    <none>   8m30s   v1.14.7-eks-1861c5
```

