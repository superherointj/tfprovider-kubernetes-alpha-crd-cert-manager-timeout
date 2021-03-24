# Timeout Demo of Kubernetes-Alpha Terraform Provider installing Cert-Manager module in Linode LKE

## Brief

Attempting to install aareet/cert-manager module using Kubernetes-Alpha times out after 30min.

## Demo Sources
https://github.com/superherointj/tfprovider-kubernetes-alpha-crd-cert-manager-timeout

## Steps to Reproduce
```
$ git clone https://github.com/superherointj/tfprovider-kubernetes-alpha-crd-cert-manager-timeout

$ cd tfprovider-kubernetes-alpha-crd-cert-manager-timeout

* set your Terraform Cloud organization & workspace at `main.tf`

* `linode_token` variable must be set.

$ terraform init

$ terraform apply -target linode_lke_cluster.timeout_demo_lke

$ terraform output kubeconfig | sed -e 's/^"//' -e 's/"$//' | base64 -d > kubeconfig.yaml

$ terraform apply
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
