#!/usr/bin/env bash
set -e

export ANSIBLE_HOST_KEY_CHECKING="False"

echo "Bring up vagrant VMs..."
vagrant up

echo "Install prerequisites for all VMs..."
ansible-playbook -i dev_vagrant all.yml
ansible-playbook -i dev_vagrant vagrant_fix_kube_internal_ip.yml

echo "Setup master"
ansible-playbook -i dev_vagrant master.yml

echo "Setup worker nodes"
ansible-playbook -i dev_vagrant worker.yml
