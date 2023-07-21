module "subnet_addrs" {
  source          = "hashicorp/subnets/cidr"
  version         = "1.0.0"
  base_cidr_block = "10.0.0.0/16"
  networks = [
    {
      name     = "network_1"
      new_bits = 8      # 10.0.0.0/24
    },
    {
      name     = "network_2"
      new_bits = 8      # 10.0.1.o/24
    },
  ]
}

output "subnet_addrs" {
  value = module.subnet_addrs.network_cidr_blocks
}