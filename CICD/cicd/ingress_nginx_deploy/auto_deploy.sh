# 给需要部署nginx的node打上标签，该node作为整个集群的流量入口
kubectl label nodes <node> ingress=true
#kubectl label nodes master-1 ingress=true

#192.168.30.12 core.harbor.domain
#192.168.30.12 gitlab.example.com
#192.168.30.12 foo.bar.com

#helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
#helm repo update
#helm pull ingress-nginx/ingress-nginx
#tar -xvf ingress-nginx-*.tgz

# 安装
helm install ingress-nginx ./ingress-nginx -n ingress-nginx --create-namespace \
  -f ./values.yaml

# 测试
## 部署
kubectl apply -f test_ingress.yaml
## 查看是否ingress是否有address
kubectl get ingress
## 测试是否可访问
echo -e "192.168.30.11 foo.bar.com\n" >> /etc/hosts
ping foo.bar.com -c 3
curl -v http://foo.bar.com/
## 删除测试资源
kubectl delete -f test_ingress.yaml

# 安装完gitlab后再进行
# 部署流量转发配置
kubectl apply -f tcp-services-configmap.yaml
kubectl delete -n ingress-nginx pod <ingress-nginx-pod>



