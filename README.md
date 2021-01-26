# Condor

Condor is easiest and fastest way to deploy a Kubernetes cluster on Vultr. 

## Addons
  * Installs the [Vultr CCM](https://github.com/vultr/vultr-cloud-controller-manager)
  * Installs the [Vultr CSI](https://github.com/vultr/vultr-csi)
  * Installs Flannel CNI

While Condor defaults many cluster configurations you are also able to adjust and fine tune the cluster to your specific needs.

Please refer to the [Terraform Module Registry Docs](https://registry.terraform.io/modules/vultr/condor/vultr/latest) for usage and required inputs, or see the Usage section below.

## Usage
1. Create a `main.tf` file:
``` hcl
# main.tf

module "condor" {
  source                 = "vultr/condor/vultr"
  version                = "1.0.0"
  provisioner_public_key = chomp(file("~/.ssh/id_rsa.pub"))
}
```
2. Configure the [Required Inputs](https://registry.terraform.io/modules/linode/k8s/linode/latest?tab=inputs#required-inputs):
  * `provisioner_public_key` -  For example, using Terraform functions: `chomp(file("~/.ssh/id_rsa.pub"))`
  * `cluster_vultr_api_key` - Can be configured as an environment variable in your shell(Recommended) or as a string in your `main.tf`(Only recommended for testing).

3. Configure the [Optional Inputs](https://registry.terraform.io/modules/linode/k8s/linode/latest?tab=inputs#optional-inputs) if you wish to change from the defaults.

4. Deploy
``` sh
terraform apply
```

5. Check your cluster:

``` sh
kubectl get no --kubeconfig ~/.kube/condor/<cluster-name>-<cluster-id>/configkubectl --kubeconfig ~/.kube/condor/condor-test-728e1059637c7a78/config get no
NAME                                        STATUS   ROLES                  AGE   VERSION
<cluster-name>-<cluster-id>-controller-0   Ready    control-plane,master   16h   v1.20.2
<cluster-name>-<cluster-id>-worker-0       Ready    <none>                 16h   v1.20.2
<cluster-name>-<cluster-id>-worker-1       Ready    <none>                 16h   v1.20.2
```

## Notes
 * If an Existing Firewall Group ID is not provided via the `firewall_group_id` input, an empty Vultr Firewall Group will be created and exposed via the `condor_firewall_group_id` output. You may wish to configure firewall rules in your `main.tf` referencing the `condor_firewall_group_id` output to lock down your cluster as needed. 

