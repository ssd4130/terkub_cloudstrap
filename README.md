Prerequisites
--------------
* Verify your Google Cloud SDK version is 218.0.0 or higher
* Install cfssljson, cfssl, kubectl

*Note: Estimated cost to run this tutorial $0.22 per hour on GCP ($5.39 per day)*

Description
-----------
**This is a work in progress, do not attempt to run deploy.sh until this message disappears from the readme.**

This project is to demonstate deploying GCP instances to create an unmanaged Kubernetes cluster using Terraform to configure the instances. The two main instances in the cluster are "Controller" and "Worker" instances. The cluster is composed of three of each type of instance. 

The script **deploy.sh**, when run, will execute a number of generation scripts to create the unique keys required for the services that run on the worker and controller instaces. Once the scipt finishes generating the files, it then uses Terraform to deploy the instances and copies the required files to each type of instance. Once this provisioning is done, the script will clean deployment fragments from the deployment server.

All resources that are created by deploy.sh are located in the cluster directory. All resources (including temp files for configuration and keys) and scripts are located in the resources directory.

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
