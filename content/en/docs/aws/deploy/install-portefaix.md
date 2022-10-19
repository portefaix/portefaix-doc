+++
title = "Install Portefaix"
description = "Instructions for deploying Portefaix on AWS"
weight = 10
+++

<a id="aws"></a>

## Setup

Creates an [AWS Organization](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_accounts_create.html), and enable Service Control Policies in AWS organizations.

Now that we’ve created an organization, you’ll notice that all the policies are disabled by default.

There you need to enable AWS Service Control Policies in the AWS console by clicking on the button Enable service control policies. Do the same action for the AWS Tag Policies.

Navigate to Personal Health Dashboard service in the console. On the left side panel, expand Organizational view and choose configurations. Then, enable organizational view for AWS Health

Create an [admin user](https://docs.aws.amazon.com/IAM/latest/UserGuide/getting-started_create-admin-group.html), and configure [account alias for IAM Users access](https://docs.aws.amazon.com/IAM/latest/UserGuide/getting-started_how-users-sign-in.html)

Then [API Keys](https://console.aws.amazon.com/iam/home?#/security_credentials).

Configure Portefaix environment file `${HOME}/.config/portefaix/portefaix.sh`:

```shell
HOME_IP=$(curl -s http://ifconfig.me)
SLACK_WEBHOOK_NOTIFS="https://hooks.slack.com/services/xxx/xxx"

# AWS
function setup_aws() {
    export AWS_ACCESS_KEY_ID="....."
    export AWS_SECRET_ACCESS_KEY="....."
    export AWS_DEFAULT_REGION="..."
    export AWS_REGION="...."
    # For Terraform Cloud
    export TF_VAR_access_key="${AWS_ACCESS_KEY_ID}"
    export TF_VAR_secret_key="${AWS_SECRET_ACCESS_KEY}"
    export TF_VAR_slack_webhook_url="${SLACK_WEBHOOK_NOTIFS}"
    export TF_VAR_org_email="xxxxxx"    # for Root Account
    export TF_VAR_org_email_domain="gmail.com"
    export TF_VAR_org_admin_username="xxxxxx"
    export TF_VAR_admin_ipv4="[\"${HOME_IP}/32\"]" # for WAF
}
```

Load environment :

```shell
❯ . ./portefaix.sh aws
```

## Storage for Terraform

Create a S3 bucket for Terraform states:

```shell
❯ make -f hack/build/aws.mk aws-s3-bucket ENV=staging
```

Create a DynamoDB table :

```shell
❯ make -f hack/build/aws.mk aws-dynamodb-create-table ENV=staging
```

## AWS Organization Units and Accounts

Configure the AWS Organization:

```shell
❯ make terraform-apply SERVICE=terraform/aws/root ENV=main
```

<img src="/docs/images/aws_organization.png" alt="
Portefaix AWS organization" class="mt-3 mb-3 rounded">

<a id="aws-terraform-cloud"></a>

## Terraform Cloud / Github Actions

* [Terraform Cloud](https://terraform.cloud) is used as the remote backend.
* [Github Actions](https://github.com/features/actions) perform tasks to deploy the AWS infrastructure.

```shell
❯ make terraform-apply SERVICE=terraform/aws/terraform-cloud ENV=main
```

<img src="/docs/images/portefaix-aws-deploy.png" alt="Portefaix AWS deployment" class="mt-3 mb-3 rounded">

<a id="aws-gitops"></a>

## Authentication

Perform an AWS authentication:

```shell
❯ make -f hack/build/aws.mk ENV=staging aws-admin
source ./hack/scripts/aws-auth.sh xxxxxx Administrator portefaix-staging-eks eu-west-1

❯ source ./hack/scripts/aws-auth.sh xxxxxxx Administrator portefaix-staging-eks eu-west-1
```

Update Kubernetes configuration file:

```shell
❯ make -f hack/build/aws.mk ENV=staging aws-kube-credentials

❯ kubectl get nodes
NAME                                        STATUS   ROLES    AGE   VERSION
ip-10-0-13-85.eu-west-1.compute.internal    Ready    <none>   81m   v1.23.9-eks-ba74326
ip-10-0-29-115.eu-west-1.compute.internal   Ready    <none>   81m   v1.23.9-eks-ba74326
ip-10-0-60-137.eu-west-1.compute.internal   Ready    <none>   81m   v1.23.9-eks-ba74326
ip-10-0-70-76.eu-west-1.compute.internal    Ready    <none>   81m   v1.23.9-eks-ba74326
```

## Gitops for Kubernetes

Next: [Gitops](/docs/gitops)