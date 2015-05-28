#
# Cookbook Name:: apache
# Recipe:: ohai_plugin
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

ohai "reload_apache_modules" do
  action :nothing
  plugin 'apache'
end

cookbook_file "#{node['ohai']['plugin_path']}/apache_modules.rb" do
  source "apache_modules.rb"
  notifies :reload, "ohai[reload_apache_modules]", :immediately
end

include_recipe "ohai::default"
