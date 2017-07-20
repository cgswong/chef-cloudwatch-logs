#
# Cookbook:: cloudwatch-logs
# Libraries:: matchers

if defined?(ChefSpec)
  def add_cwlogs(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:cwlogs, :add, resource_name)
  end

  def remove_cwlogs(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:cwlogs, :remove, resource_name)
  end
end
