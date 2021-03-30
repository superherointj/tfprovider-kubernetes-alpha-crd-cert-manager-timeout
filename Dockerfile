FROM archbase

RUN git clone https://github.com/superherointj/tfprovider-kubernetes-alpha-crd-cert-manager-timeout

WORKDIR /workdir/tfprovider-kubernetes-alpha-crd-cert-manager-timeout

RUN chmod +x bootstrap.sh

CMD /workdir/tfprovider-kubernetes-alpha-crd-cert-manager-timeout/bootstrap.sh $@

# ENV TF_TOKEN=$TF_TOKEN

# ENV TF_TOKEN
#=$TF_TOKEN

# RUN cat terraform.rc


#     credentials "app.terraform.io" {
#         token = "your_terraform_cloud_token"
#     }


# WORKDIR $ cd tfprovider-kubernetes-alpha-crd-cert-manager-timeout

# * set Terraform credentials to yours:
#     $ terraform login
#   or
#     Create file "terraform.rc":
#     --
#     credentials "app.terraform.io" {
#         token = "your_terraform_cloud_token"
#     }
#     --
#     $ export TF_CLI_CONFIG_FILE=terraform.rc

# * replace Terraform Cloud organization & workspace at `main.tf` to yours.

# * set `linode_token` either locally as environment variable or remotely at Terraform Cloud.

# RUN export TF_LOG=TRACE; export TF_LOG_PATH=tf-timeout-demo.log

# RUN TF_LOG_PATH=tf-init.log terraform init

# RUN TF_LOG_PATH=tf-lke_cluster.log terraform apply -target linode_lke_cluster.timeout_demo_lke

# RUN TF_LOG_PATH=tf-kubeconfig.log terraform output kubeconfig | sed -e 's/^"//' -e 's/"$//' | base64 -d > kubeconfig.yaml

# RUN TF_LOG_PATH=tf-apply.log terraform apply