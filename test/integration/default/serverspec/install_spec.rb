# # encoding: utf-8

# Inspec test for recipe cloudwatch-logs::install

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

# Test for directories
describe file('/opt/aws/cloudwatch') do
  it { should be_directory }
end

describe file('/opt/aws/cloudwatch/awslogs-agent-setup.py') do
  it { should exist }
end

describe file('/var/awslogs/state') do
  it { should be_directory }
end

describe file('/var/awslogs/etc/config') do
  it { should be_directory }
end

describe service('awslogs') do
  it { should be_installed }
  it { should be_enabled }
end
