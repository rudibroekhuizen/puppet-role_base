#!/bin/sh

# Update the system
#sudo apt-get update -y
#sudo apt-get upgrade -y

# Install Puppet and Git on osfamily debian
if [ -f /usr/bin/dpkg ];then
  wget http://apt.puppetlabs.com/puppetlabs-release-stable.deb
  dpkg -i puppetlabs-release-stable.deb
  apt-get --yes --quiet update
  apt-get --yes -o Dpkg::Options::="--force-confold" --quiet install git puppet-common ruby1.9.1 libaugeas-ruby
fi

# Install Puppet and Git on osfamily redhat
if [ -f /bin/rpm ];then
  rpm -Uhv --force http://yum.puppetlabs.com/el/6/products/x86_64/puppetlabs-release-6-7.noarch.rpm
  curl -O http://apt.sw.be/redhat/el6/en/x86_64/extras/RPMS/git-1.7.10-1.el6.rfx.x86_64.rpm
  curl -O http://apt.sw.be/redhat/el6/en/x86_64/extras/RPMS/perl-Git-1.7.10-1.el6.rfx.x86_64.rpm
  yum -y install perl-DBI rsync
  rpm -i --force git-1.7.10-1.el6.rfx.x86_64.rpm perl-Git-1.7.10-1.el6.rfx.x86_64.rpm
  yum -y install puppet
fi

# Install r10k
if [ ! `gem list r10k` ];then
  gem install r10k
fi

# Download modules from Git and Puppetforge
curl https://raw.githubusercontent.com/rudibroekhuizen/puppet-role_base/master/files/Puppetfile > /etc/puppet/Puppetfile
PUPPETFILE=/etc/puppet/Puppetfile PUPPETFILE_DIR=/etc/puppet/modules r10k --verbose 3 puppetfile install

# Copy hiera.yaml to /etc/puppet for hiera configuration settings
curl https://raw.githubusercontent.com/rudibroekhuizen/puppet-base/master/files/hiera.yaml > /etc/puppet/hiera.yaml

# Copy global.yaml to /etc/puppet/hieradata, which contains userdata
#mkdir /etc/puppet/hieradata && curl https://raw.githubusercontent.com/rudibroekhuizen/puppet-role_base/master/files/global.yaml > /etc/puppet/hieradata/global.yaml
cp /etc/puppet/modules/role_base/files/*.yaml /etc/puppet/hieradata

# Set role (optional), using custom fact
export FACTER_data_source=workstation.yaml
facter | grep data_source

# Apply base module
puppet apply -e 'include role_base'

# Apply additional modules
#puppet apply -e 'include [ 'role_logstash', 'role_elasticsearch' ]'
