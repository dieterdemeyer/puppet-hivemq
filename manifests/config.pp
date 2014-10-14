class hivemq::config(
){

  file { '/opt/hivemq/conf/configuration.properties':
    ensure  => file,
    mode    => '0644',
    owner   => 'hivemq',
    group   => 'hivemq',
    content => template("${module_name}/conf/configuration.properties.erb"),
    notify  => Class['hivemq::service']
  }

  file { '/opt/hivemq/conf/hivemq-wrapper.conf':
    ensure  => file,
    mode    => '0644',
    owner   => 'hivemq',
    group   => 'hivemq',
    content => template("${module_name}/conf/hivemq-wrapper.conf.erb"),
    notify  => Class['hivemq::service']
  }

  file { '/etc/init.d/hivemq':
    ensure  => file,
    mode    => '0755',
    content => template("${module_name}/init/hivemq.erb")
  }

}
