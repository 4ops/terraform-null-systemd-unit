terraform {
  required_version = ">= 0.13"
}

module "example" {
  source = "../../"

  description = "My service"
  exec_start = ["echo start"]
}
# ```
# [Unit]
# Description=My service
# After=network.target
#
# [Service]
# Type=simple
# Restart=on-failure
# ExecStart=echo start
#
# [Install]
# WantedBy=multi-user.target
# ```
