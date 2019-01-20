# k8s-cluster

To provision k8s master node, run:
```
ansible-playbook -i dev -c local -u tin.nguyen all.yml
ansible-playbook -i dev -c local -u tin.nguyen master.yml
ansible-playbook -i dev -c local -u tin.nguyen worker.yml
```
