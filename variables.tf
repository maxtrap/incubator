variable "name" {
	type = string
	description = "Lab name, used as a prefix for everything the lab creates"
}

variable "image" {
  type = string
  description = "Image alias or fingerprint to build the VMs from"


  # Reinstate when resolved: https://discuss.linuxcontainers.org/t/loud-vms-stuck-in-continuous-boot-loop/27287
  # default = "images:ubuntu/26.04/cloud"
  default = "ubuntu-26.04-lab"
}

variable "server_config" {
  type = map(string)
  description = "Optional path to user data for server VM"
  default = {}
}

variable "client_devices" {
  type = map(object({
    type = string
    properties = map(string)
  }))
  description = "Extra devices to attach to the client VM"
  default = {}
}
