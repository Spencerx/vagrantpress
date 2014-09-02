# VagrantPress

...as customised by the [Open Knowledge Foundation](http://okfn.org) for
[WPEngine](http://wpengine.com)-compatible local development.

VagrantPress is a packaged development environment for developing WordPress
themes and modules. This is a customised version of VagrantPress, specifically
designed for starting up a local development environment from a WPEngine backup
point.


## Prerequisites

Before you can do anything, you'll need a working installation of
[Vagrant](http://vagrantup.com), which in turn will require either
[VirtualBox](https://www.virtualbox.org/) or [VMWare
Fusion](http://www.vmware.com/products/fusion/). The latter is not free, but can
be much faster than VirtualBox.

If the following command does not work, you won't be able to get anything else
working:

    $ vagrant -v
    Vagrant 1.4.0

## Mac Installation Instructions

You should also install
[vagrant-dns](https://github.com/BerlinVagrant/vagrant-dns):

    $ vagrant plugin install vagrant-dns
    Installing the 'vagrant-dns' plugin. This can take a few minutes...
    Installed the plugin 'vagrant-dns (0.5.0)'!

## Linux Installation Instructions

You need to install `dnsmasq`

    $ sudo apt-get install dnsmasq

Add the following to /etc/dnsmasq.d/wpdev

    address=/.wpdev/172.16.23.16

Replace 172,16,23,16 with the IP address for the virtualbox host.

Patch the Vagrantfile with linux.patch

    patch -p1 < linux.patch

## Getting started

The procedure for starting up a working WordPress is as follows:

1. Clone this project

        git clone https://github.com/okfn/vagrantpress
        cd vagrantpress

2. Clone the WPEngine git repo into `wordpress/`

        git clone git@git.wpengine.com:staging/okf wordpress/

3. Download a backup point zip from WPEngine and copy `mysql.sql` and
   `wp-config.php` into this directory. For example, if you have expanded the
   backup point into the directory `site-archive-foo` alongside the
   `vagrantpress` directory, you might do:

        cp ../site-archive-foo/wp-config.php .
        cp ../site-archive-foo/wp-content/mysql.sql .

4. Run vagrant up. This will take a long time to complete.

        vagrant up

5. Install the vagrant-dns resolver. This may prompt for your password:

        vagrant dns --install


## Working with the environment

You should now be able to visit your WPEngine installation at
<http://vagrantpress.wpdev/>.

If you have a multisite installation, then replace dots in domain names with
dashes and append ".wpdev" to visit that site. For example, if your WP multisite
instance has a blog with domain "foo.example.com", you should be able to visit
it at <http://foo-example-com.wpdev/>.

You can access phpMyAdmin at <http://vagrantpress.wpdev/phpmyadmin/> and can log
in with username `wordpress`, password `wordpress`.


## Thanks

Huge thanks to [Chad Thompson][chadthompson], who was responsible for the first
version of Vagrantpress.

[chadthompson]: http://chadthompson.me
