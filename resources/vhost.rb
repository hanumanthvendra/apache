# apache_vhost "powerusers" do
#   config_file "powerusers.conf"
#   port 8000
#   document_root "/var/www/powerusers/html"
#   content "Welcome Powerusers!"
#   action :create
# end

actions :create
default_action :create

attribute :config_file
attribute :port, :default => 8080
attribute :document_root
attribute :content