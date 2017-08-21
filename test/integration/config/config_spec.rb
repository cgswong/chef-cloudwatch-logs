# # encoding: utf-8

# Inspec test for recipe cloudwatch-logs::config

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

# Test for directories
describe file('/var/awslogs/etc/awscli.conf') do
  it { should exist }
end

describe file('/var/awslogs/etc/cwlogs.conf') do
  it { should exist }
end

describe file('/var/awslogs/etc/awslogs.conf') do
  it { should exist }
end

describe service('awslogs') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end
