#!/usr/bin/env bash
set -e

read -p "Press profile name: " PROFILE
echo -n "Enter your multi-factor authentication code: "
read -r TOKEN_CODE

#PROFILE=`echo -n "Input your profile name= "`
#PROFILE="my-profile"
SERIAL_NUMBER='arn:aws:iam::660506286494:mfa/test1'
#SERIAL_NUMBER=`aws sts get-caller-identity | jq '.Arn' | sed -e "s/\"//g" | sed -e "s/user/mfs/g"`
#MFA_PROFILE="${PROFILE}-mfa"
MFA_PROFILE="gem-god-backend_mfa"
REGION=$(aws configure get region --profile "$PROFILE" --output text)
echo $PROFILE
echo $SERIAL_NUMBER


STS_CREDENTIALS=$(aws sts get-session-token \
  --serial-number "$SERIAL_NUMBER" \
  --token-code "$TOKEN_CODE" \
  --query "Credentials" \
  --profile "$PROFILE" \
  --output json)

aws configure set aws_access_key_id "$(echo "$STS_CREDENTIALS" | jq -r '.AccessKeyId')" --profile "$MFA_PROFILE"
aws configure set aws_secret_access_key "$(echo "$STS_CREDENTIALS" | jq -r '.SecretAccessKey')" --profile "$MFA_PROFILE"
aws configure set aws_session_token "$(echo "$STS_CREDENTIALS" | jq -r '.SessionToken')" --profile "$MFA_PROFILE"
aws configure set region "$REGION" --profile "$MFA_PROFILE"
aws configure set output json --profile "$MFA_PROFILE"

echo "AWS Profile, ${MFA_PROFILE}, has been saved to your config file."
