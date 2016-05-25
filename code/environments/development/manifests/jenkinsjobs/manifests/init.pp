class jenkinsjobs ($grpath = "https://github.com/Scionar/TiPi.git") {
  $pathvariable = "/var/lib/jenkins/jobs/jenkinsjobs"

  file { $pathvariable:
    ensure => directory,
    group  => "jenkins",
    mode   => "755",
    owner  => "jenkins",
    notify => Service["jenkins"],
  }

  file { "${pathvariable}/config.xml":
    ensure  => present,
    replace => no,
    content => template('jenkinsjobs/config.xml.erb'),
    group   => "jenkins",
    mode    => "644",
    owner   => "jenkins",
    require => File[$pathvariable],
    notify  => Service["jenkins"],
  }

  service { 'jenkins':
    ensure => running,
    enable => true,
  }

}