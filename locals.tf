# Instance config
locals {
  boot_volume_min_gbs = 50
  
  boot_volume_base     = floor(var.always_free_block_storage_gbs / var.num_worker_instances)
  boot_volume_remainder = var.always_free_block_storage_gbs - (local.boot_volume_base * var.num_worker_instances)

  boot_volume_sizes = [
    for i in range(var.num_worker_instances) :
    max(local.boot_volume_min_gbs, local.boot_volume_base + (i < local.boot_volume_remainder ? 1 : 0))
  ]

  instance_config = {
    is_pv_encryption_in_transit_enabled = true
    ssh_authorized_keys                 = var.ssh_authorized_keys
    shape                               = var.instance_shape
    shape_config = {
      memory_in_gbs = var.memory_in_gbs
      ocpus         = var.ocpus
    }
    source_details = {
      source_id   = var.source_image_id
      source_type = "image"
    }
    availability_config = {
      recovery_action = "RESTORE_INSTANCE"
    }
    instance_options = {
      are_legacy_imds_endpoints_disabled = false
    }
  }
}
