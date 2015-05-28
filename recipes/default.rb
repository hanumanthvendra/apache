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


directory "/var/www/admin/html" do
  recursive true
end

config_filepath = "/etc/apache2/conf-enabled"

if node["platform_version"] == "12.04"
  config_filepath = "/etc/apache2/conf.d"
end

template "#{config_filepath}/admin.conf" do
  source "config.erb"
  variables(port: 8080,document_root: "/var/www/admin/html")
  notifies :restart, "service[apache2]"
end

file "/var/www/admin/html/index.html" do
  content "Welcome Admin!"
end
