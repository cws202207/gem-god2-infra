"alb":
- "bucket": "awslogs.s3.gem-god-backend.com.aws-alb-log"
  "enabled": true
  "prefix": "god-api"
"aws_lb_l":
  "access_logs":
  - "bucket": "awslogs.s3.gem-god-backend.com.aws-alb-log"
    "enabled": true
    "prefix": "god-api"
  "arn": "arn:aws:elasticloadbalancing:ap-northeast-1:660506286494:loadbalancer/app/god-api/80cac4096e593f8c"
  "arn_suffix": "app/god-api/80cac4096e593f8c"
  "customer_owned_ipv4_pool": ""
  "desync_mitigation_mode": "defensive"
  "dns_name": "god-api-861774272.ap-northeast-1.elb.amazonaws.com"
  "drop_invalid_header_fields": false
  "enable_cross_zone_load_balancing": true
  "enable_deletion_protection": false
  "enable_http2": true
  "enable_waf_fail_open": false
  "id": "arn:aws:elasticloadbalancing:ap-northeast-1:660506286494:loadbalancer/app/god-api/80cac4096e593f8c"
  "idle_timeout": 60
  "internal": false
  "ip_address_type": "ipv4"
  "load_balancer_type": "application"
  "name": "god-api"
  "name_prefix": null
  "security_groups":
  - "sg-0957ef165bb409db0"
  "subnet_mapping":
  - "allocation_id": ""
    "ipv6_address": ""
    "outpost_id": ""
    "private_ipv4_address": ""
    "subnet_id": "subnet-002e2412ebc222b85"
  - "allocation_id": ""
    "ipv6_address": ""
    "outpost_id": ""
    "private_ipv4_address": ""
    "subnet_id": "subnet-06e6fcd71e826019d"
  - "allocation_id": ""
    "ipv6_address": ""
    "outpost_id": ""
    "private_ipv4_address": ""
    "subnet_id": "subnet-0e9afcc69aba21ea1"
  "subnets":
  - "subnet-002e2412ebc222b85"
  - "subnet-06e6fcd71e826019d"
  - "subnet-0e9afcc69aba21ea1"
  "tags": {}
  "tags_all":
    "Env": "dev"
    "System": "gem-god-backend"
  "timeouts": null
  "vpc_id": "vpc-0c057902533c73daa"
  "zone_id": "Z14GRHDCWA56QT"
"aws_lb_listener_rule_dest":
- "action":
  - "authenticate_cognito": []
    "authenticate_oidc": []
    "fixed_response": []
    "forward": []
    "order": 1
    "redirect": []
    "target_group_arn": "arn:aws:elasticloadbalancing:ap-northeast-1:660506286494:targetgroup/god-api-god-api/f44354f23f018ff6"
    "type": "forward"
  "arn": "arn:aws:elasticloadbalancing:ap-northeast-1:660506286494:listener-rule/app/god-api/80cac4096e593f8c/70a04dd9e82a775c/5fb62cf111402076"
  "condition":
  - "host_header":
    - "values":
      - "dev.god-api.gem-god-backend.com"
    "http_header": []
    "http_request_method": []
    "path_pattern": []
    "query_string": []
    "source_ip": []
  "id": "arn:aws:elasticloadbalancing:ap-northeast-1:660506286494:listener-rule/app/god-api/80cac4096e593f8c/70a04dd9e82a775c/5fb62cf111402076"
  "listener_arn": "arn:aws:elasticloadbalancing:ap-northeast-1:660506286494:listener/app/god-api/80cac4096e593f8c/70a04dd9e82a775c"
  "priority": 60
  "tags": {}
  "tags_all":
    "Env": "dev"
    "System": "gem-god-backend"
"aws_lb_listener_rule_red": []
"fqdns":
- "dev.god-api.gem-god-backend.com"
"public_subnets":
- "subnet-002e2412ebc222b85"
- "subnet-06e6fcd71e826019d"
- "subnet-0e9afcc69aba21ea1"
"red_god_api": []