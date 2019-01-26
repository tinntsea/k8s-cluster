# Kubernetes Cluster using Kubeadm, Ansible, and Vagrant

## Creating kubernetes cluster

Step 1: Bring vagrant nodes up

```
vagrant up
```

Step 2: Install prerequisites for all nodes

```
ansible-playbook -i dev all.yml
```

Step 3: Install master node

```
ansible-playbook -i dev master.yml
```

Step 2: Install worker nodes

```
ansible-playbook -i dev worker.yml
```

## Verifying kubenetes cluster

To check if cluster is up:
```
kubectl get pods -n kube-system
```
```
vagrant@master:~$ kubectl get nodes
NAME     STATUS     ROLES    AGE   VERSION
master   NotReady   master   64s   v1.13.2
```

```
kubectl get pods -n kube-system
```
