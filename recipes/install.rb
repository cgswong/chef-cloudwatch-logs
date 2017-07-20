#
# Cookbook:: cloudwatch-logs
# Recipe:: install

include_recipe 'cloudwatch-logs::_common'

# Create Agent directories even if not yet installed
%w[node['cwlogs']['setup_home'] agent_inc_dir].each do |dir|
  directory dir do
    owner 'root'
    group 'root'
    mode '0755'
    recursive true
    action :create
  end
end

# Download AWS configuration file
template aws_cfg_file do
  source 'aws.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    cwlogs_region: node['cwlogs']['region']
  )
end

# Download setup script that will install AWS CloudWatch Logs Agent
remote_file "#{node['cwlogs']['setup_home']}/awslogs-agent-setup.py" do
  source 'https://s3.amazonaws.com/aws-cloudwatch/downloads/latest/awslogs-agent-setup.py'
  owner 'root'
  group 'root'
  mode '0755'
  notifies :restart, 'service[awslogs]', :delayed
end

# Install AWS CloudWatch Logs Agent
execute 'Install CloudWatch Logs Agent' do
  command "#{node['cwlogs']['setup_home']}/awslogs-agent-setup.py \
  --non-interactive --region #{node['cwlogs']['region']} \
  --configfile #{aws_cfg_file}"
  not_if { system 'pgrep -f aws-logs-agent-setup >/dev/null' }
end

# Restart the agent service in the end to ensure that
# the agent will run with the custom configurations
service 'awslogs' do
  supports :restart => true, :status => true, :start => true, :stop => true
  action :nothing
end
