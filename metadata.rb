name 'cloudwatch-logs'
maintainer 'Staurt Wong'
maintainer_email 'cgs.wong@gmail.com'
license 'Apache-2.0'
description 'Install and configure AWS CloudWatch Logs Agent'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.0.2'

recipe 'cloudwatch-logs', 'Includes the service recipe by default.'
recipe 'cloudwatch-logs::install', 'Install AWS CloudWatch Log Agent.'
recipe 'cloudwatch-logs::config', 'Configures AWS CloudWatch Log Agent service.'

source_url 'https://github.com/cgswong/chef-cloudwatch-logs' if respond_to? :source_url
issues_url 'https://github.com/cgswong/chef-cloudwatch-logs/issues' if respond_to? :issues_url

%w[amazon centos ubuntu].each do |os|
  supports os
end

chef_version '>= 12.11'
