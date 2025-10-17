#!/bin/bash

set -e

dnf install -y ansible

grep -qF 'host_key_checking = False' /etc/ansible/ansible.cfg || cat > /etc/ansible/ansible.cfg <<'EOF'
[defaults]
host_key_checking = False
gathering = smart
retry_files_enabled = False
stdout_callback = yaml
EOF

grep -qF '192.168.30.11' hosts-one.yaml || cat > hosts-one.yaml <<'EOF'
all_node:
  hosts:
    192.168.30.11:
      ansible_port: 2222 # sshd端口
      ansible_user: root # 连接node的用户

master:
  hosts:
    192.168.30.11:
      ansible_port: 2222 # sshd端口
      ansible_user: root # 连接node的用户

me:
  hosts:
    127.0.0.1:
      ansible_port: 2222 # sshd端口
      ansible_user: root # 连接0node的用户
EOF
