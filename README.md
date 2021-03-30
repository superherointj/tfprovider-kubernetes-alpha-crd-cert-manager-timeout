# Timeout Demo of Kubernetes-Alpha Terraform Provider installing Cert-Manager module in Linode LKE

## Brief

Attempting to install aareet/cert-manager module using Kubernetes-Alpha times out after 30min.

## Demo Sources
https://github.com/superherointj/tfprovider-kubernetes-alpha-crd-cert-manager-timeout

## Steps to Reproduce

Manually:

```
* Terraform v0.14.8 is installed.

$ git clone https://github.com/superherointj/tfprovider-kubernetes-alpha-crd-cert-manager-timeout

$ cd tfprovider-kubernetes-alpha-crd-cert-manager-timeout

* set Terraform credentials to yours:
    $ terraform login
  or
    Create file "terraform.rc":
    --
    credentials "app.terraform.io" {
        token = "your_terraform_cloud_token"
    }
    --
    $ export TF_CLI_CONFIG_FILE=terraform.rc

* replace Terraform Cloud organization & workspace at `main.tf` to yours.

* set `linode_token` either locally as environment variable or remotely at Terraform Cloud.

$ export TF_LOG=TRACE; export TF_LOG_PATH=tf-timeout-demo.log

$ TF_LOG_PATH=tf-init.log terraform init

$ TF_LOG_PATH=tf-lke_cluster.log terraform apply -target linode_lke_cluster.timeout_demo_lke

$ TF_LOG_PATH=tf-kubeconfig.log terraform output kubeconfig | sed -e 's/^"//' -e 's/"$//' | base64 -d > kubeconfig.yaml

$ TF_LOG_PATH=tf-apply.log terraform apply
```

Docker:

```
$ echo TF_TOKEN=replace_with_your_terraform_token > .env
$ make
$ ls dump/*.logs
```

Nix: (WIP - Currently broken)
```
$ nix build
```

## After some minutes...

It gets stuck here:

```
Plan: 39 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  ~ pool = [
      ~ {
          ~ nodes = [
              ~ {
                  ~ status      = "not_ready" -> "ready"
                    # (2 unchanged elements hidden)
                },
            ]
            # (3 unchanged elements hidden)
        },
    ]

```

Until 30min timeout from Terraform Cloud, that errors:

```
------------ Terraform Cloud System Message ------------

WARNING: This plan has timed out and will now terminate!

Terraform Cloud enforces a 30m0s maximum run time for this operation. Please
review the logs above to determine why the run has exceeded its timeout. You
can re-run this operation by queueing a new plan in Terraform Cloud.

--------------------------------------------------------
Failed to generate JSON: wait: remote command exited without exit status or exit signal
```

## Expectation

* Take less time.
* Be able to accept the plan/apply by either typing 'yes' on CLI or clicking on "Apply Pending" button in Terraform Cloud and it'd accept the plan?
* Cert-Manager CRD would be installed.

## Notes

* Screenshots available at demo: tf-error-at-29min.png, tf-error-after-30min.png

* aareet/cert-manager:
https://registry.terraform.io/modules/aareet/cert-manager/kubernetes/latest

### Versions

* Terraform version: v0.14.8
* Kubernetes Alpha Provider version: v0.3.2
* Kubernetes version: v1.20.4
* Terraform Cloud: Yes.
* Linode: 1.16.0

## Questions

--
Thanks.