# Systemd unit

Creates systemd unit config.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| description | A human readable name for the unit.<br>This is used by systemd (and other UIs) as the label for the unit,<br>so this string should identify the unit rather than describe it, despite the name.<br>'Apache2 Web Server' is a good example. | `string` | `""` | no |
| documentation | A list of URIs referencing documentation for this unit or its configuration.<br>Accepted are only URIs of the types "http://", "https://", "file:", "info:", "man:". | `list(string)` | `[]` | no |
| wants | Configures requirement dependencies on other units. | `list(string)` | `[]` | no |
| requires | Similar to `wants`, but declares a stronger dependency. | `list(string)` | `[]` | no |
| before | Ensures that the configured unit is started before the listed unit begins starting up. | `list(string)` | `[]` | no |
| after | Ensures the opposite, that the listed unit is fully started up before the configured unit is started. | `list(string)` | <pre>[<br>  "network.target"<br>]</pre> | no |
| conflicts | Configures negative requirement dependencies.<br>If a unit has a `conflicts` setting on another unit, starting the former will stop the latter and vice versa. | `list(string)` | `[]` | no |
| on\_failure | List of one or more units that are activated when this unit enters the 'failed' state. | `list(string)` | `[]` | no |
| propagates\_reload\_to | List of one or more units where reload requests on this unit will be propagated to this unit. | `list(string)` | `[]` | no |
| reload\_propagated\_from | List of one or more units where reload requests on the other unit will be propagated to this unit. | `list(string)` | `[]` | no |
| default\_dependencies | If `true`, a few default dependencies will implicitly be created for the unit. The actual dependencies created depend on the unit type. | `bool` | `true` | no |
| condition\_architecture | Check whether the system is running on a specific architecture. | `string` | `""` | no |
| condition\_virtualization | Check whether the system is executed in a virtualized environment and optionally test whether it is a specific implementation. | `string` | `""` | no |
| condition\_first\_boot | This condition may be used to conditionalize units on whether the system is booting up for the first time. | `bool` | `false` | no |
| condition\_ac\_power | This condition may be used to conditionalize units on whether the system is booting up for the first time. | `bool` | `false` | no |
| condition\_path\_exists | Check for the exists of a file.<br>If the specified absolute path name does not exist, the condition will fail.<br>If the absolute path name passed to condition is prefixed with an exclamation mark ("!"),<br>the test is negated, and the unit is only started if the path does not exist. | `list(string)` | `[]` | no |
| condition\_path\_is\_directory | Similar to `condition_path_exists` but verifies that a certain path exists and is a directory. | `list(string)` | `[]` | no |
| condition\_path\_is\_symbolic\_link | Similar to `condition_path_exists` but verifies that a certain path exists and is a symbolic link. | `list(string)` | `[]` | no |
| condition\_path\_is\_mount\_point | Similar to `condition_path_exists` but verifies that a certain path exists and is a mount point. | `list(string)` | `[]` | no |
| condition\_path\_is\_read\_write | Similar to `condition_path_exists` but verifies that the underlying file system is readable and writable (i.e. not mounted read-only). | `list(string)` | `[]` | no |
| condition\_directory\_not\_empty | Similar to `condition_path_exists` but verifies that a certain path exists and is a non-empty directory. | `list(string)` | `[]` | no |
| condition\_file\_not\_empty | Similar to `condition_path_exists` but verifies that a certain path exists and refers to a regular file with a non-zero size. | `list(string)` | `[]` | no |
| condition\_file\_is\_executable | Similar to `condition_path_exists` but verifies that a certain path exists, is a regular file, and marked executable. | `list(string)` | `[]` | no |
| condition\_memory | Verify that the specified amount of system memory is available to the current system.<br>Takes a memory size in bytes as argument, optionally prefixed with a comparison operator "<", "<=", "=", "!=", ">=", ">".<br>On bare-metal systems compares the amount of physical memory in the system with the specified size,<br>adhering to the specified comparison operator. In containers compares the amount of memory assigned to the container instead. | `string` | `""` | no |
| condition\_cpus | Verify that the specified number of CPUs is available to the current system.<br>Takes a number of CPUs as argument, optionally prefixed with a comparison operator "<", "<=", "=", "!=", ">=", ">".<br>Compares the number of CPUs in the CPU affinity mask configured of the service manager itself with the specified number,<br>adhering to the specified comparison operator. On physical systems the number of CPUs in the affinity mask of the service manager<br>usually matches the number of physical CPUs, but in special and virtual environments might differ.<br>In particular, in containers the affinity mask usually matches the number of CPUs assigned to the container and not the physically available ones. | `string` | `""` | no |
| wanted\_by | n/a | `list(string)` | <pre>[<br>  "multi-user.target"<br>]</pre> | no |
| required\_by | n/a | `list(string)` | `[]` | no |
| aliases | Service unit aliases. | `list(string)` | `[]` | no |
| also | n/a | `list(string)` | `[]` | no |
| user | n/a | `string` | `""` | no |
| group | n/a | `string` | `""` | no |
| service\_type | n/a | `string` | `"simple"` | no |
| remain\_after\_exit | n/a | `bool` | `false` | no |
| bus\_name | n/a | `string` | `""` | no |
| notify\_access | n/a | `string` | `""` | no |
| restart | Configures whether the service shall be restarted when the service process exits, is killed, or a timeout is reached. | `string` | `"on-failure"` | no |
| watchdog\_sec | n/a | `number` | `0` | no |
| restart\_sec | n/a | `number` | `0` | no |
| nice | n/a | `number` | `0` | no |
| private\_tmp | If `true`, sets up a new file system namespace for the executed processes and mounts<br>private `/tmp` and `/var/tmp` directories inside it that are not shared by processes outside of the namespace. | `bool` | `false` | no |
| protect\_system | If `true`, mounts the `/usr` and the boot loader directories (`/boot` and `/efi`) read-only for processes invoked by this unit.<br>If set to `full`, the `/etc` directory is mounted read-only, too.<br>If set to `strict` the entire file system hierarchy is mounted read-only, except for the API file system subtrees `/dev`, `/proc` and `/sys`. | `string` | `""` | no |
| protect\_home | If `true`, the directories `/home`, `/root`, and `/run/user` are made inaccessible and empty for processes invoked by this unit.<br>If set to `read-only`, the three directories are made read-only instead.<br>If set to `tmpfs`, temporary file systems are mounted on the three directories in read-only mode. | `string` | `""` | no |
| exec\_start\_pre | n/a | `list(string)` | `[]` | no |
| exec\_start\_post | n/a | `list(string)` | `[]` | no |
| exec\_start | n/a | `list(string)` | `[]` | no |
| exec\_stop | n/a | `list(string)` | `[]` | no |
| exec\_stop\_post | n/a | `list(string)` | `[]` | no |
| exec\_reload | n/a | `list(string)` | `[]` | no |
| pid\_file | Path to PID file. | `string` | `""` | no |
| working\_directory | Working directory path. | `list(string)` | `[]` | no |
| runtime\_directory | Runtime directory path. | `list(string)` | `[]` | no |
| state\_directory | State directory path. | `list(string)` | `[]` | no |
| cache\_directory | Cache directory path. | `list(string)` | `[]` | no |
| logs\_directory | Logs directory path. | `list(string)` | `[]` | no |
| configuration\_directory | Configuration directory path. | `list(string)` | `[]` | no |
| runtime\_directory\_preserve | If set to `no`, the directories specified in runtime\_directory are always removed when the service stops.<br>If set to `restart` the directories are preserved when the service is both automatically and manually restarted.<br>If set to `yes`, then the directories are not removed when the service is stopped. | `string` | `""` | no |
| standard\_output | Controls where file descriptor 1 (stdout) of the executed processes is connected to.<br>Takes one of `inherit`, `null`, `tty`, `journal`, `kmsg`, `journal+console`, `kmsg+console`, `file:path`, `append:path`, `socket` or `fd:name`. | `string` | `""` | no |
| standard\_input | Controls where file descriptor 0 (STDIN) of the executed processes is connected to.<br>Takes one of `null`, `tty`, `tty-force`, `tty-fail`, `data`, `file:path`, `socket` or `fd:name`. | `string` | `""` | no |
| sockets | Working directory path. | `list(string)` | `[]` | no |
| permissions\_start\_only | Permissions start only. | `bool` | `false` | no |
| no\_new\_privileges | If `true`, ensures that the service process and all its children can never gain new privileges through execve(). | `bool` | `false` | no |
| ignore\_sigpipe | Ignore SIGPIPE. | `bool` | `false` | no |
| kill\_mode | Specifies how processes of this unit shall be killed. One of control-group, mixed, process, none. | `string` | `""` | no |
| kill\_signal | Specifies which signal to use when stopping a service.<br>This controls the signal that is sent as first step of shutting down a unit, and is usually followed by `SIGKILL`." | `string` | `""` | no |
| restart\_kill\_signal | Specifies which signal to use when restarting a service. | `string` | `""` | no |
| watchdog\_signal | Specifies which signal to use to terminate the service when the watchdog timeout expires. | `string` | `""` | no |
| send\_sighup | Specifies whether to send `SIGHUP` to remaining processes immediately after sending the signal configured with `kill_signal`. | `bool` | `false` | no |
| send\_sigkill | Specifies whether to send `SIGKILL` to remaining processes after a timeout, if the normal shutdown procedure left processes of the service around. | `bool` | `true` | no |
| selinux\_context | n/a | `string` | `""` | no |
| apparmor\_profile | n/a | `string` | `""` | no |
| capability\_bounding\_set | Controls which capabilities to include in the capability bounding set for the executed process. | `list(string)` | `[]` | no |
| ambient\_capabilities | Controls which capabilities to include in the ambient capability set for the executed process. | `list(string)` | `[]` | no |
| environment | Sets environment variables for executed processes. | `list(string)` | `[]` | no |
| environment\_file | Similar to `environment` but reads the environment variables from a text file. | `list(string)` | `[]` | no |
| lock\_personality | If set, locks down the personality(2) system call so that the kernel execution domain may not be changed from the default or the personality selected. | `bool` | `false` | no |
| oom\_score\_adjust | Sets the adjustment value for the Linux kernel's Out-Of-Memory (OOM) killer score for executed processes. | `number` | `0` | no |
| timeout\_sec | n/a | `number` | `0` | no |
| timeout\_start\_sec | n/a | `number` | `0` | no |
| timeout\_stop\_sec | n/a | `number` | `0` | no |
| timeout\_abort\_sec | n/a | `number` | `0` | no |
| memory\_deny\_write\_execute | If set, attempts to create memory mappings that are writable and executable at the same time,<br>or to change existing memory mappings to become executable, or mapping shared memory segments as executable are prohibited. | `bool` | `false` | no |
| file\_descriptor\_store\_max | n/a | `number` | `0` | no |
| limit\_cpu | n/a | `string` | `""` | no |
| limit\_fsize | n/a | `string` | `""` | no |
| limit\_data | n/a | `string` | `""` | no |
| limit\_stack | n/a | `string` | `""` | no |
| limit\_core | n/a | `string` | `""` | no |
| limit\_rss | n/a | `string` | `""` | no |
| limit\_nofile | n/a | `string` | `""` | no |
| limit\_as | n/a | `string` | `""` | no |
| limit\_nproc | n/a | `string` | `""` | no |
| limit\_memlock | n/a | `string` | `""` | no |
| limit\_locks | n/a | `string` | `""` | no |
| limit\_sigpending | n/a | `string` | `""` | no |
| limit\_msqueue | n/a | `string` | `""` | no |
| limit\_nice | n/a | `string` | `""` | no |
| limit\_rptprio | n/a | `string` | `""` | no |
| limit\_rttime | n/a | `string` | `""` | no |
| tasks\_max | n/a | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| content | Generated unit file content. |
| checksum | Checksum of content. |

