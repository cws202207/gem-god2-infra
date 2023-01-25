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
  "arn": "arn:aws:ec2:ap-northeast-1:660506286494:security-group/sg-03dbbf6f30b0c15ad"
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
  "id": "sg-03dbbf6f30b0c15ad"
  "ingress":
  - "cidr_blocks":
    - "172.33.51.97/32"
    "description": "god-hand"
    "from_port": 3306
    "ipv6_cidr_blocks": []
    "prefix_list_ids": []
    "protocol": "tcp"
    "security_groups": []
    "self": false
    "to_port": 3306
  - "cidr_blocks":
    - "172.33.62.110/32"
    "description": "god-api"
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
  "vpc_id": "vpc-0704c1da1ca29b738"
"backup_window": "18:09-19:09"
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
  "cluster_resource_id": "cluster-J3CI2NGYZFHLSKBNSRSMB37JUA"
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
  "master_password": "D}76O(+sjrG]C[{Ueyu3tU:N4tmlk}dq"
  "master_username": "site_info"
  "port": 3306
  "preferred_backup_window": "18:09-19:09"
  "preferred_maintenance_window": "sun:19:28-sun:19:58"
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
  - "sg-03dbbf6f30b0c15ad"
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
  "cluster_resource_id": "cluster-J3CI2NGYZFHLSKBNSRSMB37JUA"
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
  "master_password": "D}76O(+sjrG]C[{Ueyu3tU:N4tmlk}dq"
  "master_username": "site_info"
  "port": 3306
  "preferred_backup_window": "18:09-19:09"
  "preferred_maintenance_window": "sun:19:28-sun:19:58"
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
  - "sg-03dbbf6f30b0c15ad"
"master":
  "db": "master"
  "password": "Z5rq8<)Z4y}sVM=xObPs7o7t3LkV{<E8"
  "username": "master"
"master_password":
  "id": "Z5rq8<)Z4y}sVM=xObPs7o7t3LkV{<E8"
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
  "result": "Z5rq8<)Z4y}sVM=xObPs7o7t3LkV{<E8"
  "special": true
  "upper": true
"mysql_security_rule":
- "cidr_blocks":
  - "172.33.51.97/32"
  "description": "god-hand"
  "from_port": 3306
  "id": "sgrule-913610687"
  "ipv6_cidr_blocks": []
  "prefix_list_ids": []
  "protocol": "tcp"
  "security_group_id": "sg-03dbbf6f30b0c15ad"
  "self": false
  "source_security_group_id": null
  "to_port": 3306
  "type": "ingress"
- "cidr_blocks":
  - "172.33.54.134/32"
  "description": "god-api"
  "from_port": 3306
  "id": "sgrule-4022012497"
  "ipv6_cidr_blocks": null
  "prefix_list_ids": null
  "protocol": "tcp"
  "security_group_id": "sg-03dbbf6f30b0c15ad"
  "self": false
  "source_security_group_id": null
  "to_port": 3306
  "type": "ingress"
"permit_ip":
- "ip": "172.33.51.97"
  "name": "god-hand"
- "ip": "172.33.54.134"
  "name": "god-api"
"pertmit_ips":
- "ip": "172.33.51.97"
  "name": "god-hand"
- "ip": "172.33.54.134"
  "name": "god-api"
"port": 3306
"reader_endpoint": "site-info.cluster-ro-c7l3iefcvxks.ap-northeast-1.rds.amazonaws.com"
"site-info":
  "db": "site_info"
  "password": "D}76O(+sjrG]C[{Ueyu3tU:N4tmlk}dq"
  "username": "site_info"
"subnet_ids":
- "subnet-09462c1e3f14683f1"
- "subnet-028a47db573d94681"
- "subnet-0ce6874bd9995d288"
