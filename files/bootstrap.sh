#!/usr/bin/env bash
#
# This script installs Puppet 4.x or 5.x on Ubuntu and Centos, installs bundler and ruby.
#
#
PUPPETMAJORVERSION=5

# Get release info
if [ -f /etc/lsb-release ]; then
    . /etc/lsb-release
else
  DISTRIB_CODENAME=$(lsb_release -c -s)
fi

# Check Puppet version
if [ $PUPPETMAJOR = 4 ]; then
  REPO_DEB_URL="http://apt.puppetlabs.com/puppetlabs-release-pc1-${DISTRIB_CODENAME}.deb"
  AGENTNAME="puppet-agent"
else
  REPO_DEB_URL="https://apt.puppetlabs.com/puppet5-release-${DISTRIB_CODENAME}.deb"
  AGENTNAME="puppet-agent"
fi
   
# Update the system
sudo apt-get update -y
    
# Set locale
sudo locale-gen nl_NL.UTF-8
    
# Configure repos
echo "Configuring PuppetLabs repo..."
repo_deb_path=$(mktemp)
wget --output-document="${repo_deb_path}" "${REPO_DEB_URL}" 2>/dev/null
sudo dpkg -i "${repo_deb_path}" >/dev/null
echo "Install ruby ppa"
sudo apt-get install -y software-properties-common >/dev/null
sudo apt-add-repository -y ppa:brightbox/ruby-ng >/dev/null
sudo apt-get update >/dev/null
    
# Install Puppet
echo "Installing Puppet..."
sudo apt-get -y install git $AGENTNAME >/dev/null
echo "Puppet installed!"
echo "Install development packages"
#sudo apt-get -y install ruby2.2 ruby2.2-dev bundler libxslt-dev libxml2-dev zlib1g-dev >/dev/null
sudo apt-get -y install rubygems >/dev/null

# Install r10k
if [ ! 'gem list r10k' ];then
  gem install r10k --no-rdoc --no-ri
fi

# Install curl
sudo apt-get -y install curl

# Download modules from Git and Puppetforge
curl https://raw.githubusercontent.com/rudibroekhuizen/puppet-role_base/master/files/Puppetfile > /etc/puppetlabs/puppet/Puppetfile
PUPPETFILE=/etc/puppetlabs/puppet/Puppetfile PUPPETFILE_DIR=/etc/puppetlabs/code/modules r10k --verbose debug puppetfile install

# Copy hiera.yaml to /etc/puppet for hiera configuration settings
curl https://raw.githubusercontent.com/rudibroekhuizen/puppet-base/master/files/hiera.yaml > /etc/puppetlabs/puppet/hiera.yaml

# Copy data sources to /etc/puppetlabs/puppet/data
mkdir -p /etc/puppetlabs/puppet/data
cp /etc/puppetlabs/code/modules/role_base/files/*.yaml /etc/puppetlabs/puppet/data

# Create external fact to set primary data_source
if [ -n "$1" ];then
  echo "data_source=$1" > /opt/puppetlabs/facter/facts.d/data_source.txt
fi

# Apply base module
/opt/puppetlabs/bin/puppet apply -e 'include base'

# Apply manifest as noted in data_source yaml file, hiera_include includes classes from every level of the hiera hierarchy
if [ -n "$1" ];then
  #puppet apply -e 'hiera_include('classes')'
  /opt/puppetlabs/bin/puppet apply -e "lookup('classes', {merge => unique}).include"
fi
