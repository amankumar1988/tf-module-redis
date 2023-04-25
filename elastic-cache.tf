resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "robot-${var.ENV}-redis"
  engine               = "redis"
  node_type            = "cache.t3.small"
  num_cache_nodes      = 1
  parameter_group_name = aws_elasticache_parameter_group.default.name
  engine_version       = "6.2"
  port                 = 6379

}

# Creates Parameter Group

resource "aws_elasticache_parameter_group" "default" {
  name    = "robot-${var.ENV}-redis-pg"
  family  = "redis6.2"
}


# Create Subnet Group

resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name       = "robot-${var.ENV}-dev-redis-subnet_group"
  subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS
}


# resource "aws_docdb_cluster" "docdb" {
#   cluster_identifier      = "robot-${var.ENV}-docdb"
#   engine                  = "docdb"
#   master_username         = "admin1"
#   master_password         = "roboshop1"
#   # backup_retention_period = 5       // Commenting this in lab we don't need it.
#   # preferred_backup_window = "07:00-09:00"
#   skip_final_snapshot     =   true
#   db_subnet_group_name    =  aws_docdb_subnet_group.docdb_sgbnet_group.name
#   vpc_security_group_ids  =  [aws_security_group.allow_mongodb.id]
# }

# # Create Subnet Group needed to host the docdb cluster

# resource "aws_docdb_subnet_group" "docdb_sgbnet_group" {
#   name       = "robot-${var.ENV}-docdb_sgbnet_group"
#   subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS
#   tags = {
#     Name = "robot-${var.ENV}-docdb-subnet-group"
#   }
# }

# # output "output_ref"{
# #   value = data.terraform_remote_state.vpc
# # }

# # Create instances needed for docdb cluster

# resource "aws_docdb_cluster_instance" "cluster_instances" {
#   count              = 1
#   identifier         = "robot-${var.ENV}-docdb-instance"
#   cluster_identifier = aws_docdb_cluster.docdb.id
#   instance_class     = "db.t3.medium"
# }