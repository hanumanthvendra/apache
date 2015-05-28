
action :create do
  new_resource.name # 'superlions'
  new_resource.config_file # '/etc/apache2/conf.d/superlions.conf'
  new_resource.port # 7000
  new_resource.document_root # /var/www/...
  new_resource.content # 'Welcome Superlions!'

  template new_resource.config_file do
    source "config.erb"
    variables(:port => new_resource.port,
      :document_root => new_resource.document_root)
    notifies :restart, "service[apache2]"
  end

  directory new_resource.document_root do
    recursive true
  end

  file "#{new_resource.document_root}/index.html" do
    content new_resource.content
  end

end