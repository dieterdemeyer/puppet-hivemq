# Class: hivemq
#
# This module manages hivemq
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class hivemq(
  $version = undef,
  $versionlock = false,
  $ensure = 'running',
  $global_ip_address = '0.0.0.0',
  $global_port = '1883',
  $ssl_enabled = false,
  $ssl_ip_address ='0.0.0.0',
  $ssl_port = '8883',
  $ssl_protocol ='TLS',
  $ssl_appl_client_auth = false,
  $ssl_client_auth_mode = 'none',
  $websockets_enabled = false,
  $websockets_ip_address = '0.0.0.0',
  $websockets_port = '8000',
  $websockets_secure_enabled = false,
  $websockets_secure_ip_address = '0.0.0.0',
  $websockets_secure_port = '8001',
  $check_for_updates = false
) {

  include stdlib

  anchor { 'hivemq::begin': }
  anchor { 'hivemq::end': }

  validate_re($version, '^[~+._0-9a-zA-Z:-]+$')
  validate_bool($versionlock)
  validate_re($ensure, '^running$|^stopped$')
  validate_re($global_ip_address, '^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$')
  validate_bool($ssl_enabled)
  validate_re($ssl_ip_address, '^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$')
  validate_re($ssl_protocol, '^SSLv3$|^TLS$|^TLSv1$|^TLSv1.1$|^TLSv1.2$')
  validate_bool($ssl_appl_client_auth)
  validate_re($ssl_client_auth_mode, '^none$|^optional$|^required$')
  validate_re($websockets_ip_address, '^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$')
  validate_re($websockets_secure_ip_address, '^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$')
  validate_bool($websockets_enabled)
  validate_bool($websockets_secure_enabled)
  validate_bool($check_for_updates)

  class { 'hivemq::package':
    version     => $version,
    versionlock => $versionlock
  }

  class { 'hivemq::config': }

  class { 'hivemq::service':
    ensure => $ensure
  }

  Anchor['hivemq::begin'] -> Class['Hivemq::Package'] -> Class['Hivemq::Config'] ~> Class['Hivemq::Service'] -> Anchor['hivemq::end']

}
