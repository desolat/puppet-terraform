# @summary Provision Hashicorp Terraform
#
# Provisions Hashicorp Terraform
#
# @example
#   include terraform
class terraform (
  String $version = 'latest',
  ) {

    if ! defined(Package['unzip']) {
      package { 'unzip':
        ensure => present,
      }
    }

    file { '/tmp/install_terraform.sh':
      ensure  => present,
      mode    => '0744',
      content => file('profile/install_terraform.sh'),
    }

    exec { 'install_terraform.sh':
      command => "/tmp/install_terraform.sh ${version}",
      cwd     => '/tmp',
      path    => '/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/sbin:/bin:/sbin',
      #path    => $path,
      #provider => 'shell',
      require => Package['unzip'],
    }

}
