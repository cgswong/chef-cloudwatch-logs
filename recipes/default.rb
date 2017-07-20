#
# Cookbook:: cloudwatch-logs
# Recipe:: default

if node['ec2'].nil?
  log('Refusing to install CloudWatch Logs because this does not appear to be an EC2 instance.') { level :warn }
  return
end

if node['cwlogs']['region'].nil?
  log('AWS Region is necessary for this cookbook.') { level :error }
  return
end

# Install only if it is not installed
include_recipe 'cloudwatch-logs::install' unless ::File.exist?(node['cwlogs']['agent_home'])
# Always reconfigure AWS CloudWatch Logs configuration files
include_recipe 'cloudwatch-logs::config'
