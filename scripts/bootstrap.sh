#!/bin/sh

# Install Puppet and Git on osfamily debian
if [ -f /usr/bin/dpkg ]
then
  wget http://apt.puppetlabs.com/puppetlabs-release-stable.deb
  dpkg -i puppetlabs-release-stable.deb
  apt-get --yes --quiet update
  apt-get --yes -o Dpkg::Options::="--force-confold" --quiet install git puppet-common ruby1.9.1 libaugeas-ruby
fi

# Install Puppet and Git on osfamily redhat
if [ -f /bin/rpm ]
then
  rpm -Uhv --force http://yum.puppetlabs.com/el/6/products/x86_64/puppetlabs-release-6-7.noarch.rpm
  curl -O http://apt.sw.be/redhat/el6/en/x86_64/extras/RPMS/git-1.7.10-1.el6.rfx.x86_64.rpm
  curl -O http://apt.sw.be/redhat/el6/en/x86_64/extras/RPMS/perl-Git-1.7.10-1.el6.rfx.x86_64.rpm
  yum -y install perl-DBI rsync
  rpm -i --force git-1.7.10-1.el6.rfx.x86_64.rpm perl-Git-1.7.10-1.el6.rfx.x86_64.rpm
  yum -y install puppet
fi

# Fetch base repository from Github
git clone https://github.com/rudibroekhuizen/puppet-base /etc/puppet/modules/base
git clone https://github.com/rudibroekhuizen/puppet-role_base /etc/puppet/modules/role_base

# Apply base module
puppet apply /etc/puppet/modules/role_base/tests/init.pp
