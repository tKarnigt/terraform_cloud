# Guide to using terraform to create a GCP basic

### Required: 
- Google Cloud CLI (https://cloud.google.com/sdk/docs/install-sdk)
- Terraform (https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- Google Cloud Account

## Steps

### 1. Setting up your account.

Can using following command to authenticate with your account

``` bash
gcloud auth login
```

Go your console page and create a ```New Project```. Copy a project ID that you created and use 
```bash
export PROJECT_ID=<YOUR_PROJECT_ID>
```

Set created project as the active project
```bash
gcloud config set project $PROJECT_ID
```

then create a service account and role for terraform
```bash
gcloud iam service-accounts create sa-terraform \
    --description="Service account for Terraform" \
    --display-name="sa-terraform"

gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:sa-terraform@$PROJECT_ID.iam.gserviceaccount.com" \
    --role="roles/owner"

gcloud iam service-accounts keys create ./sa-key.json \
    --iam-account=sa-terraform@$PROJECT_ID.iam.gserviceaccount.com
```

enable to api for created in project
```bash
gcloud services enable compute.googleapis.com --project=$PROJECT_ID
```

### 2. Terraform

Initializes the Terraform configuration
```
terraform init
```

Prepares the execution plan and shows what will be created
```
terraform plan
```

Applies the changes to create the VM
```
terraform apply
```