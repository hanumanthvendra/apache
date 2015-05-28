use_inline_resources

action :create do
  # new_resource.name # 'superlions'
  # new_resource.config_file # '/etc/apache2/conf.d/superlions.conf'
  # new_resource.port # 7000
  # new_resource.document_root # /var/www/...
  # new_resource.content # 'Welcome Superlions!'

  # if new_resource.document_root
  #   document_root = new_resource.document_root
  # else
  #   document_root = "/var/www/#{new_resource.name}/html"
  # end

  document_root = new_resource.document_root || "/var/www/#{new_resource.name}/html"
  content = new_resource.content || "Welcome #{new_resource.name.capitalize}!"

  template new_resource.config_file do
    source "config.erb"
    variables(:port => new_resource.port,
      :document_root => document_root)
  end

  directory document_root do
    recursive true
  end

  file "#{document_root}/index.html" do
    content content
  end

end