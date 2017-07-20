#
# Cookbook:: cloudwatch-logs
# Attributes:: default

# AWS requirements
default['cwlogs']['region'] = 'us-east-1'

# AWS CloudWatch Logs
default['cwlogs']['setup_home'] = '/opt/aws/cloudwatch'
default['cwlogs']['agent_home'] = '/var/awslogs'
