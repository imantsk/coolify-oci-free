output "coolify_worker_ips" {
  value = [for instance in oci_core_instance.coolify_worker : "${instance.public_ip} (use it to add the server in Coolify Dashboard)"]
}
