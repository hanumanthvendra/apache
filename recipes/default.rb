#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

package "apache2"

# This is the magical one liner that allows you to halt the tests and examine the recipe.
# require 'pry' ; binding.pry

index_filepath = "/var/www/html/index.html"

# Case Statment Example

if node["platform_version"] == "12.04"
  index_filepath = "/var/www/index.html"
end

file index_filepath do
  owner "root"
  group "root"
  mode "0644"
  content "Hello, world!"
end

service "apache2" do
  action [ :start, :enable ]
end


config_filepath = "/etc/apache2/conf-enabled"

if node["platform_version"] == "12.04"
  config_filepath = "/etc/apache2/conf.d"
end


## Admin

apache_vhost "admin" do
  config_file "#{config_filepath}/admin.conf"
  port 8080
  document_root "/var/www/admin/html"
  content "Welcome Admin!"
  action :create
end

# PowerUsers, 8000

# Create a configuration Template
# Create a Directory for our HTML
# Create that index HTML

# apache_vhost "powerusers" do
#   config_file "powerusers.conf"
#   port 8000
#   document_root "/var/www/powerusers/html"
#   content "Welcome Powerusers!"
# end

template "#{config_filepath}/powerusers.conf" do
  source "config.erb"
  variables(port: 8000,document_root: "/var/www/powerusers/html")
  notifies :restart, "service[apache2]"
end

directory "/var/www/powerusers/html" do
  recursive true
end

file "/var/www/powerusers/html/index.html" do
  content "Welcome Powerusers!"
end

  # new_resource.name # 'superlions'
  # new_resource.config_file # 'superlions.conf'
  # new_resource.port # 7000
  # new_resource.document_root # /var/www/...
  # new_resource.content # 'Welcome Superlions!'



#SuperLions, 7000

apache_vhost "superlions" do
  config_file "#{config_filepath}/superlions.conf"
  port 7000
  document_root "/var/www/superlions/html"
  content "Welcome Superlions!"
  action :create
end