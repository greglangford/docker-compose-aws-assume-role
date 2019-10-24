#!/bin/bash
if [ "$_" == "$0" ]; then
  echo "You must use source, e.g source ./assume-role.sh"
  exit 1
fi

if ! [ -f ".awsenv" ]; then
  echo ".awsenv not found, please create it"
  return
fi

REQUIRED_VARIABLES=(
  "AWS_ROLE_ARN"
  "AWS_ROLE_SESSION_NAME"
  "AWS_MFA_SERIAL"
  "AWS_PROFILE"
  "AWS_DEFAULT_REGION"
)

for var in "${REQUIRED_VARIABLES[@]}"; do
  unset ${var}
done

source .awsenv

for var in "${REQUIRED_VARIABLES[@]}"; do
  [ -z "${var}" ] && echo "$var is required in .awsenv" && return
done

echo "Please enter your token:"
read token

CREDENTIALS_JSON=$(aws sts assume-role \
  --role-arn $AWS_ROLE_ARN \
  --role-session-name $AWS_ROLE_SESSION_NAME \
  --serial-number $AWS_MFA_SERIAL \
  --token-code $token \
  --profile $AWS_PROFILE)

export AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION
export AWS_ACCESS_KEY_ID=$(echo $CREDENTIALS_JSON | jq -r '.Credentials.AccessKeyId')
export AWS_SECRET_ACCESS_KEY=$(echo $CREDENTIALS_JSON | jq -r '.Credentials.SecretAccessKey')
export AWS_SESSION_TOKEN=$(echo $CREDENTIALS_JSON | jq -r '.Credentials.SessionToken')
