#!/usr/bin/env bash
#
# This script installs Puppet 5.x, bundler and ruby on Ubuntu and Centos.
#
### Code start ###
function provision_ubuntu {
  # Get release info
  if [ -f /etc/lsb-release ]; then
    . /etc/lsb-release
  else
    DISTRIB_CODENAME=$(lsb_release -c -s)
  fi
  
  REPO_DEB_URL="https://apt.puppetlabs.com/puppet5-nightly/puppet5-nightly-release-${DISTRIB_CODENAME}.deb"
  AGENTNAME="puppet-agent"
   
  echo "Update the system"
  sudo apt-get update -y
    
  echo "Set locale"
  sudo locale-gen nl_NL.UTF-8
    
  echo "Configuring PuppetLabs repo..."
  REPO_DEB_PATH=$(mktemp)
  wget --output-document="${REPO_DEB_PATH}" "${REPO_DEB_URL}" 2>/dev/null
  sudo dpkg -i "${REPO_DEB_PATH}" >/dev/null
  echo "Install ruby ppa"
  sudo apt-get install -y software-properties-common >/dev/null
  sudo apt-add-repository -y ppa:brightbox/ruby-ng >/dev/null
  sudo apt-get update >/dev/null
    
  echo "Installing Puppet..."
  sudo apt-get -y install git $AGENTNAME >/dev/null
  sudo apt-get -y install ruby2.2 ruby2.2-dev bundler libxslt-dev libxml2-dev zlib1g-dev >/dev/null
  #sudo apt-get -y install rubygems >/dev/null
  sudo gem install r10k --no-rdoc --no-ri

  echo "Create symlinks"
  FILES="/opt/puppetlabs/bin/*"
  for f in $FILES
  do
    filename="${f##*/}"
    sudo ln -f -s "$f" "/usr/local/bin/${filename}"
  done
  
  # Install curl
  sudo apt-get -y install curl
  return 0
}

function provision_rhel() {
  echo "Get release info"
  grep -i "7" /etc/redhat-release
  if [ $? -eq 0 ]; then
    RHMAJOR=7
  fi
  grep -i "6" /etc/redhat-release
  if [ $? -eq 0 ]; then
    RHMAJOR=6
  fi
  REPO_RPM_URL="https://yum.puppetlabs.com/puppet5/puppet5-release-el-${RHMAJOR}.noarch.rpm"
  #REPO_RPM_URL="http://yum.puppetlabs.com/puppetlabs-release-pc1-el-${RHMAJOR}.noarch.rpm"
  AGENTNAME="puppet-agent"

  sudo yum install -y wget git > /dev/null

  echo "Configuring PuppetLabs repo..."
  repo_rpm_path=$(mktemp)
  wget --output-document="${repo_rpm_path}" "${REPO_RPM_URL}" 2>/dev/null
  sudo rpm -i "${repo_rpm_path}" >/dev/null

  echo "Installing Puppet..."
  sudo yum install -y $AGENTNAME >/dev/null
  sudo /opt/puppetlabs/puppet/bin/gem install r10k
  sudo ln -s /opt/puppetlabs/puppet/bin/r10k /usr/bin/

  echo "Set symlinks"
  FILES="/opt/puppetlabs/bin/*"
  for f in $FILES
  do
    filename="${f##*/}"
    sudo ln -f -s "$f" "/usr/bin/${filename}"
  done
  return 0
}

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
puppet apply -e 'include base'

# Apply manifest as noted in data_source yaml file, hiera_include includes classes from every level of the hiera hierarchy
if [ -n "$1" ];then
  #puppet apply -e 'hiera_include('classes')'
  puppet apply -e "lookup('classes', {merge => unique}).include"
fi
