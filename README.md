## Deploying scalable IaaS web server in Azure

### Overview
Terraform and Packer templates are used to deploy a customizable, scalable web server in Azure using the Azure-CLI.
Knowledge of configure windows environmental variables is useful but not neccessary. 

### Getting Started
1. Create a free [Azure Account](https://portal.azure.com/)
2. Install the [Azure command line interface](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
3. Install [Packer](https://www.packer.io/downloads)
4. Install [Terraform](https://www.terraform.io/downloads.html)
5. Clone this repo
6. Your favorite IDE

### Instructions
Once you've created your Azure account and installed Terraform and Packer. You can buld and deploy the infrastructure to the cloud following the steps below. The script will prompt you for user name and passwords to the machines you deploy. It will also ask how many virtual machines should be deployed. the `vars.tf` file has been used to create dynamic login. You can modify this file to add your own variable. 
each variable in `vars.tf` should have a description and can have a default value. if no default value is given, you will be prompted for input during the script execution.

1. Clone this repository
2. Navigate to the cloned repository 
3. Open the source code in your favorite editor 
4. Navigate to the templates folders 
5. Run `Packer validate packer.json`
6. Run `Packer build -var your_azure_subscription_id packer.json`
7. Run `Terraform plan -out tf-webserver.plan`
8. Run `Terraform apply` 

### Once you logged into the Azure portal and reviewed the deployment: 
Run `Terraform destroy` to remove the infrastructure

### Output
Packer will create assest for the images you deploy. 
Terraform will create a plan that can be used to deploy to Azure. Review the output from `Terrafomr plan -out` to review the planned infrastructure deployment.
