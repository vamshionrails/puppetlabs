class jenkins_module {
  $pathvariable = "/var/lib/jenkins"
  $sourcevariable = "puppet:///modules/jenkins"

  package { 'git': ensure => present, }

  package { 'jenkins': ensure => present, }

  service { 'jenkins':
    ensure  => running,
    enable  => true,
    require => Package["jenkins"],
  }

  file { [$pathvariable, "${pathvariable}/plugins"]:
    ensure  => directory,
    owner   => "jenkins",
    group   => "jenkins",
    mode    => "755",
    require => Package["jenkins"],
    notify  => Service["jenkins"],
  }

  yumrepo { "jenkins":
    baseurl  => "http://pkg.jenkins-ci.org/redhat-stable",
    descr    => "Jenkins",
    enabled  => 1,
    gpgcheck => 1,
    gpgkey   => "http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key",
  }

  exec { "enable port 8080 with iptables":
    command => "/sbin/iptables -I INPUT -p tcp -m tcp --dport 8080 -j ACCEPT; /sbin/iptables-save",
    user    => "root"
  }

  jenkins::plugins { "${jenkins_module::pathvariable}/plugins/credentials.hpi": pluginpath => "${sourcevariable}/credentials.hpi", }

  jenkins::plugins { "${jenkins_module::pathvariable}/plugins/git-client.hpi": pluginpath => "${sourcevariable}/git-client.hpi", }

  jenkins::plugins { "${jenkins_module::pathvariable}/plugins/git.hpi": pluginpath => "${sourcevariable}/git.hpi", }

  jenkins::plugins { "${jenkins_module::pathvariable}/plugins/github-api.hpi": pluginpath => "${sourcevariable}/github-api.hpi", }

  jenkins::plugins { "${jenkins_module::pathvariable}/plugins/github.hpi": pluginpath => "${sourcevariable}/github.hpi", }

  jenkins::plugins { "${jenkins_module::pathvariable}/plugins/scm-api.hpi": pluginpath => "${sourcevariable}/scm-api.hpi", }

  jenkins::plugins { "${jenkins_module::pathvariable}/plugins/ssh-credentials.hpi": pluginpath => "${sourcevariable}/ssh-credentials.hpi", 
  }
}