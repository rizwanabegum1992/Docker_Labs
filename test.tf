import boto3

# Initialize AWS clients
ec2_client = boto3.client('ec2')
s3_client = boto3.client('s3')

# Create Security Group
security_group = ec2_client.create_security_group(
    Description='Example security group allowing open internet access',
    GroupName='OpenToInternet'
)

# Allow inbound traffic from anywhere (open to the world)
ec2_client.authorize_security_group_ingress(
    GroupId=security_group['GroupId'],
    IpProtocol='tcp',
    FromPort=0,
    ToPort=65535,
    CidrIp='0.0.0.0/0'
)

# Create S3 Bucket
bucket_name = 'public-read-bucket-example'
s3_client.create_bucket(
    Bucket=bucket_name
)

# Enable public access for the bucket
s3_client.put_public_access_block(
    Bucket=bucket_name,
    PublicAccessBlockConfiguration={
        'BlockPublicAcls': True,
        'IgnorePublicAcls': True,
        'BlockPublicPolicy': True,
        'RestrictPublicBuckets': True
    }
)

# Disable server access logging for the bucket
s3_client.put_bucket_logging(
    Bucket=bucket_name,
    BucketLoggingStatus={}
)

print(f'Security Group ID: {security_group["GroupId"]}')
print(f'S3 Bucket Created: {bucket_name}')
