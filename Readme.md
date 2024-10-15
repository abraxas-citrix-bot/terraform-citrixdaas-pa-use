# Terraform-Citrix-Playground

_Welcome to your new Terraform playground!_

In this project, you can test your Terraform and Azure skills and try out new things. We have prepared everything you need to get started with a simple Terraform script.

Have fun experimenting!

## Warning!
This project is intended for testing purposes only. Please do not use it for deploying production infrastructure.

Have fun with Terraforming! :)

## Instructions for Using the Repository

### Step 1
1. Create a Citrix API Key in the Citrix DaaS Tenant and enter it in the following format:
   
    ```sh
    export TF_VAR_client_id="xxxxx"
    export TF_VAR_client_secret="xxxxx"
    export TF_VAR_customer_id="xxxx"
    export TF_VAR_citrix_deliverygroup_name=""
    export TF_VAR_citrix_application_visibility=""
    ```

### Step 2
2. Download the Terraform files on Linux or WSL.

### Step 3
3. Run `terraform init`.

### Step 4
4. Enter the environment variables in the shell.

### Step 5
5. Execute `terraform plan`.

### Step 6
6. Execute `terraform apply -auto-approve`.

### Step 7
7. Execute `terraform destroy -auto-approve`.

## Roadmap

Would you like to see new projects in this repository?

If you have ideas or suggestions for new projects that should be included in this repository, feel free to create an issue or submit a pull request.

## Support

Have you encountered a problem or found a bug?

If you find a problem or a bug, feel free to create an issue or submit a pull request to fix the problem.

Good luck!
