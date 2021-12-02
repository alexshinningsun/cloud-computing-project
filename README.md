# Cloud computing project's setup 

  `This repo consist of Terraform script to build numbers of EC2 for later performance testing.`

Goal 1: Measure ec2 x n CPU performance diversity!

Goal 2: Measure ec2 x n Measure performance diversity!
## Directorys:
up-ec2-terraform: Cloud computing project's terraform scripts. This terraform script will build ec2 x n.

`If you want to change the number of n, please go to up-ec2-terraform/variables.tf and change the variable "numOfEC2" to whatever you want.`

`Or plz update the variable file as you wish.`

    Improvement : 
        - Please add the public key inside terraform variable file for ec2 creation. Currently, there are new key pairs on every $Terraform apply.
        - Reduce the instance role policy on the upEc2.tf
    
