# ce-grp-1
Capstone project cohort 9

# Overall Plan for CE-GRP-1 DevOps Capstone
- VPC & Networking
- EKS Cluster (Private) with Dev, Test, Prod Namespaces
- Ingress Controller & Load Balancer (ALB Ingress Controller)
- Route 53 Configuration (ce-grp-1.sctp-sandbox.com)
- Helm + Argo CD setup
- CI/CD with GitHub Actions (build, push, deploy)
- Prometheus for Monitoring
- Sample Static Website Deployment

# Step-by-Step: Setup Remote Backend
## Step 1: Create Terraform state bucket and DynamoDB lock table
You can use the AWS CLI or Terraform itself for this, but here’s the minimal AWS CLI method:

```
aws s3api create-bucket --bucket ce-grp-1-tfstate --region us-east-1

aws dynamodb create-table \
  --table-name ce-grp-1-tf-locks \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST
```

## Step 2: Create backend.tf in your terraform/vpc/ folder


⚠️ Important: Do not run terraform apply yet — first you must migrate local state to S3 using the instructions below, if you have implemented state file locking.

## Step 3: Initialize Backend
Only the first time, run this:

```terraform init -backend-config=../vpc/backend.tf
```



# Error and Resolution

## Error #1
```
aaronlim@Aarons-MacBook-Air vpc % terraform init                                  
Initializing the backend...
╷
│ Error: Error refreshing state: state data in S3 does not have the expected content.
│ 
│ The checksum calculated for the state stored in S3 does not match the checksum
│ stored in DynamoDB.
│ 
│ Bucket: ce-grp-1-tfstate
│ Key:    vpc/terraform.tfstate
│ Calculated checksum: 
│ Stored checksum:     ce3c53a3547e884bdba9ec514cee9b4f
│ 
│ This may be caused by unusually long delays in S3 processing a previous state
│ update. Please wait for a minute or two and try again.
│ 
│ If this problem persists, and neither S3 nor DynamoDB are experiencing an
│ outage, you may need to manually verify the remote state and remove the Digest
│ value stored in the DynamoDB table
```

## How to Fix It - Error #1
Clean up the DynamoDB table entry (safe)
Terraform stores locks in the DynamoDB table with a hash called LockID. Here’s how to clean it up:

Step 1: Open AWS Console > DynamoDB
Table name: ce-grp-1-tf-locks
Find the record with:
Partition key: LockID
Value: likely something like vpc/terraform.tfstate-md5

Step 2: Delete the LockID Record Manually
Select the record (row)
Click Actions > Delete
Confirm deletion

This removes the lock checksum that Terraform thinks is stale or corrupted.



