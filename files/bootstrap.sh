#!/usr/bin/env bash
#
# This script installs puppet 3.x or 4.x on ubuntu and centos, installs bundler, ruby and the puppet module skeleton
#
# Usage:
# Ubuntu / Debian: wget https://raw.githubusercontent.com/pgomersbach/puppet-module-skeleton/master/install.sh; bash install.sh
#
# Red Hat / CentOS: curl https://raw.githubusercontent.com/pgomersbach/puppet-module-skeleton/master/install.sh -o bootstrap.sh; bash install.sh
# Options: add 3 as parameter to install 4.x release
# set -e
# default major version, comment to install puppet 3.x
PUPPETMAJORVERSION=4

### Code start ###
function provision_ubuntu {
    # get release info
    if [ -f /etc/lsb-release ]; then
      . /etc/lsb-release
    else
      DISTRIB_CODENAME=$(lsb_release -c -s)
    fi
    if [ $PUPPETMAJOR -eq 4 ]; then
      REPO_DEB_URL="http://apt.puppetlabs.com/puppetlabs-release-pc1-${DISTRIB_CODENAME}.deb"
      AGENTNAME="puppet-agent"
    else
      REPO_DEB_URL="http://apt.puppetlabs.com/puppetlabs-release-${DISTRIB_CODENAME}.deb"
      AGENTNAME="puppet"
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
    sudo apt-get -y install ruby2.2 ruby2.2-dev bundler libxslt-dev libxml2-dev zlib1g-dev >/dev/null
    return 0
}

function provision_rhel() {
    # Get release info
    grep -i "7" /etc/redhat-release
    if [ $? -eq 0 ]; then
      RHMAJOR=7
    fi
    grep -i "6" /etc/redhat-release
    if [ $? -eq 0 ]; then
      RHMAJOR=6
    fi
    if [ $PUPPETMAJOR -eq 4 ]; then
      REPO_RPM_URL="http://yum.puppetlabs.com/puppetlabs-release-pc1-el-${RHMAJOR}.noarch.rpm"
      AGENTNAME="puppet-agent"
    else
      REPO_RPM_URL="http://yum.puppetlabs.com/puppetlabs-release-el-${RHMAJOR}.noarch.rpm"
      AGENTNAME="puppet"
    fi
    sudo yum install -y wget git > /dev/null

    # Configure repos
    echo "Configuring PuppetLabs repo..."
    repo_rpm_path=$(mktemp)
    wget --output-document="${repo_rpm_path}" "${REPO_RPM_URL}" 2>/dev/null
    sudo rpm -i "${repo_rpm_path}" >/dev/null

    # Install puppet
    echo "Installing Puppet..."
    sudo yum install -y $AGENTNAME >/dev/null
    echo "Puppet installed!"
    echo "Install development packages"
    sudo yum install -y ruby2.2 ruby2.2-dev bundler libxslt-dev libxml2-dev zlib1g-dev >/dev/null
    return 0
}

if [ "$#" -gt 0 ]; then
   if [ "$1" = 3 ]; then
     PUPPETMAJOR=3
   else
     PUPPETMAJOR=4
  fi
else
  PUPPETMAJOR=$PUPPETMAJORVERSION
fi
echo $PUPPETMAJOR

grep -i "ubuntu" /etc/issue
if [ $? -eq 0 ]; then
    provision_ubuntu
fi
grep -i "Debian" /etc/issue
if [ $? -eq 0 ]; then
    provision_ubuntu
fi

if [ -f /etc/redhat-release ]; then
  grep -i "Red Hat" /etc/redhat-release
  if [ $? -eq 0 ]; then
      provision_rhel
  fi
  grep -i "CentOS" /etc/redhat-release
  if [ $? -eq 0 ]; then
      provision_rhel
  fi
fi

if [ $PUPPETMAJOR -eq 4 ]; then
    # make symlinks
    echo "Set symlinks"
    FILES="/opt/puppetlabs/bin/*"
    for f in $FILES
    do
      filename="${f##*/}"
      sudo ln -f -s "$f" "/usr/local/bin/${filename}"
    done
fi

# Install r10k
if [ ! `gem list r10k` ];then
  gem install r10k --no-rdoc --no-ri
fi

# Download modules from Git and Puppetforge
curl https://raw.githubusercontent.com/rudibroekhuizen/puppet-role_base/master/files/Puppetfile > /etc/puppet/Puppetfile
PUPPETFILE=/etc/puppet/Puppetfile PUPPETFILE_DIR=/etc/puppet/modules r10k --verbose info puppetfile install

# Copy hiera.yaml to /etc/puppet for hiera configuration settings
curl https://raw.githubusercontent.com/rudibroekhuizen/puppet-base/master/files/hiera.yaml > /etc/puppet/hiera.yaml

# Copy data sources to /etc/puppet/hieradata
mkdir -p /etc/puppet/hieradata
cp /etc/puppet/modules/role_base/files/*.yaml /etc/puppet/hieradata

# Create external fact to set primary data_source, using "meltwater/facts" module
# Better option: export FACTER_data_source=$1
if [ -n "$1" ];then
  #puppet apply -e 'facts::instance { 'data_source': value => '$1', }'
  mkdir -p /etc/facter/facts.d
  echo "data_source=$1" > /etc/facter/facts.d/data_source.txt
fi

# Apply base module
puppet apply -e 'include base'

# Apply additional modules
puppet apply -e 'hiera_include('classes')'
