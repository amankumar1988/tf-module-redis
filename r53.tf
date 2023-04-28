# This creates CNAME record for mongodb

# resource "aws_route53_record" "redis" {
#   zone_id = data.terraform_remote_state.vpc.outputs.PRIVATE_HOSTED_ZONE_ID
#   name    = "redis-${var.ENV}"
#   type    = "CNAME"
#   ttl     = 10
#   records = [aws_elasticache_cluster.redis]
# }

output "redis" {
    value = aws_elasticache_cluster.redis
}