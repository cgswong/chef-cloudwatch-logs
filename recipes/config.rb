#
# Cookbook:: cloudwatch-logs
# Recipe:: config

agent_etc_dir = "#{node['cwlogs']['agent_home']}/etc"
agent_state_file = "#{node['cwlogs']['agent_home']}/state/agent-state"
agent_cfg_file = "#{agent_etc_dir}/awslogs.conf"
awslogs_file = "#{agent_etc_dir}/cwlogs.conf"
aws_cfg_file = "#{agent_etc_dir}/awscli.conf"

# Always update AWS configuration file
template aws_cfg_file do
  source 'awscli.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    cwlogs_region: node['cwlogs']['region']
  )
end

# Update log configuration file
template awslogs_file do
  source 'cwlogs.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

# Update main configuration file
template agent_cfg_file do
  source 'awslogs.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    cwlogs_state_file: agent_state_file,
    cwlogs_logcfg_file: awslogs_file
  )
end

# Restart AWS CloudWatch Logs Agent after the configuration files are updated
service 'awslogs' do
  supports :restart => true, :status => true, :start => true, :stop => true
  subscribes :restart, 'template [agent_cfg_file]', :delayed
  subscribes :restart, 'template [awslogs_file]', :delayed
  action [:enable, :restart]
end
