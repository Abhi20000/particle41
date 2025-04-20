# Simple time and ip service app

After successful deployment it will show user the current ip and timestamp. It's a python and flask based web app.

## Table of Contents
- [Application]
- [Terraform]
- [Pipeline]
- [License]

## Application
Complete code is present on Github. It includes following things:-
1) "app" directory for the application code and docker. 
2) "terraform" directory for the infra creation and application deployment.
3) "bitbucket-pipelines.yml" file for pipeline
4) README.md for your help.

To get started with this project, you'll need to follow these steps:

1. Clone the repository:
   ```bash
   git clone https://github.com/Abhi20000/particle41.git

2. Navigate into the project directory:
   ```bash
   cd app

4. Build and run Docker application
   ```bash
   docker build -t <image-name> .
   
   docker push
   
   docker run -p 8000:8000 <image-id>
   
   ## Application will be accessible on <ip>:8000 in browser


## Terraform

This include the terraform script to create the needed infra on AWS cloud.
Befor running the script please make sure to configure below things.
1) Configure AWS credentials in your system where you are running this script. Either with aws configure command else set credential as environment value. For example on windows:- 
`set AWS_ACCESS_KEY_ID=your-access-key-id`
`set AWS_SECRET_ACCESS_KEY=your-secret-access-key`
`set AWS_DEFAULT_REGION=us-east-1`
Make sure the credentials have the necessay permission needed. For testing purpose yoou can grant Admin access (This is not recommanded). 
2) Inside `modules/ecs/main.tf` file `image = "abhisheksingh2000/particle41:task"` is used. You can leave it same application will work file else if you have updated image you can replace it.
3) "backend.tf" As backend.tf is already present, terraform init will try to use the remote backend right away.


To get started with this project, you'll need to follow these steps:

1. Navigate into the project directory:
   cd terraform

2)  Creating infra
```bash
## temporarily remove backend.tf 

mv backend.tf backend.tf.disabled
```

```bash
terraform init
terraform apply (type "yes" in "Enter a value")
```

3) Access application
In second step you will get load-balancer endpoint as output. Open it in browser to access the application. Make sure it should be `http://<load-balancer-endpoint>`

4) Backend Remote state

```bash
mv backend.tf.disabled backend.tf
terraform init
terraform apply
```

# Running the terraform script will create the following infra in AWS

1) A VPC with 2 public and 2 private subnets.
2) An ECS cluster deployed to that VPC.
3) A ECS task/service resource to run the container
4) The tasks and/nodes is on the private subnets only.
5) A Natgateway for internet communication for resources in private subnet
6) A load balancer deployed in the public subnets to offer the service.
7) Terraform backend (S3 and DynamoDB) for state and locking


## Pipeline(CI/CD)

Bitbucket pipeline is used for the CI/CD.

# Configure credentials for CI/CD
`Repository settings > Repository variables`
Add the following variables with AWS credentials:

```bash
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
(Optionally) AWS_DEFAULT_REGION
```

Run the pipeline in bitbucket it will apply the necessary changes

# License
This project is licensed under the MIT License - see the LICENSE file for details.
