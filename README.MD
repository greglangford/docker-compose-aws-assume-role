## Getting started
Create a .awsenv file in the directory using the below as an example
```
AWS_DEFAULT_REGION="eu-west-2"
AWS_ROLE_ARN="<AWS_ROLE_ARN>"
AWS_ROLE_SESSION_NAME="<AWS_SESSION_NAME>"
AWS_MFA_SERIAL="<AWS_MFA_DEVICE_SERIAL_NUMBER>"
AWS_PROFILE="<AWS_PROFILE>"

```

1. Replace **AWS_ROLE_ARN** with the ARN of the role you are assuming
2. Replace **AWS_SESSION_NAME** with the name you want the session to appear as in AWS, this is not too critical e.g aws-role-session would do
3. Replace **AWS_MFA_DEVICE_SERIAL_NUMBER** with the ARN of the MFA Device you are using.
4. Replace **AWS_PROFILE** with the name of the profile in your ~/.aws/credentials file e.g default

## Running the example
Once you have followed the above steps you need to source the assume-role.sh script, you will be prompted for the token on your MFA device.

```
source ./assume-role.sh
```

Now you should be able to run the example. Upon a successful run you should see the output of printenv in the container which shows the AWS credentials from assuming the role.

```
docker-compose up
```
