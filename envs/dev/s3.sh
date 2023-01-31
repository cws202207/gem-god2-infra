"bucket":
  "acceleration_status": ""
  "acl": "private"
  "arn": "arn:aws:s3:::awslogs.s3.gem-god-backend.com.aws-alb-log"
  "bucket": "awslogs.s3.gem-god-backend.com.aws-alb-log"
  "bucket_domain_name": "awslogs.s3.gem-god-backend.com.aws-alb-log.s3.amazonaws.com"
  "bucket_prefix": null
  "bucket_regional_domain_name": "awslogs.s3.gem-god-backend.com.aws-alb-log.s3.ap-northeast-1.amazonaws.com"
  "cors_rule": []
  "force_destroy": false
  "grant": []
  "hosted_zone_id": "Z2M4EHUR26P7ZW"
  "id": "awslogs.s3.gem-god-backend.com.aws-alb-log"
  "lifecycle_rule": []
  "logging": []
  "object_lock_configuration": []
  "policy": "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Principal\":{\"AWS\":\"arn:aws:iam::582318560864:root\"},\"Action\":\"s3:PutObject\",\"Resource\":\"arn:aws:s3:::awslogs.s3.gem-god-backend.com.aws-alb-log/*\"},{\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"delivery.logs.amazonaws.com\"},\"Action\":\"s3:PutObject\",\"Resource\":\"arn:aws:s3:::awslogs.s3.gem-god-backend.com.aws-alb-log/*\",\"Condition\":{\"StringEquals\":{\"s3:x-amz-acl\":\"bucket-owner-full-control\"}}},{\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"delivery.logs.amazonaws.com\"},\"Action\":\"s3:GetBucketAcl\",\"Resource\":\"arn:aws:s3:::awslogs.s3.gem-god-backend.com.aws-alb-log\"}]}"
  "region": "ap-northeast-1"
  "replication_configuration": []
  "request_payer": "BucketOwner"
  "server_side_encryption_configuration": []
  "tags":
    "Name": "awslogs.s3.gem-god-backend.com.aws-alb-log"
  "tags_all":
    "Env": "dev"
    "Name": "awslogs.s3.gem-god-backend.com.aws-alb-log"
    "System": "gem-god-backend"
  "versioning":
  - "enabled": false
    "mfa_delete": false
  "website": []
  "website_domain": null
  "website_endpoint": null
"bucket_domain_name": "awslogs.s3.gem-god-backend.com.aws-alb-log.s3.amazonaws.com"
"bucket_policy":
  "bucket": "awslogs.s3.gem-god-backend.com.aws-alb-log"
  "id": "awslogs.s3.gem-god-backend.com.aws-alb-log"
  "policy": "{\"Statement\":[{\"Action\":\"s3:PutObject\",\"Effect\":\"Allow\",\"Principal\":{\"AWS\":\"arn:aws:iam::582318560864:root\"},\"Resource\":\"arn:aws:s3:::awslogs.s3.gem-god-backend.com.aws-alb-log/*\"},{\"Action\":\"s3:PutObject\",\"Condition\":{\"StringEquals\":{\"s3:x-amz-acl\":\"bucket-owner-full-control\"}},\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"delivery.logs.amazonaws.com\"},\"Resource\":\"arn:aws:s3:::awslogs.s3.gem-god-backend.com.aws-alb-log/*\"},{\"Action\":\"s3:GetBucketAcl\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"delivery.logs.amazonaws.com\"},\"Resource\":\"arn:aws:s3:::awslogs.s3.gem-god-backend.com.aws-alb-log\"}],\"Version\":\"2012-10-17\"}"
"bucket_regional_domain_name": "awslogs.s3.gem-god-backend.com.aws-alb-log.s3.ap-northeast-1.amazonaws.com"
