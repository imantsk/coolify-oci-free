output "coolify_worker_1_ip" {
  value = "${oci_core_instance.coolify_worker_1.public_ip} (use it to add the server in Coolify Dashboard)"
}

output "coolify_worker_2_ip" {
  value = [for instance in oci_core_instance.coolify_worker_2 : "${oci_core_instance.coolify_worker_2.public_ip} (use it to add the server in Coolify Dashboard)"]
}
