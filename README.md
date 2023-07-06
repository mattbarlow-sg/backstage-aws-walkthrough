<!-- BEGIN_TF_DOCS -->
# template-terraform-infrastructure-starter

GitHub: [StratusGrid/template-terraform-infrastructure-starter](https://github.com/StratusGrid/template-terraform-infrastructure-starter)

## Assumptions we make

* We assume you have a basic badge in Terraform

## Terraform Infrastructure Starter
This repository is meant to be used when starting new infrastructure projects. Use the init-tfvars
and apply-tfvars to set store unique per account or per environment variables and then run per
environment like so:
### Dev
```
terraform init -backend-config=./init-tfvars/dev.tfvars
terraform apply -var-file ./apply-tfvars/dev.tfvars
```
### Stg
```
terraform init -backend-config=./init-tfvars/stg.tfvars
terraform apply -var-file ./apply-tfvars/stg.tfvars
```
### Prd
```
terraform init -backend-config=./init-tfvars/prd.tfvars
terraform apply -var-file ./apply-tfvars/prd.tfvars
```
Note: Before reading, uncomment the code for the environment that you
wish to apply the code to. This goes for both the init-tfvars and apply-tfvars
folders.

To properly implement infrastructure designed for a specific environment,
the config first has to be created locally and then migrated to AWS. For example,
if we wanted to apply infrastructure to prd, we would first need do a basic
terraform init and then terraform apply using prd.tfvars. The below code
illustrates this:

```
terraform init
terraform apply -var-file ./apply-tfvars/prd.tfvars
```

Assuming the variables defined in prd.tfvars are valid and the terraform apply
works, we should have a local config with the prd variables applied to it. We should also
get some outputs in the terminal with values for "bucket", "DynamoDB_Table", and some others.
We will need to copy those values and paste them into init-tfvars/(environemnt).tfvars for
each key that exists. Since we are doing this example with prd in mind, it would be
init-tfvars/prd.tfvars. We are now ready to migrate this local config to AWS.
To do that, change the file name of `state.tfnot` to `-state.tf` and
delete the .terraform folder at the top left of your screen. You'll then init again,
this time using the -backend-config option. For example:

```
terraform init -backend-config=./init-tfvars/prd.tfvars
```

You should get a prompt asking if you want to migrate the config. Say yes and you should be set.
To switch environments, (for this example let's use dev) delete the .terraform folder and
init using the back-end-config option:

```
terraform init -backend-config=./init-tfvars/dev.tfvars
```

## Documentation

This repo is self documenting via Terraform Docs, please see the note at the bottom.

---

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.5 |

## Resources

| Name | Type |
|------|------|
| [aws_backup_plan.a_backup_plan](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_plan) | resource |
| [aws_backup_selection.a_backup_selection](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_selection) | resource |
| [aws_backup_vault.a_backup_vault](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_vault) | resource |
| [aws_backup_vault_notifications.backup_failed](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_vault_notifications) | resource |
| [aws_iam_role.backup](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.backup](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_sns_topic.backup_failed](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_policy.test](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_policy) | resource |
| [aws_sns_topic_subscription.backup_failed](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backup_failed_sns_endpoint"></a> [backup\_failed\_sns\_endpoint](#input\_backup\_failed\_sns\_endpoint) | SNS topic endpoint | `string` | `"msp@stratusgrid.com"` | no |
| <a name="input_backup_key"></a> [backup\_key](#input\_backup\_key) | Tag key used to indicate backup resource | `string` | `"AWS_Backup"` | no |
| <a name="input_backup_key_value"></a> [backup\_key\_value](#input\_backup\_key\_value) | Tag key used to indicate backup resource | `string` | `true` | no |
| <a name="input_env_name"></a> [env\_name](#input\_env\_name) | Environment name string to be used for decisions and name generation | `string` | n/a | yes |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | String to use as prefix on object names | `string` | n/a | yes |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | String to append to object names. This is optional, so start with dash if using. | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region to target | `string` | n/a | yes |
| <a name="input_source_repo"></a> [source\_repo](#input\_source\_repo) | name of repo which holds this code | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_account_id"></a> [account\_id](#output\_account\_id) | Account which terraform was run on |
| <a name="output_common_tags"></a> [common\_tags](#output\_common\_tags) | tags which should be applied to all taggable objects |
| <a name="output_name_prefix"></a> [name\_prefix](#output\_name\_prefix) | string to prepend to all resource names |
| <a name="output_name_suffix"></a> [name\_suffix](#output\_name\_suffix) | string to append to all resource names |
| <a name="output_region"></a> [region](#output\_region) | n/a |

---

Note, manual changes to the README will be overwritten when the documentation is updated. To update the documentation, run `terraform-docs -c .config/.terraform-docs.yml`
<!-- END_TF_DOCS -->