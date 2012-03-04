# easysvc: simple generic services for puppet

Simple generic services for puppet that are quick and easy

## Using easysvc

This module provides a define for quickly creating new puppet services.

Place this module in your modules directory. Either name it easysvc or create
a symlink to the git checkout named easysvc.

```
  # In, e.g., nodes.pp
  node 'mynode' {
    easysvc::svc { 'ntpd':
      service_name  => 'ntpd',
      config_files  => [ '/etc/ntp/ntp.conf' ],
      config_tpls   => [ 'ntp.conf.erb' ],
      config_owners => [ 0 ],
      config_groups => [ 0 ],
      config_modes  => [ 0644 ],
      pkg_name      => 'ntp',
      autoupdate    => true,
      service_ensure => 'running',
      service_enable => true,
      service_hasstatus => true,
      service_hasrestart => true,
    }
  }
  # For the above example, ntp.conf.erb is provided in the templates directory.
```

## Notes
* I would like to make some parameters optional with defaults, but have thus
  far been unable to figure out how to do this correctly with 2.6.12.
* I will probably next add the ability to make a service depend on another
  service.
* Any recommendations for extending this define are appreciated!

## More examples
```
  node 'mynode' {
    easysvc::svc { 'func':
      service_name  => 'funcd',
      config_files  => [ '/etc/func/minionconf',
                         '/etc/func/overlord.conf' ],
      config_tpls   => [ 'func_minion.conf.erb',
                         'func_overlord.conf.erb' ],
      config_owners => [ 0, 0 ],
      config_groups => [ 0, 0 ],
      config_modes  => [ 0644, 0644 ],
      pkg_name      => 'func',
      autoupdate    => true,
      service_ensure => 'running',
      service_enable => true,
      service_hasstatus => true,
      service_hasrestart => true,
    }
  
    easysvc::svc { 'ssh':
      service_name  => 'sshd',
      config_files  => [ '/etc/ssh/ssh_config',
                         '/etc/ssh/sshd_config' ],
      config_tpls   => [ 'ssh_config.erb',
                         'sshd_config.erb' ],
      config_owners => [ 0, 0 ],
      config_groups => [ 0, 0 ],
      config_modes  => [ 0644, 0600 ],
      pkg_name      => 'openssh-server',
      autoupdate    => true,
      service_ensure => 'running',
      service_enable => true,
      service_hasstatus => true,
      service_hasrestart => true,
    }
  
    easysvc::svc { 'opensm':
      service_name  => 'opensmd',
      config_files  => [ ],
      config_tpls   => [ ],
      config_owners => [ ],
      config_groups => [ ],
      config_modes  => [ ],
      pkg_name      => 'opensm',
      autoupdate    => true,
      service_ensure => 'running',
      service_enable => true,
      service_hasstatus => true,
      service_hasrestart => true,
    }
  }

```
