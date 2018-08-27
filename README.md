# Phase-1: Creating NTP Puppet module

# SETUP
Create a directory inside modules called ntp

modules
 |-ntp
    |-manifests
       |-init.pp
       |-config.pp
       |-install.pp
       |-service.pp
    |-templates
      |-ntp.conf.epp

In init.pp create a class called ntp. This class will be the main class. In this class declare all the variables that you would want to configure. Also, include other classes like "contain config.pp". In this class we also specify the order of execution of classes aka dependance. I have configured only minimum configuration required to run NTP, list of servers being the most important one.

In config.pp, specify resources that are required by ntp to run, for e.g. presence of ntp.conf and contents which are rendered by template ntp.conf.epp. In install.pp, manage state of NTP package, whether you want it to be installed or not. In service.pp, manage state of ntpd service.

To manage different configuration on different nodes, create .yaml for all the 4 nodes inside nodes dir as per the heirarchy specified in hiera.yaml.

 |-data
   |-nodes
     |-db.interview.webperfdev.com.yaml
     |-puppet.interview.webperfdev.com.yaml
     |-web1.interview.webperfdev.com.yaml
     |-web2.interview.webperfdev.com.yaml

Add ntp specific config to each of these.

Inside manifests/nodes.pp, include ntp in each of the nodes

To apply configuration, run puppet agent -t on all nodes.

Ideally, there should have been spec tests for this module, I couldnt add it due to lack of time.


# Phase2- Mediawiki

Install puppet module for mysql and apache, run puppet module install puppetlabs-apache --version 3.2.0
puppet module install puppetlabs-mysql. There is a profile to manage mysql, in modules/profile.

Since all the modules for mediawiki on puppet-forge were old and unmaintained, I decided to configure mediawiki using wget in roles and profiles. I created a role mediawiki that includes a profile, mediawiki responsible for configurations related to apache, php and mediawiki .
 In profile mediawiki, I import classes apache, mod_php and wget, install required php modules, download mediawiki, unzip, move it to docroot of Apache. I also mediawiki in profiles/mediawiki.pp passing in the necessary db and user configuration. Mediawiki, for isntallation, requires a user with ALL priviledges, hence  I create two users called wiki and install_wiki in data/nodes/db.interview.webperfdev.com.yaml
