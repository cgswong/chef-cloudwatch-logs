#
# Cookbook:: cloudwatch-logs
# Providers:: cwlogs

provides :cwlogs if respond_to?(:provides)
use_inline_resources if defined?(use_inline_resources)

action :add do
  Chef::Log.debug "Adding configuration for #{new_resource.name}"
  template ::File.join(node['cwlogs']['agent_home'], 'etc/config', "#{new_resource.name}.conf") do
    owner 'root'
    mode '0644'
    source 'template.conf.erb'
    variables(
      log_name: new_resource.name,
      log_config: new_resource.log
    )
    cookbook new_resource.cookbook
    notifies :restart, 'service[awslogs]', :delayed
  end
end

action :remove do
  conf_path = ::File.join(node['cwlogs']['agent_home'], 'etc/config')
  Chef::Log.debug "Removing #{new_resource.name} from #{conf_path}"
  file ::File.join(node['cwlogs']['agent_home'], 'etc/config', "#{new_resource.name}.conf") do
    action :delete
    notifies :restart, 'service[awslogs]', :delayed
  end
end
