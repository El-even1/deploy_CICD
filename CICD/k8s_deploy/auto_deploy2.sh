#!/bin/sh

# dnf install -y ansible-core;
# ssh-keygen -t rsa -b 3072 -f /root/.ssh/id_rsa -N ""
# ssh-copy-id root@192.168.30.11
# ssh-copy-id root@127.0.0.1

set -e
if [ ! -f hosts-cluster ]; then
	echo 'all.bash must be run from $GOROOT/k8s_deploy' 1>&2
	exit 1
fi

# ansible-playbook -i hosts-cluster rocky_repo.yaml # 使用vpn不用配置国内源
ansible-playbook -i hosts-cluster install_require_software_package.yaml
ansible-playbook -i hosts-cluster docker_repo.yaml
ansible-playbook -i hosts-cluster kubernetes_repo.yaml

ansible-playbook -i hosts-cluster swap_off.yaml
ansible-playbook -i hosts-cluster setenforce.yaml
ansible-playbook -i hosts-cluster network.yaml
ansible-playbook -i hosts-cluster firewalld_off.yaml

ansible-playbook -i hosts-cluster install_docker.yaml
ansible-playbook -i hosts-cluster install_cri_dockerd.yaml
ansible-playbook -i hosts-cluster install_kubernetes.yaml

# 需要修改master ip
# ansible-playbook -i hosts-cluster init_k8s_master.yaml # 只能初始成功一次，初始化成功以后不能再次初始化。如果初始化成功以后想再次初始化可以拍摄快照并恢复快照至初始化之前
# ansible-playbook -i hosts-cluster get_join_command.yaml
# ansible-playbook -i hosts-cluster join_k8s_cluster.yaml
# ansible-playbook -i hosts-cluster deploy_pod.yaml
# ansible-playbook -i hosts-cluster install_helm.yaml

# kubectl label nodes rocky-dev-1 node-role.kubernetes.io/worker=

# 去除master的污点
# kubectl describe node rocky9-master-1 | grep -i taints
# kubectl taint node rocky9-master-1  node-role.kubernetes.io/control-plane:NoSchedule-




