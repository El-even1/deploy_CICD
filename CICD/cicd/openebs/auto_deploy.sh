# 添加helm仓库
#helm repo add openebs https://openebs.github.io/charts
#helm repo update
#helm install openebs openebs/openebs --namespace openebs --create-namespace
#helm pull openebs/openebs
# 安装nfs类型的StorageClass
helm install openebs ./openebs -n openebs --create-namespace -f ./values.yaml
#helm upgrade openebs ./openebs -n openebs --create-namespace -f ./values.yaml
#helm uninstall  openebs -n openebs

# 测试
## 创建一个测试pvc
kubectl apply -f test/pvc-1.yaml
kubectl apply -f test/pod-1.yaml

## 查看pvc是否可以申请到pv
kubectl get pvc
## 查看是否自动创建了和该pv对应的目录
ls /var/openebs/local
## 删除测试pvc
kubectl delete -f test/pod-1.yaml
kubectl delete -f test/pvc-1.yaml

## 删除测试时自动创建的目录
rm -rf /var/openebs/local
