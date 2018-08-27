# Profile to manage mediawiki
class profile::mediawiki {
  include ::apache
  include ::apache::mod::php
  include ::wget
  include ::stdlib

  package {['php','php-mysql','php-fpm','php-xml','php-intl','php-gd']:
    ensure => 'latest',
  }
  
  wget::fetch { 'download MediaWiki':
  source      => 'http://releases.wikimedia.org/mediawiki/1.24/mediawiki-1.24.1.tar.gz',
  destination => '/tmp/',
  verbose     => false,
  }

  exec { 'unpack_mediawiki':
    path => ['/bin','/usr/bin','/sbin','/usr/sbin'],
    cwd => '/tmp',
    command => 'tar -xvf mediawiki-1.24.1.tar.gz',
    creates  => '/var/www/html/index.php',
  }
 
  exec { 'move_mediawiki':
    path => ['/bin','/usr/bin','/sbin','/usr/sbin'],
    cwd  => '/var/www/html',
    command => 'mv /tmp/mediawiki-1.24.1/* /var/www/html/',
    creates => '/var/www/html/index.php'
  }

  exec { 'install_mediawiki':
    path => ['/bin','/usr/bin','/sbin','/usr/sbin'],
    cwd  => '/var/www/html',
    command => 'php maintenance/install.php --dbname wiki --dbuser install_wiki --dbpass install_wiki --dbserver db.interview.webperfdev.com --pass Xeiv5eemeud9 interview interview',
    creates => '/var/www/html/LocalSettings.php',
  }

  file_line { 'Disable account creation to avoid spam':
    ensure => present,
    line => '$wgGroupPermissions[\'*\'][\'createaccount\'] = false;',
    path => '/var/www/html/LocalSettings.php',
  }

  apache::vhost { 'web.interview.webperfdev.com non-ssl':
    servername => 'web1.interview.webperfdev.com',
    port       => '80',
    docroot    => '/var/www/html',
    aliases => [
      { alias            => '/wiki',
        path             => '/var/www/html',
      },
    ],
  } 
}
