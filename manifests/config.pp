class nullmailer::config {

  if $nullmailer::manage_etc_mailname == true {

    file {"nullmailer /etc/mailname for ${::fqdn}":
      ensure  => present,
      name    => '/etc/mailname',
      content => "${::fqdn}\n",
    }

  }

  file { '/etc/nullmailer/remotes':
    content => "$nullmailer::remoterelay smtp $nullmailer::remoteopts\n",
    require => Class['nullmailer::package'],
    notify  => Class['nullmailer::service'],
    owner   => 'mail',
    group   => 'mail',
    mode    => '0600',
  }

  if $nullmailer::idhost {
    file { '/etc/nullmailer/idhost':
      content => "$nullmailer::idhost\n",
      require => Class['nullmailer::package'],
      notify  => Class['nullmailer::service'],
    }
  } else {
    file { '/etc/nullmailer/idhost':
      ensure  => absent,
    }
  }

  if $nullmailer::defaulthost {
    file { '/etc/nullmailer/defaulthost':
      content => "$nullmailer::defaulthost\n",
      require => Class['nullmailer::package'],
      notify  => Class['nullmailer::service'],
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
    }
  } else {
    file { '/etc/nullmailer/defaulthost':
      ensure  => absent,
    }
  }

  if $nullmailer::defaultdomain {
    file { '/etc/nullmailer/defaultdomain':
      content => "$nullmailer::defaultdomain\n",
      require => Class['nullmailer::package'],
      notify  => Class['nullmailer::service'],
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
    }
  } else {
    file { '/etc/nullmailer/defaultdomain':
      ensure  => absent,
    }
  }

  if ($nullmailer::adminaddr == '') {
    file { '/etc/nullmailer/adminaddr':
      ensure => absent,
    }
  } else {
    file { '/etc/nullmailer/adminaddr':
      content => "$nullmailer::adminaddr\n",
      require => Class['nullmailer::package'],
      notify  => Class['nullmailer::service'],
      owner   => 'mail',
      group   => 'mail',
      mode    => '0600',
    }
  }
}
