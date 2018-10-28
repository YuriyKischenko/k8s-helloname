# k8s-helloname

## Upload image to Docker Hub
```
$ cd image
$ docker login
$ ./build-upload-image.sh
```

## Use terraform to deploy application to Kubernetes
```
$ cd terraform
$ terraform init
$ terraform plan -var 'name=test1' -out=plan
$ terraform apply "plan"
```

## Check output
```
$ IP=$(kubectl get svc hello-name -o yaml | grep clusterIP | tr -d ' clusterIP:'); curl http://${IP}:8080/
```

## Change name
```
$ terraform apply -auto-approve -var 'name=test2'
```
