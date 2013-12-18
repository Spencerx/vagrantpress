# Install Wordpress

class wordpress::install {

  # Create the Wordpress database
  exec { 'create-database':
    unless  => '/usr/bin/mysql -u root -pvagrant wordpress',
    command => '/usr/bin/mysql -u root -pvagrant --execute=\'create database wordpress\'',
  }

  exec { 'create-user':
    unless  => '/usr/bin/mysql -u wordpress -pwordpress',
    command => '/usr/bin/mysql -u root -pvagrant --execute="GRANT ALL PRIVILEGES ON wordpress.* TO \'wordpress\'@\'localhost\' IDENTIFIED BY \'wordpress\'"',
  }

  exec { 'load-database':
    command  => '/usr/bin/mysql -u wordpress -pwordpress wordpress </vagrant/mysql.sql && touch /home/vagrant/db-loaded',
    provider => 'shell',
    timeout  => 1800,  # This might take a really long time.
    creates  => '/home/vagrant/db-loaded',
    require  => Exec['create-user'],
  }

  exec { 'fixup-database':
    command => '/bin/sh -eu /vagrant/tools/filter_database.sh && touch /home/vagrant/db-filtered',
    creates => '/home/vagrant/db-filtered',
    require => Exec['load-database'],
  }

  exec { 'create-wpconfig':
    command => '/usr/bin/python /vagrant/tools/filter_config.py </vagrant/wp-config.php >/vagrant/wordpress/wp-config.php',
    creates => '/vagrant/wordpress/wp-config.php',
  }

}
