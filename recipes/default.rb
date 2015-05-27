#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

package "apache2"

#require 'pry'
#binding.pry

index_filepath = "/var/www/html/index.html"

#case node["platform_version"]
#when "12.04"
#  index_filepath = "/var/www/index.html"
#when "14.04"
#  index_filepath = "/var/www/html/index.html"
#when
#  index_filepath = "BLBLLLLLLLLLLLLLLLLOOWOOWW UP!"
#end

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
