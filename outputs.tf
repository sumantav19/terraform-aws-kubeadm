output "kubeconfig" {
  value = local.kubeconfig_file
}

output "cluster_name" {
  value = local.cluster_name
}

output "cluster_nodes" {
  value = [
    for i in concat([aws_instance.master], aws_instance.workers, ) : {
      name       = i.tags["kubeadm:node"]
      subnet_id  = i.subnet_id
      private_ip = i.private_ip
      public_ip  = i.tags["kubeadm:node"] == "master" ? aws_eip.master.public_ip : i.public_ip
    }
  ]
}

output "vpc_id" {
  value       = aws_security_group.egress.vpc_id
  description = "The ID of the AWS VPC in which the cluster is running."
}
