Description
-----------
This is a work in progress, do not attempt to run deploy.sh until this message disappears from the readme.
The package works by generating all necessary .pem, .kubeconfig, and .yaml files on the local machine running the deploy.sh script. Once all files are generated, terraform is used to provision necessary compute instances for workers and controllers, as well as various networking resources requred for cluster functionality. Terraform will copy each generated file to the required compute instance on GCP, and then the script will remove the files from the local host.

Terraform Resources Created:
-----------------------------
* 3 "worker" compute instances
* 3 "controller" compute instances
* VPC resource
* External firewall
* Internal firewall
* Health Checks
* Network Load Balancer
* Target Pools


Files to generate:
------------------

Keys:
-----
* service-account-key.pem
* service-account.pem
* kubernetes-key.pem
* kubernetes.pem
* kube-scheduler-key.pem
* kube-scheduler.pem
* kube-proxy-key.pem
* kube-proxy.pem
* kube-controller-manager-key.pem
* kube-controller-manager.pem
* worker-0-key.pem
* worker-0.pem
* worker-1-key.pem
* worker-1.pem
* worker-2-key.pem
* worker-2.pem
* admin-key.pem
* admin.pem
* ca-key.pem
* ca.pem 

.Kubeconfig
-----------
* worker-0.kubeconfig
* worker-1.kubeconfig
* worker-2.kubeconfig
* kube-proxy.kubeconfig
* kube-controller-manager.kubeconfig
* kube-scheduler.kubeconfig
* admin.kubeconfig

YAML
-----
* encryption-config.yaml
* kube-scheduler.yaml
* kubelet-config.yaml
* kube-proxy-config.yaml

.Service
---------
* etcd.service
* kube-apiserver.service
* kube-controller-manager.service
* kube-scheduler.service
* containerd.service
* kubelet.service
* kube-proxy.service

Configs
-------
* bridge.conf
* loopback.conf

Others
-------
* etcd binaries
* nginx
* kubernetes.default.svc.cluster.local
* config.toml
* kubernetes.default.svc.cluster.local
