terraform {
  required_version = ">= 0.13"
}

module "example" {
  source = "../../"

  description   = "Container Runtime Interface for OCI (CRI-O)"
  documentation = ["https://github.com/cri-o/cri-o"]

  wants = ["network-online.target"]
  after = ["network-online.target"]

  service_type = "notify"
  restart      = "on-abnormal"

  environment      = ["GOTRACEBACK=crash"]
  environment_file = ["-/etc/default/crio"]
  exec_start       = ["/usr/bin/crio $CRIO_CONFIG_OPTIONS $CRIO_RUNTIME_OPTIONS $CRIO_STORAGE_OPTIONS $CRIO_NETWORK_OPTIONS $CRIO_METRICS_OPTIONS"]
  exec_reload      = ["/bin/kill -s HUP $MAINPID"]

  tasks_max    = "infinity"
  limit_core   = "infinity"
  limit_nofile = "1048576"
  limit_nproc  = "1048576"

  oom_score_adjust = -999
}

# ```
# [Unit]
# Description=Container Runtime Interface for OCI (CRI-O)
# Documentation=https://github.com/cri-o/cri-o
# Wants=network-online.target
# After=network-online.target

# [Service]
# Type=notify
# Restart=on-abnormal
# ExecStart=/usr/bin/crio $CRIO_CONFIG_OPTIONS $CRIO_RUNTIME_OPTIONS $CRIO_STORAGE_OPTIONS $CRIO_NETWORK_OPTIONS $CRIO_METRICS_OPTIONS
# ExecReload=/bin/kill -s HUP $MAINPID
# Environment=GOTRACEBACK=crash
# EnvironmentFile=-/etc/default/crio
# LimitCORE=infinity
# LimitNOFILE=1048576
# LimitNPROC=1048576
# LimitRTTIME=infinity
# OOMScoreAdjust=-999
# TasksMax=infinity

# [Install]
# WantedBy=multi-user.target
# ```
