***Setup Helm and Tiller***
```
#Install Helm 2

~$ curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > get_helm.sh
~$ chmod 700 get_helm.sh
~$ ./get_helm.sh

#Setup Tiller
~$ kubectl -n kube-system create serviceaccount tiller

~$ kubectl create clusterrolebinding tiller \
  --clusterrole=cluster-admin \
  --serviceaccount=kube-system:tiller

~$ helm init --service-account tiller  --wait

```

***Deploy Mediawiki***
```
#Check syntax
~$ helm lint ./mediawiki

#Deploy app
~$ helm install ./mediawiki --name mediawiki

#Test deployment
~$ helm test mediawiki

#Check application logss
~$ kubectl logs -f deployment.apps/mediawiki

#Check app on browser using load balancer

```

***Test app scaling***
```
#Check hpa status
~$ kubectl describe hpa/mediawiki

#Apply Load
~$ kubectl run apache-bench -i --tty --rm --image=httpd -- ab -n 500000 -c 1000 http://mediawiki.default.svc.cluster.local/

# Now check scaling stataus
~$ kubectl get hpa/mediawiki

NAME        REFERENCE              TARGETS   MINPODS   MAXPODS   REPLICAS   AGE
mediawiki   Deployment/mediawiki   20%/50%   2         10        8          6m25s

#Additionally, you can check the node scale status
$ kubectl get nodes

NAME                              STATUS   ROLES    AGE     VERSION
ip-192-168-123-245.ec2.internal   Ready    <none>   5m49s   v1.14.7-eks-1861c5
ip-192-168-136-12.ec2.internal    Ready    <none>   83s     v1.14.7-eks-1861c5
ip-192-168-154-140.ec2.internal   Ready    <none>   48s     v1.14.7-eks-1861c5
ip-192-168-175-138.ec2.internal   Ready    <none>   46m     v1.14.7-eks-1861c5
ip-192-168-212-162.ec2.internal   Ready    <none>   18m     v1.14.7-eks-1861c5
ip-192-168-223-73.ec2.internal    Ready    <none>   85s     v1.14.7-eks-1861c5
ip-192-168-68-72.ec2.internal     Ready    <none>   46m     v1.14.7-eks-1861c5

```
