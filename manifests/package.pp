class hivemq::package(
  $version = undef,
  $versionlock = false
) {

  validate_re($version, '^[~+._0-9a-zA-Z:-]+$')
  validate_bool($versionlock)

  package { 'hivemq':
    ensure  => $version
  }

  case $versionlock {
    true: {
      packagelock { 'hivemq': }
    }
    false: {
      packagelock { 'hivemq': ensure => absent }
    }
    default: { fail('Class[Hivemq::Package]: parameter versionlock must be true or false') }
  }

}
