$packages = [ 'httpd', 'php', 'php-mysqlnd', 'git' ]

package { $packages: }

vcsrepo { '/code':
  ensure   => present,
  provider => git,
  source   => 'https://github.com/shekeriev/do2-app-pack.git',
}

file_line { 'hosts-web':
  ensure  => present,
  path    => '/etc/hosts',
  line    => '192.168.99.101 web.do2.exam web',
  match   => '^192.168.99.101',
}

file_line { 'hosts-db':
  ensure  => present,
  path    => '/etc/hosts',
  line    => '192.168.99.102 db.do2.exam db',
  match   => '^192.168.99.102',
}

file { '/etc/httpd/conf.d/vhost-app1.conf':
  ensure  => present,
  content => 'Listen 8001
<VirtualHost *:8001>
    DocumentRoot "/var/www/app1"
</VirtualHost>',
}

file { '/etc/httpd/conf.d/vhost-app2.conf':
  ensure  => present,
  content => 'Listen 8002
<VirtualHost *:8002>
    DocumentRoot "/var/www/app2"
</VirtualHost>',
}

file { '/var/www/app1':
  ensure => 'directory',
  recurse => true,
  source => "/code/app2/web/",
}

file { '/var/www/app2':
  ensure => 'directory',
  recurse => true,
  source => "/code/app4/web/",
}

class { 'firewall': }

firewall { "000 accept 8001/tcp":
  action   => 'accept',
  dport    => 8001,
  proto    => 'tcp',
}

firewall { "000 accept 8002/tcp":
  action   => 'accept',
  dport    => 8002,
  proto    => 'tcp',
}

class { selinux:
  mode => 'permissive',
}

service { httpd:
  ensure => running,
  enable => true,
}
