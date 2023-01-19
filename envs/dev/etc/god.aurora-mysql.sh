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
  "arn": "arn:aws:ec2:ap-northeast-1:660506286494:security-group/sg-0bda51e44b62a8687"
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
  "id": "sg-0bda51e44b62a8687"
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
  "vpc_id": "vpc-0c057902533c73daa"
"backup_window": "18:42-19:42"
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
  "cluster_resource_id": "cluster-WUTA2LMBGRTI6LEFYJSJP24VUQ"
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
  "master_password": ":>QpP0{Zil+XN>dUTOLsX8rt=43zGTgy"
  "master_username": "god"
  "port": 3306
  "preferred_backup_window": "18:42-19:42"
  "preferred_maintenance_window": "fri:20:18-fri:20:48"
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
  - "sg-0bda51e44b62a8687"
"endpoint": "god.cluster-c7l3iefcvxks.ap-northeast-1.rds.amazonaws.com"
"god":
  "db": "god"
  "password": ":>QpP0{Zil+XN>dUTOLsX8rt=43zGTgy"
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
  "cluster_resource_id": "cluster-WUTA2LMBGRTI6LEFYJSJP24VUQ"
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
  "master_password": ":>QpP0{Zil+XN>dUTOLsX8rt=43zGTgy"
  "master_username": "god"
  "port": 3306
  "preferred_backup_window": "18:42-19:42"
  "preferred_maintenance_window": "fri:20:18-fri:20:48"
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
  - "sg-0bda51e44b62a8687"
"master":
  "db": "master"
  "password": "[LsqF)Mr-tEDBG}<p4huAOueZuPl0B(O"
  "username": "master"
"master_password":
  "id": "[LsqF)Mr-tEDBG}<p4huAOueZuPl0B(O"
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
  "result": "[LsqF)Mr-tEDBG}<p4huAOueZuPl0B(O"
  "special": true
  "upper": true
"mysql_security_rule":
- "cidr_blocks":
  - "172.33.48.187/32"
  "description": "god-api"
  "from_port": 3306
  "id": "sgrule-428160338"
  "ipv6_cidr_blocks": []
  "prefix_list_ids": []
  "protocol": "tcp"
  "security_group_id": "sg-0bda51e44b62a8687"
  "self": false
  "source_security_group_id": null
  "to_port": 3306
  "type": "ingress"
- "cidr_blocks":
  - "172.33.55.102/32"
  "description": "god-hand"
  "from_port": 3306
  "id": "sgrule-599503910"
  "ipv6_cidr_blocks": []
  "prefix_list_ids": []
  "protocol": "tcp"
  "security_group_id": "sg-0bda51e44b62a8687"
  "self": false
  "source_security_group_id": null
  "to_port": 3306
  "type": "ingress"
"permit_ip":
- "ip": "172.33.48.187"
  "name": "god-api"
- "ip": "172.33.55.102"
  "name": "god-hand"
"pertmit_ips":
- "ip": "172.33.48.187"
  "name": "god-api"
- "ip": "172.33.55.102"
  "name": "god-hand"
"port": 3306
"reader_endpoint": "god.cluster-ro-c7l3iefcvxks.ap-northeast-1.rds.amazonaws.com"
"subnet_ids":
- "subnet-0e9afcc69aba21ea1"
- "subnet-06e6fcd71e826019d"
- "subnet-002e2412ebc222b85"
