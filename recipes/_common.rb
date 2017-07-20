#
# Cookbook:: cloudwatch-logs
# Recipe:: common

# Variables
agent_etc_dir = "#{node['cwlogs']['agent_home']}/etc}"
agent_inc_dir = "#{agent_etc_dir}/config"
agent_state_file = "#{node['cwlogs']['agent_home']}/state/agent-state"
agent_cfg_file = "#{agent_etc_dir}/awslogs.conf"
awslogs_file = "#{agent_etc_dir}/cwlogs.conf"
aws_cfg_file = "#{agent_etc_dir}/aws.conf"

