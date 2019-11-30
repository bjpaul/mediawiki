***Setup Cluster Autoscaler***
```
#Add additional IAM policy to the nodegroup required for autoscaling 
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "autoscaling:DescribeAutoScalingGroups",
                "autoscaling:DescribeAutoScalingInstances",
                "autoscaling:DescribeLaunchConfigurations",
                "autoscaling:DescribeTags",
                "autoscaling:SetDesiredCapacity",
                "autoscaling:TerminateInstanceInAutoScalingGroup",
                "ec2:DescribeLaunchTemplateVersions"
            ],
            "Resource": "*",
            "Effect": "Allow"
        }
    ]
}

#Add required tags
#k8s.io/cluster-autoscaler/media-wiki-eks: owned
#k8s.io/cluster-autoscaler/enabled: true

# Apply below command
~$ kubectl apply -f cluster-autoscaler-autodiscover.yaml

<!-- Before applying we need to made few changes in the config file
- adding annotation cluster-autoscaler.kubernetes.io/safe-to-evict in the deployment config
- use the desired container image version. ref: https://github.com/kubernetes/autoscaler/releases -->

```

***Test auto scaling functionality***
```
~$ kubectl apply -f nginx.yaml
~$ kubectl get deployment/nginx-scaleout
~$ kubectl scale --replicas=10 deployment/nginx-scaleout

```

***Setup Metric Server, the metric aggregator***
```
# execute metric.sh
# check the deployment
~$ kubectl get deployment metrics-server -n kube-system
```