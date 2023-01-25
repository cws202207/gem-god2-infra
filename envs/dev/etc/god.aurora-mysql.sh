"aurora":
  "availability_zones":
  - "ap-northeast-1a"
  - "ap-northeast-1c"
  - "ap-northeast-1d"
  "class": "db.t4g.medium"
"aws_rds_cluster_parameter_group":
  "arn": "arn:aws:rds:ap-northeast-1:660506286494:cluster-pg:god"
  "description": "Managed by Terraform"
  "family": "aurora-mysql8.0"
  "id": "god"
  "name": "god"
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
"aws_rds_cluster_parameter_group_name": "god"
"aws_security_group_rds":
  "arn": "arn:aws:ec2:ap-northeast-1:660506286494:security-group/sg-02282013dbc2ad3d9"
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
  "id": "sg-02282013dbc2ad3d9"
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
  "name": "god-DB-RDS"
  "name_prefix": ""
  "owner_id": "660506286494"
  "revoke_rules_on_delete": false
  "tags":
    "Name": "DB-RDS"
  "tags_all":
    "Env": "dev"
    "Name": "DB-RDS"
    "System": "gem-god-backend"
  "timeouts": null
  "vpc_id": "vpc-0704c1da1ca29b738"
"backup_window": "18:08-19:08"
"cluster":
  "allow_major_version_upgrade": null
  "apply_immediately": true
  "arn": "arn:aws:rds:ap-northeast-1:660506286494:cluster:god"
  "availability_zones":
  - "ap-northeast-1a"
  - "ap-northeast-1c"
  - "ap-northeast-1d"
  "backtrack_window": 0
  "backup_retention_period": 5
  "cluster_identifier": "god"
  "cluster_identifier_prefix": null
  "cluster_members":
  - "god-i0"
  "cluster_resource_id": "cluster-EHMJYU5MJHUNIZFQGNCSLDE3OM"
  "copy_tags_to_snapshot": false
  "database_name": "god"
  "db_cluster_parameter_group_name": "god"
  "db_instance_parameter_group_name": null
  "db_subnet_group_name": "god-private"
  "deletion_protection": false
  "enable_global_write_forwarding": false
  "enable_http_endpoint": false
  "enabled_cloudwatch_logs_exports": []
  "endpoint": "god.cluster-c7l3iefcvxks.ap-northeast-1.rds.amazonaws.com"
  "engine": "aurora-mysql"
  "engine_mode": "provisioned"
  "engine_version": "8.0.mysql_aurora.3.02.0"
  "engine_version_actual": "8.0.mysql_aurora.3.02.0"
  "final_snapshot_identifier": null
  "global_cluster_identifier": ""
  "hosted_zone_id": "Z24O6O9L7SGTNB"
  "iam_database_authentication_enabled": false
  "iam_roles": []
  "id": "god"
  "kms_key_id": ""
  "master_password": "TwC=lo+n[B-j>b9_-b4J9Q_gdzVHAY0e"
  "master_username": "god"
  "port": 3306
  "preferred_backup_window": "18:08-19:08"
  "preferred_maintenance_window": "fri:15:21-fri:15:51"
  "reader_endpoint": "god.cluster-ro-c7l3iefcvxks.ap-northeast-1.rds.amazonaws.com"
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
  - "sg-02282013dbc2ad3d9"
"endpoint": "god.cluster-c7l3iefcvxks.ap-northeast-1.rds.amazonaws.com"
"god":
  "db": "god"
  "password": "TwC=lo+n[B-j>b9_-b4J9Q_gdzVHAY0e"
  "username": "god"
"instance":
  "allow_major_version_upgrade": null
  "apply_immediately": true
  "arn": "arn:aws:rds:ap-northeast-1:660506286494:cluster:god"
  "availability_zones":
  - "ap-northeast-1a"
  - "ap-northeast-1c"
  - "ap-northeast-1d"
  "backtrack_window": 0
  "backup_retention_period": 5
  "cluster_identifier": "god"
  "cluster_identifier_prefix": null
  "cluster_members":
  - "god-i0"
  "cluster_resource_id": "cluster-EHMJYU5MJHUNIZFQGNCSLDE3OM"
  "copy_tags_to_snapshot": false
  "database_name": "god"
  "db_cluster_parameter_group_name": "god"
  "db_instance_parameter_group_name": null
  "db_subnet_group_name": "god-private"
  "deletion_protection": false
  "enable_global_write_forwarding": false
  "enable_http_endpoint": false
  "enabled_cloudwatch_logs_exports": []
  "endpoint": "god.cluster-c7l3iefcvxks.ap-northeast-1.rds.amazonaws.com"
  "engine": "aurora-mysql"
  "engine_mode": "provisioned"
  "engine_version": "8.0.mysql_aurora.3.02.0"
  "engine_version_actual": "8.0.mysql_aurora.3.02.0"
  "final_snapshot_identifier": null
  "global_cluster_identifier": ""
  "hosted_zone_id": "Z24O6O9L7SGTNB"
  "iam_database_authentication_enabled": false
  "iam_roles": []
  "id": "god"
  "kms_key_id": ""
  "master_password": "TwC=lo+n[B-j>b9_-b4J9Q_gdzVHAY0e"
  "master_username": "god"
  "port": 3306
  "preferred_backup_window": "18:08-19:08"
  "preferred_maintenance_window": "fri:15:21-fri:15:51"
  "reader_endpoint": "god.cluster-ro-c7l3iefcvxks.ap-northeast-1.rds.amazonaws.com"
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
  - "sg-02282013dbc2ad3d9"
"master":
  "db": "master"
  "password": "onx{ss6JhtN(cS:oBKa]!-lMYX=-]Q7Z"
  "username": "master"
"master_password":
  "id": "onx{ss6JhtN(cS:oBKa]!-lMYX=-]Q7Z"
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
  "result": "onx{ss6JhtN(cS:oBKa]!-lMYX=-]Q7Z"
  "special": true
  "upper": true
"mysql_security_rule":
- "cidr_blocks":
  - "172.33.54.134/32"
  "description": "god-api"
  "from_port": 3306
  "id": "sgrule-1436079707"
  "ipv6_cidr_blocks": null
  "prefix_list_ids": null
  "protocol": "tcp"
  "security_group_id": "sg-02282013dbc2ad3d9"
  "self": false
  "source_security_group_id": null
  "to_port": 3306
  "type": "ingress"
- "cidr_blocks":
  - "172.33.51.97/32"
  "description": "god-hand"
  "from_port": 3306
  "id": "sgrule-3315505227"
  "ipv6_cidr_blocks": []
  "prefix_list_ids": []
  "protocol": "tcp"
  "security_group_id": "sg-02282013dbc2ad3d9"
  "self": false
  "source_security_group_id": null
  "to_port": 3306
  "type": "ingress"
"permit_ip":
- "ip": "172.33.54.134"
  "name": "god-api"
- "ip": "172.33.51.97"
  "name": "god-hand"
"pertmit_ips":
- "ip": "172.33.54.134"
  "name": "god-api"
- "ip": "172.33.51.97"
  "name": "god-hand"
"port": 3306
"reader_endpoint": "god.cluster-ro-c7l3iefcvxks.ap-northeast-1.rds.amazonaws.com"
"subnet_ids":
- "subnet-09462c1e3f14683f1"
- "subnet-028a47db573d94681"
- "subnet-0ce6874bd9995d288"
