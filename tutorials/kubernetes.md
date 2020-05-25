# kubernetes

## proxy config

```
set HTTP_PROXY=http://10.113.55.36:8080
set HTTPS_PROXY=http://10.113.55.36:8080
```

## Multiple environments

### CMD

```
set KUBECONFIG=%HOME%\.kube\config-int.yml
set KUBECONFIG=%HOME%\.kube\config-uat.yml
set KUBECONFIG=%HOME%\.kube\config-pro.yml
```

### powershell

```
$env:KUBECONFIG = "$HOME\.kube\config-int.yml"
$env:KUBECONFIG = "$HOME\.kube\config-uat.yml"
$env:KUBECONFIG = "$HOME\.kube\config-pro.yml"
```

# Useful arguments

* --user="kube-user"
* --server="https://kubemaster.example.com"
* --token=$ACCESS_TOKEN

# List pod/pods info

> kubectl get pods # -v=8

> kubectl get pod <pod-name> -ojson

> kubectl get pod <pod-name> -o yaml

> kubectl describe pod <pod-name>

# Restart pod

> kubectl delete pod <pod-name>

# Get pod logs

> kubectl logs -f <pod-name> -c <container-name>


# Configure configmap

> kubectl describe configmap xplcustomerbillmanagement-conf-cm

> kubectl edit configmap xplcustomerbillmanagement-conf-cm

## Deploy

> kubectl get deployments

> kubectl edit deployment <deployment-name>

> kubectl get deployment xplcustomerbillmanagement -o yaml > xplcustomerbillmanagement.yaml

> kubectl apply –f <file.yaml>

### Troubleshooting

* ImagePullBackOff: invalid image / not found in registry

## Update image of a deployed container

```yml
spec:
  terminationGracePeriodSeconds: 30
  containers:
  - name: my_container
    image: my_image:latest
    imagePullPolicy: "Always"
```

> kubectl set image deployment/my-deployment mycontainer=myimage:"$BUILD_NUMBER-$SHORT_GIT_COMMIT"

> kubectl patch deployment your_deployment -p \
  '{"spec":{"template":{"spec":{"terminationGracePeriodSeconds":31}}}}'


set PATH=%PATH%;"C:\Program Files\Sublime Text 3\"
set KUBE_EDITOR="subl --wait"



spec
template
spec
containers

kubectl patch deployment xplinstallationorders -p='{"spec":{"template":{"spec":{"containers":[{"name":"xplinstallationorders","imagePullPolicy":"Always","image":" registry-soe-tc.shared-nonprod.cloud.si.orange.es/fichaclientemmosp-snapshots/xplinstallationorders:1.1.2-SNAPSHOT"}]}}}}'





kubectl patch deployment xplinstallationorders --patch $(Get-Content update-image.yaml -Raw)




.\kubectl.exe patch deployment patch-demo --patch '{"spec": {"template": {"spec": {"containers": [{"name": "xplinstallationorders","image": "registry-soe-tc.shared-nonprod.cloud.si.orange.es/fichaclientemmosp-snapshots/xplinstallationorders:1.1.2-SNAPSHOT"}]}}}}'

.\kubectl.exe patch deployment patch-demo --patch 'spec:\n template:\n  spec:\n   containers:\n   - name: xplinstallationorders\n     image: registry-soe-tc.shared-nonprod.cloud.si.orange.es/fichaclientemmosp-snapshots/xplinstallationorders:1.1.2-SNAPSHOT'


kubectl patch deployment xplmobileinsurance --patch "\nspec:\n  template:\n    metadata:\n      labels:\n        version: 1.1.3-SNAPSHOT\n    spec:\n      containers:\n        - name: xplmobileinsurance\n          image: fichaclientemmosp-snapshots/xplmobileinsurance:1.1.3-SNAPSHOT\n\n"
