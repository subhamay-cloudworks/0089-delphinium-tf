# Project Delphinum: Scheduling a Lambda function using EventBridge to send an email every day using SES and a pre-signed URL of an image.

Demonstration of running a Lambda function on a Daily schedule using EventBridge Rule.

## Description

Some Good Morning images are stored in a S3 bucket which is encrypted using Customer managed KMS Key. A Lambda function randomly picks up an image, generates a pre-sgned URL and send the same using a email and SES to the sender. The entire stack is created using HashiCorp Terraform.

![Project Delphinum - Design Diagram](https://subhamay-projects-repository-us-east-1.s3.amazonaws.com/0089-delphinum/delphinum-architecture-diagram.png)

![Project Delphinum - Services Used](https://subhamay-projects-repository-us-east-1.s3.amazonaws.com/0089-delphinum/delphinum-services-used-tf.png)

## Getting Started

### Dependencies

* Create a Customer Managed KMS Key in the region where you want to create the stack.
* Modify the KMS Key Policy to let the IAM user encrypt / decrypt using any resource using the created KMS Key.
* Setup AWS CLI with an user having appropriate access to create the required resources.

### Installing

* Clone the repository https://github.com/subhamay-cloudworks/0089-delphinum-tf
### Executing program

* From the main project diretory submit the following commands:
```
terraform init

terraform validate 

terraform plan

terraform apply -auto-approve

# To delete the stack 
terraform destroy -auto-approve
```

## Help

Post message in my blog (https://blog.subhamay.com)


## Authors

Contributors names and contact info

Subhamay Bhattacharyya  - [subhamay.aws@gmail.com](https://blog.subhamay.com)

## Version History

* 0.1
    * Initial Release

## License

This project is licensed under Subhamay Bhattacharyya. All Rights Reserved.

## Acknowledgments

Inspiration, code snippets, etc.
* [Denis Astahov ] (https://www.astahov.net/)
* [Derek Morgan ] (https://www.linkedin.com/in/derekm1215/)
* [Kalyan Reddy Daida ] (https://www.linkedin.com/in/kalyan-reddy-daida/)

