# AWS CloudWatch Logs Cookbook

Install and configure [AWS CloudWatch Logs][aws-cloudwatch-url] Agent and deploy it's configurations automatically.

## Requirements

### Platforms

- Amazon Linux
- CentOS 7.x/RHEL 7.x
- Ubuntu 14.04, 16.04

### Chef

- Chef 12.11+

### Dependent Cookbooks

None.

## Attributes

See `attributes/default.rb` for the current default values as the listing below may not be current:

- `node['cwlogs']['region']` - Sets the AWS region in which the instance is located to run AWS CloudWatch Logs Agent. Default `us-east-1`.
- `node['cwlogs']['setup_home']` - Sets the location to install the AWS CloudWatch Logs Agent installer. Default `/opt/aws/cloudwatch`.
- `node['cwlogs']['agent_home']` - Sets the location or home (AGENT_HOME) for the AWS CloudWatch Logs Agent to store its configuration files. Default `/var/awslogs`.

## Recipes

### default

Checks if all necessary requirements are met, and afterwards will call `install`  and `configure` recipes.

### install

Installs AWS CloudWatch Logs Agent.

### configure

Prepares and configures all files required by AWS CloudWatch Logs.

## Usage

Add this cookbook to your base recipe:

```ruby
cookbook 'cloudwatch-logs', '~> 1.0.0'
```

You need to configure the following node attributes via an `environment` or `role`:

```ruby
default_attributes(
   'cwlogs' => {
      'region' => 'your_aws_region',
      'log' => {
         'syslog' => {
            'datetime_format' => '%b %d %H:%M:%S',
            'file' => '/var/log/syslog',
            'buffer_duration' => '5000',
            'log_stream_name' => '{instance_id}',
            'initial_position' => 'start_of_file',
            'log_group_name' => '/var/log/syslog'
         }
      }
   }
)
```

Or you can also configure by declaring it in another cookbook at a higher precedence level:

```ruby
default['cwlogs']['region'] = 'your_aws_region'
default['cwlogs']['log']['syslog'] = {
   'datetime_format' => '%b %d %H:%M:%S',
   'file' => '/var/log/syslog',
   'buffer_duration' => '5000',
   'log_stream_name' => '{instance_id}',
   'initial_position' => 'start_of_file',
   'log_group_name' => '/var/log/syslog'
}
```

**Note**: This cookbook makes no provision for using AWS credentials stored on the instance. We assume you are following best practices and using an AWS IAM Role assigned to the instance. 

Once you defined the attributes, you will need to reference `cwlogs` resource in your recipe:

```ruby
include_recipe 'cloudwatch-logs'

cwlogs 'syslog' do
  log node['cwlogs']['log']['syslog']
end

cwlogs 'messages' do
  log node['cwlogs']['log']['messages']
end
```

This will create unique configuration files in AWS CloudWatch Logs that will be stored in the `${AGENT_HOME}/etc/config` directory.

**Remember**: You can configure as many logs as you need with the `log` attribute.

## Example

The example attributes used previously will generate the AWS CloudWatch Logs configuration below:

```ini
[syslog]
datetime_format = %b %d %H:%M:%S
file = /var/log/syslog
buffer_duration = 5000
log_stream_name = {instance_id}
initial_position = start_of_file
log_group_name = /var/log/syslog
```

For more deployment details about AWS CloudWatch Logs, please visit the [AWS CloudWatch Logs Documentation](https://aws.amazon.com/documentation/cloudwatch).

## Resources

### cwlogs

The **cwlogs** resource is what the _config_ recipe calls under the hood to setup the log configuration files.

### Actions

- add
- remove

### Properties

- `name` - Name of the log configuration file.
- `log` - Log file setup details. A hash key/value pair following the [AWS CloudWatch Logs Agent Reference](http://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/AgentReference.html) format.

## Changes

See `CHANGELOG.md` for more details.

## License and Author

See `LICENSE` for more details.

## Trademark

Amazon Web Services and AWS are trademarks of Amazon.com, Inc. or its affiliates in the United States and/or other countries.

   [aws-cloudwatch-url]: https://aws.amazon.com/cloudwatch/
   [chef-cloudwatchlogs-license-url]: https://github.com/cgswong/chef-cloudwatch-logs/blob/markdown/LICENSE
   [chef-cloudwatchlogs-runtime-url]: https://github.com/cgswong/chef-cloudwatch-logs
