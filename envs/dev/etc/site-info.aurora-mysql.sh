"aurora":
  "availability_zones":
  - "ap-northeast-1a"
  - "ap-northeast-1c"
  - "ap-northeast-1d"
  "class": "db.t4g.medium"
"aws_rds_cluster_parameter_group":
  "arn": "arn:aws:rds:ap-northeast-1:660506286494:cluster-pg:site-info"
  "description": "Managed by Terraform"
  "family": "aurora-mysql8.0"
  "id": "site-info"
  "name": "site-info"
  "name_prefix": null
  "parameter":
  - "apply_method": "immediate"
    "name": "character_set_client"
    "value": "utf8mb4"
  - "apply_method": "immediate"
    "name": "character_set_connection"
    "value": "utf8mb4"
  - "apply_method": "immediate"
    "name": "character_set_database"
    "value": "utf8mb4"
  - "apply_method": "immediate"
    "name": "character_set_filesystem"
    "value": "utf8mb4"
  - "apply_method": "immediate"
    "name": "character_set_results"
    "value": "utf8mb4"
  - "apply_method": "immediate"
    "name": "character_set_server"
    "value": "utf8mb4"
  - "apply_method": "immediate"
    "name": "collation_server"
    "value": "utf8mb4_general_ci"
  - "apply_method": "immediate"
    "name": "time_zone"
    "value": "Asia/Tokyo"
  "tags": {}
  "tags_all":
    "Env": "dev"
    "System": "gem-god-backend"
"aws_rds_cluster_parameter_group_name": "site-info"
"aws_security_group_rds":
  "arn": "arn:aws:ec2:ap-northeast-1:660506286494:security-group/sg-0600de263f4af3d97"
  "description": "managed by terraform"
  "egress":
  - "cidr_blocks":
    - "0.0.0.0/0"
    "description": ""
    "from_port": 0
    "ipv6_cidr_blocks": []
    "prefix_list_ids": []
    "protocol": "-1"
    "security_groups": []
    "self": false
    "to_port": 0
  "id": "sg-0600de263f4af3d97"
  "ingress":
  - "cidr_blocks":
    - "172.33.48.187/32"
    "description": "god-api"
    "from_port": 3306
    "ipv6_cidr_blocks": []
    "prefix_list_ids": []
    "protocol": "tcp"
    "security_groups": []
    "self": false
    "to_port": 3306
  - "cidr_blocks":
    - "172.33.55.102/32"
    "description": "god-hand"
    "from_port": 3306
    "ipv6_cidr_blocks": []
    "prefix_list_ids": []
    "protocol": "tcp"
    "security_groups": []
    "self": false
    "to_port": 3306
  "name": "site-info-DB-RDS"
  "name_prefix": ""
  "owner_id": "660506286494"
  "revoke_rules_on_delete": false
  "tags":
    "Name": "site-info-DB-RDS"
  "tags_all":
    "Env": "dev"
    "Name": "site-info-DB-RDS"
    "System": "gem-god-backend"
  "timeouts": null
  "vpc_id": "vpc-0c057902533c73daa"
"backup_window": "18:22-19:22"
"cluster":
  "allow_major_version_upgrade": null
  "apply_immediately": true
  "arn": "arn:aws:rds:ap-northeast-1:660506286494:cluster:site-info"
  "availability_zones":
  - "ap-northeast-1a"
  - "ap-northeast-1c"
  - "ap-northeast-1d"
  "backtrack_window": 0
  "backup_retention_period": 5
  "cluster_identifier": "site-info"
  "cluster_identifier_prefix": null
  "cluster_members":
  - "site-info-i0"
  "cluster_resource_id": "cluster-EK32LJP2LLT4B3YBYI56HIMSA4"
  "copy_tags_to_snapshot": false
  "database_name": "site_info"
  "db_cluster_parameter_group_name": "site-info"
  "db_instance_parameter_group_name": null
  "db_subnet_group_name": "site-info-private"
  "deletion_protection": false
  "enable_global_write_forwarding": false
  "enable_http_endpoint": false
  "enabled_cloudwatch_logs_exports": []
  "endpoint": "site-info.cluster-c7l3iefcvxks.ap-northeast-1.rds.amazonaws.com"
  "engine": "aurora-mysql"
  "engine_mode": "provisioned"
  "engine_version": "8.0.mysql_aurora.3.02.0"
  "engine_version_actual": "8.0.mysql_aurora.3.02.0"
  "final_snapshot_identifier": null
  "global_cluster_identifier": ""
  "hosted_zone_id": "Z24O6O9L7SGTNB"
  "iam_database_authentication_enabled": false
  "iam_roles": []
  "id": "site-info"
  "kms_key_id": ""
  "master_password": "E+Peb7]u[6R>e2VF0*g<WpnXCwsz<Hdy"
  "master_username": "site_info"
  "port": 3306
  "preferred_backup_window": "18:22-19:22"
  "preferred_maintenance_window": "sat:15:07-sat:15:37"
  "reader_endpoint": "site-info.cluster-ro-c7l3iefcvxks.ap-northeast-1.rds.amazonaws.com"
  "replication_source_identifier": ""
  "restore_to_point_in_time": []
  "s3_import": []
  "scaling_configuration": []
  "skip_final_snapshot": true
  "snapshot_identifier": null
  "source_region": null
  "storage_encrypted": false
  "tags": {}
  "tags_all":
    "Env": "dev"
    "System": "gem-god-backend"
  "timeouts": null
  "vpc_security_group_ids":
  - "sg-0600de263f4af3d97"
"endpoint": "site-info.cluster-c7l3iefcvxks.ap-northeast-1.rds.amazonaws.com"
"instance":
  "allow_major_version_upgrade": null
  "apply_immediately": true
  "arn": "arn:aws:rds:ap-northeast-1:660506286494:cluster:site-info"
  "availability_zones":
  - "ap-northeast-1a"
  - "ap-northeast-1c"
  - "ap-northeast-1d"
  "backtrack_window": 0
  "backup_retention_period": 5
  "cluster_identifier": "site-info"
  "cluster_identifier_prefix": null
  "cluster_members":
  - "site-info-i0"
  "cluster_resource_id": "cluster-EK32LJP2LLT4B3YBYI56HIMSA4"
  "copy_tags_to_snapshot": false
  "database_name": "site_info"
  "db_cluster_parameter_group_name": "site-info"
  "db_instance_parameter_group_name": null
  "db_subnet_group_name": "site-info-private"
  "deletion_protection": false
  "enable_global_write_forwarding": false
  "enable_http_endpoint": false
  "enabled_cloudwatch_logs_exports": []
  "endpoint": "site-info.cluster-c7l3iefcvxks.ap-northeast-1.rds.amazonaws.com"
  "engine": "aurora-mysql"
  "engine_mode": "provisioned"
  "engine_version": "8.0.mysql_aurora.3.02.0"
  "engine_version_actual": "8.0.mysql_aurora.3.02.0"
  "final_snapshot_identifier": null
  "global_cluster_identifier": ""
  "hosted_zone_id": "Z24O6O9L7SGTNB"
  "iam_database_authentication_enabled": false
  "iam_roles": []
  "id": "site-info"
  "kms_key_id": ""
  "master_password": "E+Peb7]u[6R>e2VF0*g<WpnXCwsz<Hdy"
  "master_username": "site_info"
  "port": 3306
  "preferred_backup_window": "18:22-19:22"
  "preferred_maintenance_window": "sat:15:07-sat:15:37"
  "reader_endpoint": "site-info.cluster-ro-c7l3iefcvxks.ap-northeast-1.rds.amazonaws.com"
  "replication_source_identifier": ""
  "restore_to_point_in_time": []
  "s3_import": []
  "scaling_configuration": []
  "skip_final_snapshot": true
  "snapshot_identifier": null
  "source_region": null
  "storage_encrypted": false
  "tags": {}
  "tags_all":
    "Env": "dev"
    "System": "gem-god-backend"
  "timeouts": null
  "vpc_security_group_ids":
  - "sg-0600de263f4af3d97"
"master":
  "db": "master"
  "password": "<lHqY8r!J>Tu1_xpGuVeVRs6vxP!ZXX3"
  "username": "master"
"master_password":
  "id": "<lHqY8r!J>Tu1_xpGuVeVRs6vxP!ZXX3"
  "keepers": null
  "length": 32
  "lower": true
  "min_lower": 0
  "min_numeric": 0
  "min_special": 0
  "min_upper": 0
  "number": true
  "numeric": true
  "override_special": "!*()-_=+[]{}<>:"
  "result": "<lHqY8r!J>Tu1_xpGuVeVRs6vxP!ZXX3"
  "special": true
  "upper": true
"mysql_security_rule":
- "cidr_blocks":
  - "172.33.55.102/32"
  "description": "god-hand"
  "from_port": 3306
  "id": "sgrule-2371764636"
  "ipv6_cidr_blocks": []
  "prefix_list_ids": []
  "protocol": "tcp"
  "security_group_id": "sg-0600de263f4af3d97"
  "self": false
  "source_security_group_id": null
  "to_port": 3306
  "type": "ingress"
- "cidr_blocks":
  - "172.33.48.187/32"
  "description": "god-api"
  "from_port": 3306
  "id": "sgrule-3076571368"
  "ipv6_cidr_blocks": []
  "prefix_list_ids": []
  "protocol": "tcp"
  "security_group_id": "sg-0600de263f4af3d97"
  "self": false
  "source_security_group_id": null
  "to_port": 3306
  "type": "ingress"
"permit_ip":
- "ip": "172.33.55.102"
  "name": "god-hand"
- "ip": "172.33.48.187"
  "name": "god-api"
"pertmit_ips":
- "ip": "172.33.55.102"
  "name": "god-hand"
- "ip": "172.33.48.187"
  "name": "god-api"
"port": 3306
"reader_endpoint": "site-info.cluster-ro-c7l3iefcvxks.ap-northeast-1.rds.amazonaws.com"
"site-info":
  "db": "site_info"
  "password": "E+Peb7]u[6R>e2VF0*g<WpnXCwsz<Hdy"
  "username": "site_info"
"subnet_ids":
- "subnet-0e9afcc69aba21ea1"
- "subnet-06e6fcd71e826019d"
- "subnet-002e2412ebc222b85"
