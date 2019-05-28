terraform init cluster
terraform apply -state=terraform.x-sell cluster


terraform init
terraform apply -state=terraform.x-sell --var="token=${K8S_TOKEN}" --var="k8s_host=${K8S_HOST}"
