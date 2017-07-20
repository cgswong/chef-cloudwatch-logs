#
# Cookbook:: cloudwatch-logs
# Resources:: cwlogs

resource_name :cwlogs if respond_to?(:resource_name)
provides :cwlogs if respond_to?(:provides)

actions :add, :remove
default_action :add if defined?(default_action)

attribute :name, :kind_of => String, :name_attribute => true
attribute :cookbook, :kind_of => String, :default => 'cloudwatch-logs'
attribute :log, :kind_of => Hash, :required => true, :default => {}
