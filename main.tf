terraform {
  required_version = ">= 0.13"
}

locals {
  content = templatefile("${path.module}/templates/systemd-unit", {
    description                     = var.description
    documentation                   = var.documentation
    wants                           = var.wants
    requires                        = var.requires
    before                          = var.before
    after                           = var.after
    conflicts                       = var.conflicts
    on_failure                      = var.on_failure
    propagates_reload_to            = var.propagates_reload_to
    reload_propagated_from          = var.reload_propagated_from
    default_dependencies            = var.default_dependencies
    condition_architecture          = var.condition_architecture
    condition_virtualization        = var.condition_virtualization
    condition_first_boot            = var.condition_first_boot
    condition_path_exists           = var.condition_path_exists
    condition_path_is_directory     = var.condition_path_is_directory
    condition_path_is_symbolic_link = var.condition_path_is_symbolic_link
    condition_path_is_mount_point   = var.condition_path_is_mount_point
    condition_path_is_read_write    = var.condition_path_is_read_write
    condition_directory_not_empty   = var.condition_directory_not_empty
    condition_file_not_empty        = var.condition_file_not_empty
    condition_file_is_executable    = var.condition_file_is_executable
    condition_memory                = var.condition_memory
    condition_cpus                  = var.condition_cpus
    wanted_by                       = var.wanted_by
    required_by                     = var.required_by
    aliases                         = var.aliases
    also                            = var.also
    user                            = var.user
    group                           = var.group
    service_type                    = var.service_type
    remain_after_exit               = var.remain_after_exit
    bus_name                        = var.bus_name
    notify_access                   = var.notify_access
    restart                         = var.restart
    watchdog_sec                    = var.watchdog_sec
    restart_sec                     = var.restart_sec
    nice                            = var.nice
    private_tmp                     = var.private_tmp
    protect_system                  = var.protect_system
    protect_home                    = var.protect_home
    exec_start_pre                  = var.exec_start_pre
    exec_start                      = var.exec_start
    exec_start_post                 = var.exec_start_post
    exec_stop                       = var.exec_stop
    exec_stop_post                  = var.exec_stop_post
    exec_reload                     = var.exec_reload
    pid_file                        = var.pid_file
    working_directory               = var.working_directory
    runtime_directory               = var.runtime_directory
    state_directory                 = var.state_directory
    cache_directory                 = var.cache_directory
    logs_directory                  = var.logs_directory
    configuration_directory         = var.configuration_directory
    runtime_directory_preserve      = var.runtime_directory_preserve
    standard_output                 = var.standard_output
    standard_input                  = var.standard_input
    sockets                         = var.sockets
    permissions_start_only          = var.permissions_start_only
    no_new_privileges               = var.no_new_privileges
    ignore_sigpipe                  = var.ignore_sigpipe
    kill_mode                       = var.kill_mode
    kill_signal                     = var.kill_signal
    restart_kill_signal             = var.restart_kill_signal
    send_sighup                     = var.send_sighup
    send_sigkill                    = var.send_sigkill
    watchdog_signal                 = var.watchdog_signal
    selinux_context                 = var.selinux_context
    apparmor_profile                = var.apparmor_profile
    capability_bounding_set         = var.capability_bounding_set
    ambient_capabilities            = var.ambient_capabilities
    environment                     = var.environment
    environment_file                = var.environment_file
    lock_personality                = var.lock_personality
    oom_score_adjust                = var.oom_score_adjust
    timeout_sec                     = var.timeout_sec
    timeout_start_sec               = var.timeout_start_sec
    timeout_stop_sec                = var.timeout_stop_sec
    timeout_abort_sec               = var.timeout_abort_sec
    memory_deny_write_execute       = var.memory_deny_write_execute
    file_descriptor_store_max       = var.file_descriptor_store_max
    limit_cpu                       = var.limit_cpu
    limit_fsize                     = var.limit_fsize
    limit_data                      = var.limit_data
    limit_stack                     = var.limit_stack
    limit_core                      = var.limit_core
    limit_rss                       = var.limit_rss
    limit_nofile                    = var.limit_nofile
    limit_as                        = var.limit_as
    limit_nproc                     = var.limit_nproc
    limit_memlock                   = var.limit_memlock
    limit_locks                     = var.limit_locks
    limit_sigpending                = var.limit_sigpending
    limit_msqueue                   = var.limit_msqueue
    limit_nice                      = var.limit_nice
    limit_rptprio                   = var.limit_rptprio
    limit_rttime                    = var.limit_rttime
    tasks_max                       = var.tasks_max
  })
}