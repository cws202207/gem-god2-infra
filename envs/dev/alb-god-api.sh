"alb":
- "bucket": "awslogs.s3.gem-god-backend.com.aws-alb-log"
  "enabled": true
  "prefix": "god-api"
"aws_lb_l":
  "access_logs":
  - "bucket": "awslogs.s3.gem-god-backend.com.aws-alb-log"
    "enabled": true
    "prefix": "god-api"
  "arn": "arn:aws:elasticloadbalancing:ap-northeast-1:660506286494:loadbalancer/app/god-api/ab81830e39e57b76"
  "arn_suffix": "app/god-api/ab81830e39e57b76"
  "customer_owned_ipv4_pool": ""
  "desync_mitigation_mode": "defensive"
  "dns_name": "god-api-1658213074.ap-northeast-1.elb.amazonaws.com"
  "drop_invalid_header_fields": false
  "enable_cross_zone_load_balancing": true
  "enable_deletion_protection": false
  "enable_http2": true
  "enable_waf_fail_open": false
  "id": "arn:aws:elasticloadbalancing:ap-northeast-1:660506286494:loadbalancer/app/god-api/ab81830e39e57b76"
  "idle_timeout": 60
  "internal": false
  "ip_address_type": "ipv4"
  "load_balancer_type": "application"
  "name": "god-api"
  "name_prefix": null
  "security_groups":
  - "sg-059606f11606ca933"
  "subnet_mapping":
  - "allocation_id": ""
    "ipv6_address": ""
    "outpost_id": ""
    "private_ipv4_address": ""
    "subnet_id": "subnet-028a47db573d94681"
  - "allocation_id": ""
    "ipv6_address": ""
    "outpost_id": ""
    "private_ipv4_address": ""
    "subnet_id": "subnet-09462c1e3f14683f1"
  - "allocation_id": ""
    "ipv6_address": ""
    "outpost_id": ""
    "private_ipv4_address": ""
    "subnet_id": "subnet-0ce6874bd9995d288"
  "subnets":
  - "subnet-028a47db573d94681"
  - "subnet-09462c1e3f14683f1"
  - "subnet-0ce6874bd9995d288"
  "tags": {}
  "tags_all":
    "Env": "dev"
    "System": "gem-god-backend"
  "timeouts": null
  "vpc_id": "vpc-0704c1da1ca29b738"
  "zone_id": "Z14GRHDCWA56QT"
"aws_lb_listener_rule_dest":
- "action":
  - "authenticate_cognito": []
    "authenticate_oidc": []
    "fixed_response": []
    "forward": []
    "order": 1
    "redirect": []
    "target_group_arn": "arn:aws:elasticloadbalancing:ap-northeast-1:660506286494:targetgroup/god-api-god-api/72ba582151946c05"
    "type": "forward"
  "arn": "arn:aws:elasticloadbalancing:ap-northeast-1:660506286494:listener-rule/app/god-api/ab81830e39e57b76/bce1b506e2820a23/bb3053ccb30b791f"
  "condition":
  - "host_header":
    - "values":
      - "dev.god-api.gem-god-backend.com"
    "http_header": []
    "http_request_method": []
    "path_pattern": []
    "query_string": []
    "source_ip": []
  "id": "arn:aws:elasticloadbalancing:ap-northeast-1:660506286494:listener-rule/app/god-api/ab81830e39e57b76/bce1b506e2820a23/bb3053ccb30b791f"
  "listener_arn": "arn:aws:elasticloadbalancing:ap-northeast-1:660506286494:listener/app/god-api/ab81830e39e57b76/bce1b506e2820a23"
  "priority": 60
  "tags": {}
  "tags_all":
    "Env": "dev"
    "System": "gem-god-backend"
"aws_lb_listener_rule_red": []
"fqdns":
- "dev.god-api.gem-god-backend.com"
"public_subnets":
- "subnet-028a47db573d94681"
- "subnet-09462c1e3f14683f1"
- "subnet-0ce6874bd9995d288"
"red_god_api": []
