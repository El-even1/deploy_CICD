#!/bin/sh

#helm repo add harbor https://helm.goharbor.io
#helm repo update

# 拉取charts模板
#helm pull harbor/harbor
#tar -xvf harbor-*.tgz
# 安装harbor
helm install harbor ./harbor -n harbor --create-namespace -f ./values-localpv.yaml

#helm uninstall harbor --namespace harbor

# 用户名: admin
# 密码: <values.yaml中配置的密码>
