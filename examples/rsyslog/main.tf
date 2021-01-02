terraform {
  required_version = ">= 0.13"
}

module "example" {
  source = "../../"

  description = "System Logging Service"

  documentation = [
    "man:rsyslogd(8)",
    "https://www.rsyslog.com/doc/",
  ]

  after = []

  aliases    = ["syslog.service"]
  requires   = ["syslog.socket"]
  exec_start = ["/usr/sbin/rsyslogd -n -iNONE"]

  standard_output = "null"
  limit_nofile    = "16384"
}

# ```
# [Unit]
# Description=System Logging Service
# Documentation=man:rsyslogd(8)
# Documentation=https://www.rsyslog.com/doc/
# Requires=syslog.socket
#
# [Service]
# Type=simple
# Restart=on-failure
# ExecStart=/usr/sbin/rsyslogd -n -iNONE
# StandardOutput=null
# LimitNOFILE=16384
#
# [Install]
# WantedBy=multi-user.target
# Alias=syslog.service
# ```
