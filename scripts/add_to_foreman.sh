#!/bin/bash
#kind: finish
#name: Ubuntu ec2 Finish

#OS:
#- Debian 6.0
#- Debian 7.0
#- Ubuntu 10.04
#- Ubuntu 12.04
#- Ubuntu 13.04
#- CentOS 6

environment=1402production
hostname=$(hostname -f)

if [ "$hostname" = "" ]
then
  hostname=$(hostname)
  echo "Can not resolve fqdn, please enter fqdn of host: (example: $hostname.internal.domain)"
  read hostname
fi

cat << EOF > /etc/puppet/puppet.conf
#kind: snippet
#name: puppet.conf
[main]
vardir = /var/lib/puppet
logdir = /var/log/puppet
rundir = /var/run/puppet
ssldir = /var/lib/puppet/ssl

# Allow services in the 'puppet' group to access key (Foreman + proxy)
privatekeydir = \$ssldir/private_keys { group = service }
hostprivkey = \$privatekeydir/\$certname.pem { mode = 640 }

[agent]
pluginsync      = true
report          = true
ignoreschedules = true
daemon          = false
ca_server       = foreman.naturalis.nl
certname        = dummyhostname
environment     = production
server          = foreman.naturalis.nl

EOF

sed -i "s/^certname        = dummyhostname/certname        = $hostname/" /etc/puppet/puppet.conf
sed -i "s/production/$environment/" /etc/puppet/puppet.conf

if [ -f /bin/rpm ]
then
  chkconfig puppet on
fi

if [ -f /usr/bin/dpkg ]
then
  /bin/sed -i 's/^START=no/START=yes/' /etc/default/puppet
fi

/bin/touch /etc/puppet/namespaceauth.conf
/usr/bin/puppet agent --enable
/usr/bin/puppet agent --config /etc/puppet/puppet.conf
/etc/init.d/puppet restart
