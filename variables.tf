variable "description" {
  type    = string
  default = ""

  description = <<-DESC
  A human readable name for the unit.
  This is used by systemd (and other UIs) as the label for the unit,
  so this string should identify the unit rather than describe it, despite the name.
  'Apache2 Web Server' is a good example.
  DESC
}

variable "documentation" {
  type    = list(string)
  default = []

  validation {
    condition = [
      for src in var.documentation : src
      if
      contains([
        "http",
        "https",
        "file",
        "info",
        "man"
        ], element(split(":", src), 0)
      ) == false
    ] == []

    error_message = "Accepted are only URIs of the types 'http://', 'https://', 'file:', 'info:', 'man:'."
  }

  description = <<-DESC
  A list of URIs referencing documentation for this unit or its configuration.
  Accepted are only URIs of the types "http://", "https://", "file:", "info:", "man:".
  DESC
}

variable "wants" {
  type    = list(string)
  default = []

  description = "Configures requirement dependencies on other units."
}

variable "requires" {
  type    = list(string)
  default = []

  description = "Similar to `wants`, but declares a stronger dependency."
}

variable "before" {
  type    = list(string)
  default = []

  description = "Ensures that the configured unit is started before the listed unit begins starting up."
}

variable "after" {
  type    = list(string)
  default = ["network.target"]

  description = "Ensures the opposite, that the listed unit is fully started up before the configured unit is started."
}

variable "conflicts" {
  type    = list(string)
  default = []

  description = <<-DESC
  Configures negative requirement dependencies.
  If a unit has a `conflicts` setting on another unit, starting the former will stop the latter and vice versa.
  DESC
}

variable "on_failure" {
  type    = list(string)
  default = []

  description = "List of one or more units that are activated when this unit enters the 'failed' state."
}

variable "propagates_reload_to" {
  type    = list(string)
  default = []

  description = "List of one or more units where reload requests on this unit will be propagated to this unit."
}

variable "reload_propagated_from" {
  type    = list(string)
  default = []

  description = "List of one or more units where reload requests on the other unit will be propagated to this unit."
}

variable "default_dependencies" {
  type    = bool
  default = true

  description = "If `true`, a few default dependencies will implicitly be created for the unit. The actual dependencies created depend on the unit type."
}

variable "condition_architecture" {
  type    = string
  default = ""

  validation {
    condition = var.condition_architecture == "" || contains([
      "x86",
      "x86-64",
      "ppc",
      "ppc-le",
      "ppc64",
      "ppc64-le",
      "ia64",
      "parisc",
      "parisc64",
      "s390",
      "s390x",
      "sparc",
      "sparc64",
      "mips",
      "mips-le",
      "mips64",
      "mips64-le",
      "alpha",
      "arm",
      "arm-be",
      "arm64",
      "arm64-be",
      "sh",
      "sh64",
      "m68k",
      "tilegx",
      "cris",
      "arc",
      "arc-be",
      "native",
    ], var.condition_architecture)

    error_message = "Value must contains valid architecture name."
  }

  description = "Check whether the system is running on a specific architecture."
}

variable "condition_virtualization" {
  type    = string
  default = ""

  validation {
    condition = var.condition_virtualization == "" || contains([
      "qemu",
      "kvm",
      "zvm",
      "vmware",
      "microsoft",
      "oracle",
      "powervm",
      "xen",
      "bochs",
      "uml",
      "bhyve",
      "qnx",
      "openvz",
      "lxc",
      "lxc-libvirt",
      "systemd-nspawn",
      "docker",
      "podman",
      "rkt",
      "wsl",
      "proot",
      "pouch",
      "acrn",
    ], var.condition_virtualization)

    error_message = "Value must contains valid virtualization name."
  }

  description = "Check whether the system is executed in a virtualized environment and optionally test whether it is a specific implementation."
}

variable "condition_first_boot" {
  type    = bool
  default = false

  description = "This condition may be used to conditionalize units on whether the system is booting up for the first time."
}

variable "condition_ac_power" {
  type    = bool
  default = false

  description = "This condition may be used to conditionalize units on whether the system is booting up for the first time."
}

variable "condition_path_exists" {
  type    = list(string)
  default = []

  description = <<-DESC
  Check for the exists of a file.
  If the specified absolute path name does not exist, the condition will fail.
  If the absolute path name passed to condition is prefixed with an exclamation mark ("!"),
  the test is negated, and the unit is only started if the path does not exist.
  DESC
}

variable "condition_path_is_directory" {
  type    = list(string)
  default = []

  description = "Similar to `condition_path_exists` but verifies that a certain path exists and is a directory."
}

variable "condition_path_is_symbolic_link" {
  type    = list(string)
  default = []

  description = "Similar to `condition_path_exists` but verifies that a certain path exists and is a symbolic link."
}

variable "condition_path_is_mount_point" {
  type    = list(string)
  default = []

  description = "Similar to `condition_path_exists` but verifies that a certain path exists and is a mount point."
}

variable "condition_path_is_read_write" {
  type    = list(string)
  default = []

  description = "Similar to `condition_path_exists` but verifies that the underlying file system is readable and writable (i.e. not mounted read-only)."
}

variable "condition_directory_not_empty" {
  type    = list(string)
  default = []

  description = "Similar to `condition_path_exists` but verifies that a certain path exists and is a non-empty directory."
}

variable "condition_file_not_empty" {
  type    = list(string)
  default = []

  description = "Similar to `condition_path_exists` but verifies that a certain path exists and refers to a regular file with a non-zero size."
}

variable "condition_file_is_executable" {
  type    = list(string)
  default = []

  description = "Similar to `condition_path_exists` but verifies that a certain path exists, is a regular file, and marked executable."
}

variable "condition_memory" {
  type    = string
  default = ""

  description = <<-DESC
  Verify that the specified amount of system memory is available to the current system.
  Takes a memory size in bytes as argument, optionally prefixed with a comparison operator "<", "<=", "=", "!=", ">=", ">".
  On bare-metal systems compares the amount of physical memory in the system with the specified size,
  adhering to the specified comparison operator. In containers compares the amount of memory assigned to the container instead.
  DESC
}

variable "condition_cpus" {
  type    = string
  default = ""

  description = <<-DESC
  Verify that the specified number of CPUs is available to the current system.
  Takes a number of CPUs as argument, optionally prefixed with a comparison operator "<", "<=", "=", "!=", ">=", ">".
  Compares the number of CPUs in the CPU affinity mask configured of the service manager itself with the specified number,
  adhering to the specified comparison operator. On physical systems the number of CPUs in the affinity mask of the service manager
  usually matches the number of physical CPUs, but in special and virtual environments might differ.
  In particular, in containers the affinity mask usually matches the number of CPUs assigned to the container and not the physically available ones.
  DESC
}

# --- Install

variable "wanted_by" {
  type    = list(string)
  default = ["multi-user.target"]
}

variable "required_by" {
  type    = list(string)
  default = []
}

variable "aliases" {
  type    = list(string)
  default = []

  description = "Service unit aliases."
}

variable "also" {
  type    = list(string)
  default = []
}

# --- Service

variable "user" {
  type    = string
  default = ""
}

variable "group" {
  type    = string
  default = ""
}

variable "service_type" {
  type    = string
  default = "simple"

  validation {
    condition     = contains(["notify", "exec", "simple", "forking", "oneshot", "dbus", "idle"], var.service_type)
    error_message = "Service type must be one of: `notify`, `exec`, `simple`, `forking`, `oneshot`, `dbus`, `idle`."
  }
}

variable "remain_after_exit" {
  type    = bool
  default = false
}

variable "bus_name" {
  type    = string
  default = ""
}

variable "notify_access" {
  type    = string
  default = ""

  validation {
    condition     = var.notify_access == "" || contains(["none", "main", "all"], var.notify_access)
    error_message = "Notify access must be one of: `nono`, `main`, `all`."
  }
}

variable "restart" {
  type    = string
  default = "on-failure"

  validation {
    condition = contains([
      "no",
      "always",
      "on-success",
      "on-failure",
      "on-abnormal",
      "on-abort",
      "on-watchdog",
    ], var.restart)

    error_message = "Restart must be one of `no`, `always`, `on-success`, `on-failure`, `on-abnormal`, `on-abort`, `on-watchdog`."
  }

  description = "Configures whether the service shall be restarted when the service process exits, is killed, or a timeout is reached."
}

variable "watchdog_sec" {
  type    = number
  default = 0
}

variable "restart_sec" {
  type    = number
  default = 0
}

variable "nice" {
  type    = number
  default = 0

  validation {
    condition     = var.nice >= -20 && var.nice <= 19
    error_message = "Nice must be an integer value in range -20...19."
  }
}

variable "private_tmp" {
  type    = bool
  default = false

  description = <<-DESC
  If `true`, sets up a new file system namespace for the executed processes and mounts
  private `/tmp` and `/var/tmp` directories inside it that are not shared by processes outside of the namespace.
  DESC
}

variable "protect_system" {
  type    = string
  default = ""

  validation {
    condition     = var.protect_system == "" || contains(["true", "strict", "full"], var.protect_system)
    error_message = "Value must be one of `true`, `strict`, `full`."
  }

  description = <<-DESC
  If `true`, mounts the `/usr` and the boot loader directories (`/boot` and `/efi`) read-only for processes invoked by this unit.
  If set to `full`, the `/etc` directory is mounted read-only, too.
  If set to `strict` the entire file system hierarchy is mounted read-only, except for the API file system subtrees `/dev`, `/proc` and `/sys`.
  DESC
}

variable "protect_home" {
  type    = string
  default = ""

  validation {
    condition     = var.protect_home == "" || contains(["true", "read-only", "tmpfs"], var.protect_home)
    error_message = "Value must be one of `true`, `read-only`, `tmpfs`."
  }

  description = <<-DESC
  If `true`, the directories `/home`, `/root`, and `/run/user` are made inaccessible and empty for processes invoked by this unit.
  If set to `read-only`, the three directories are made read-only instead.
  If set to `tmpfs`, temporary file systems are mounted on the three directories in read-only mode.
  DESC
}

variable "exec_start_pre" {
  type    = list(string)
  default = []
}

variable "exec_start_post" {
  type    = list(string)
  default = []
}

variable "exec_start" {
  type    = list(string)
  default = []
}

variable "exec_stop" {
  type    = list(string)
  default = []
}

variable "exec_stop_post" {
  type    = list(string)
  default = []
}

variable "exec_reload" {
  type    = list(string)
  default = []
}

variable "pid_file" {
  type    = string
  default = ""

  description = "Path to PID file."
}

variable "working_directory" {
  type    = list(string)
  default = []

  description = "Working directory path."
}

variable "runtime_directory" {
  type    = list(string)
  default = []

  description = "Runtime directory path."
}

variable "state_directory" {
  type    = list(string)
  default = []

  description = "State directory path."
}

variable "cache_directory" {
  type    = list(string)
  default = []

  description = "Cache directory path."
}

variable "logs_directory" {
  type    = list(string)
  default = []

  description = "Logs directory path."
}

variable "configuration_directory" {
  type    = list(string)
  default = []

  description = "Configuration directory path."
}

variable "runtime_directory_preserve" {
  type    = string
  default = ""

  validation {
    condition     = var.runtime_directory_preserve == "" || contains(["no", "restart", "yes"], var.runtime_directory_preserve)
    error_message = "Value must be one of `no`, `restart`, `yes`."
  }

  description = <<-DESC
  If set to `no`, the directories specified in runtime_directory are always removed when the service stops.
  If set to `restart` the directories are preserved when the service is both automatically and manually restarted.
  If set to `yes`, then the directories are not removed when the service is stopped.
  DESC
}

variable "standard_output" {
  type    = string
  default = ""

  description = <<-DESC
  Controls where file descriptor 1 (stdout) of the executed processes is connected to.
  Takes one of `inherit`, `null`, `tty`, `journal`, `kmsg`, `journal+console`, `kmsg+console`, `file:path`, `append:path`, `socket` or `fd:name`.
  DESC
}

variable "standard_input" {
  type    = string
  default = ""

  description = <<-DESC
  Controls where file descriptor 0 (STDIN) of the executed processes is connected to.
  Takes one of `null`, `tty`, `tty-force`, `tty-fail`, `data`, `file:path`, `socket` or `fd:name`.
  DESC
}

variable "sockets" {
  type    = list(string)
  default = []

  description = "Working directory path."
}

variable "permissions_start_only" {
  type    = bool
  default = false

  description = "Permissions start only."
}

variable "no_new_privileges" {
  type    = bool
  default = false

  description = "If `true`, ensures that the service process and all its children can never gain new privileges through execve()."
}

variable "ignore_sigpipe" {
  type    = bool
  default = false

  description = "Ignore SIGPIPE."
}

variable "kill_mode" {
  type    = string
  default = ""

  validation {
    condition     = var.kill_mode == "" || contains(["control-group", "mixed", "process", "none"], var.kill_mode)
    error_message = "Kill mode must be one of `control-group`, `mixed`, `process`, `none`."
  }

  description = "Specifies how processes of this unit shall be killed. One of control-group, mixed, process, none."
}

variable "kill_signal" {
  type    = string
  default = ""

  validation {
    condition     = var.kill_signal == "" || contains(["SIGKILL", "SIGQUIT", "SIGABRT", "SIGTERM", "SIGHUP", "SIGUSR1"], var.kill_signal)
    error_message = "Signal must be one of `SIGKILL`, `SIGQUIT`, `SIGABRT`, `SIGTERM`, `SIGHUP`, `SIGUSR1`."
  }

  description = <<-DESC
  Specifies which signal to use when stopping a service.
  This controls the signal that is sent as first step of shutting down a unit, and is usually followed by `SIGKILL`."
  DESC
}

variable "restart_kill_signal" {
  type    = string
  default = ""

  validation {
    condition     = var.restart_kill_signal == "" || contains(["SIGKILL", "SIGQUIT", "SIGABRT", "SIGTERM", "SIGHUP", "SIGUSR1"], var.restart_kill_signal)
    error_message = "Signal must be one of `SIGKILL`, `SIGQUIT`, `SIGABRT`, `SIGTERM`, `SIGHUP`, `SIGUSR1`."
  }

  description = "Specifies which signal to use when restarting a service."
}

variable "watchdog_signal" {
  type    = string
  default = ""

  validation {
    condition     = var.watchdog_signal == "" || contains(["SIGKILL", "SIGQUIT", "SIGABRT", "SIGTERM", "SIGHUP", "SIGUSR1"], var.watchdog_signal)
    error_message = "Signal must be one of `SIGKILL`, `SIGQUIT`, `SIGABRT`, `SIGTERM`, `SIGHUP`, `SIGUSR1`."
  }

  description = "Specifies which signal to use to terminate the service when the watchdog timeout expires."
}

variable "send_sighup" {
  type    = bool
  default = false

  description = "Specifies whether to send `SIGHUP` to remaining processes immediately after sending the signal configured with `kill_signal`."
}

variable "send_sigkill" {
  type    = bool
  default = true

  description = "Specifies whether to send `SIGKILL` to remaining processes after a timeout, if the normal shutdown procedure left processes of the service around."
}

variable "selinux_context" {
  type    = string
  default = ""
}

variable "apparmor_profile" {
  type    = string
  default = ""
}

variable "capability_bounding_set" {
  type    = list(string)
  default = []

  description = "Controls which capabilities to include in the capability bounding set for the executed process."
}

variable "ambient_capabilities" {
  type    = list(string)
  default = []

  description = "Controls which capabilities to include in the ambient capability set for the executed process."
}

variable "environment" {
  type = list(string)

  default = []

  description = "Sets environment variables for executed processes."
}

variable "environment_file" {
  type = list(string)

  default = []

  description = "Similar to `environment` but reads the environment variables from a text file."
}

variable "lock_personality" {
  type    = bool
  default = false

  description = "If set, locks down the personality(2) system call so that the kernel execution domain may not be changed from the default or the personality selected."
}

variable "oom_score_adjust" {
  type    = number
  default = 0

  validation {
    condition     = var.oom_score_adjust >= -1000 && var.oom_score_adjust <= 1000
    error_message = "OOM score adjust must be an integer value in range -1000...1000."
  }

  description = "Sets the adjustment value for the Linux kernel's Out-Of-Memory (OOM) killer score for executed processes."
}

variable "timeout_sec" {
  type    = number
  default = 0
}

variable "timeout_start_sec" {
  type    = number
  default = 0
}

variable "timeout_stop_sec" {
  type    = number
  default = 0
}

variable "timeout_abort_sec" {
  type    = number
  default = 0
}

variable "memory_deny_write_execute" {
  type    = bool
  default = false

  description = <<-DESC
  If set, attempts to create memory mappings that are writable and executable at the same time,
  or to change existing memory mappings to become executable, or mapping shared memory segments as executable are prohibited.
  DESC
}

variable "file_descriptor_store_max" {
  type    = number
  default = 0
}

variable "limit_cpu" {
  type    = string
  default = ""
}

variable "limit_fsize" {
  type    = string
  default = ""
}

variable "limit_data" {
  type    = string
  default = ""
}

variable "limit_stack" {
  type    = string
  default = ""
}

variable "limit_core" {
  type    = string
  default = ""
}

variable "limit_rss" {
  type    = string
  default = ""
}

variable "limit_nofile" {
  type    = string
  default = ""
}

variable "limit_as" {
  type    = string
  default = ""
}

variable "limit_nproc" {
  type    = string
  default = ""
}

variable "limit_memlock" {
  type    = string
  default = ""
}

variable "limit_locks" {
  type    = string
  default = ""
}

variable "limit_sigpending" {
  type    = string
  default = ""
}

variable "limit_msqueue" {
  type    = string
  default = ""
}

variable "limit_nice" {
  type    = string
  default = ""
}

variable "limit_rptprio" {
  type    = string
  default = ""
}

variable "limit_rttime" {
  type    = string
  default = ""
}

variable "tasks_max" {
  type    = string
  default = ""
}
