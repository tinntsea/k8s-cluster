# Kubernetes Cluster using Kubeadm, Ansible, and Vagrant
k8s-cluster helps developers/devops engineers to create and run their own kubernetes cluster (single master + multiple worker nodes) on their laptops.

## Prerequisites
- [Vagrant](https://www.vagrantup.com/)
- [Virtual Box](https://www.virtualbox.org/wiki/Downloads)
- [Ansible](https://www.ansible.com/)

## Creating kubernetes cluster

#### Option 1: Run a shell script to bring up the cluster
```
./up.sh
```

#### Option 2: Step by step
Step 1: Bring vagrant VMs up

```
vagrant up
```

Step 2: Install prerequisites for all VMs

```
ansible-playbook -i dev_vagrant all.yml
ansible-playbook -i dev_vagrant vagrant_fix_kube_internal_ip.yml
```

Step 3: Install master node

```
ansible-playbook -i dev_vagrant master.yml
```

Step 4: Install worker nodes

```
ansible-playbook -i dev_vagrant worker.yml
```

## Verifying kubernetes cluster

To check if cluster is up:
```
ssh vagrant@10.1.100.100
```

```
kubectl get pods -all-namespaces

vagrant@master:~$ kubectl get pods --all-namespaces
NAMESPACE     NAME                             READY   STATUS    RESTARTS   AGE
kube-system   coredns-86c58d9df4-fbmp2         1/1     Running   0          13h
kube-system   coredns-86c58d9df4-ng5jz         1/1     Running   0          13h
kube-system   etcd-master                      1/1     Running   0          13h
kube-system   kube-apiserver-master            1/1     Running   0          13h
kube-system   kube-controller-manager-master   1/1     Running   0          13h
kube-system   kube-flannel-ds-amd64-6l52q      1/1     Running   0          13h
kube-system   kube-flannel-ds-amd64-ztvbp      1/1     Running   0          13h
kube-system   kube-proxy-4rq82                 1/1     Running   0          13h
kube-system   kube-proxy-nshrw                 1/1     Running   0          13h
kube-system   kube-scheduler-master            1/1     Running   0          13h
```

```
kubectl get nodes

vagrant@master:~$ kubectl get nodes
NAME      STATUS   ROLES    AGE   VERSION
master    Ready    master   13h   v1.13.2
worker1   Ready    <none>   13h   v1.13.2
```
