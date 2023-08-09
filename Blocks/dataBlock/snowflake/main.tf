terraform { 
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.68"
    }
  }
}

data "snowflake_warehouses" "current" {}

provider "snowflake" {
  role = "SYSADMIN"
}

resource "snowflake_database" "db" {
  name = "TF_DEMO_DB"
}

resource "snowflake_warehouse" "warehouse" {
  name           = "TF_DEMO_WH"
  warehouse_size = "x-small"
  auto_suspend   = 60
}

resource "snowflake_warehouse" "warehouse_2" {
  name           = "TF_DEMO_WH_2"
  warehouse_size = "x-small"
  auto_suspend   = 60
}

locals{
  listOfNames = tolist([for v in data.snowflake_warehouses.current.warehouses : v.name])
}


resource "snowflake_user" "user" {
  name         = "Snowflake User"
  default_warehouse = "TF_DEMO_WH_2"

  lifecycle {
    precondition {
      condition     = contains(local.listOfNames, "TF_DEMO_WH_x")
      error_message = "The selected warehouse does not exist"
    }
  }
}