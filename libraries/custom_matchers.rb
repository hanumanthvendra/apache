
if defined?(ChefSpec)
  ChefSpec.define_matcher :apache_vhost

  def create_apache_vhost(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:apache_vhost, :create, resource_name)
  end
end