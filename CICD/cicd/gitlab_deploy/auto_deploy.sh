#!/bin/sh

#helm repo add gitlab https://charts.gitlab.io/
#helm repo update

# 获取charts
#helm pull gitlab/gitlab
#tar -xvf gitlab-*.tgz
# 安装gitlab
helm install gitlab ./gitlab -n gitlab --create-namespace -f values.yaml
# 更新
#helm upgrade gitlab gitlab/gitlab -n gitlab --create-namespace -f values.yaml

# 卸载
#helm uninstall gitlab --namespace gitlab

# 用户名: root
# 密码
kubectl -n gitlab get secret gitlab-gitlab-initial-root-password -ojsonpath='{.data.password}' | base64 --decode ; echo

# 修改宿主机的ssh端口为2222
vim /etc/ssh/sshd_config
systemctl reload sshd
# 是ingress-nginx 22端口转发至gitlab-shell的配置生效
kubectl delete -n ingress-nginx pod <pod>
# 测试是否可以通过ssh登录
ssh git@gitlab.example.com