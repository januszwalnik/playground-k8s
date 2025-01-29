## General Kubernetes repositorie for practice

### Usefull commands

#### Switching context

k config get-contexts 
k config use-context <context>

k config set-context --current --namespace=<namespace-name>

#### Retrieving the information about containers
Get only name of the container inside the pod:

```bash
k get pods -o jsonpath='{.items[0}.metadata.name}'

# Combine information about pod with execute:

k exec -it $(k get pods -o jsonpath='{.items[0].metadata.name}') -- /bin/bash

# Delete pod to make it force recreate
k delete pod $(k get pods -o jsonpath='{.items[0].metadata.name}')

```



#### General information and troubleshooting
k get event -> Provide information about what happening in the cluster

k logs <pod-name> -> Providing logs from the pod

# Port forward of the  pod

k port-forward pod/<pod-name> <local-port>:<pod-port>

example for nginx:
k port-forward svc/nginx-service 8080:80 -n dev-personal-namespace


#### How to import configuration into the ConfigMap
```bash
kubectl create configmap nginx-config --from-file=./nginx_conf --dry-run=client -o yaml > 320-nginxConfigMap.yml

# Using script that will import all files from nginx_conf and save them into configMap file

chmod +x ./scripts/nginx_conf_gen.sh
./scripts/nginx_conf_gen.sh
```

