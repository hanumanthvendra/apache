require 'chefspec'
require 'chefspec/berkshelf'

RSpec.shared_examples "an apache server running an apache service" do
  it 'converges successfully' do
   chef_run
  end

  it 'installed the apache package' do
   expect(chef_run).to install_package('apache2')
  end

  it 'starts the apache service' do
   expect(chef_run).to start_service('apache2')
  end

  it 'enables the apache service' do
   expect(chef_run).to enable_service('apache2')
  end

  it 'create directory to host admin html files' do
    expect(chef_run).to create_directory("/var/www/admin/html")
  end

  it 'create index.html file for the admins see' do
    expect(chef_run).to create_file("/var/www/admin/html/index.html").with_content("Welcome Admin!")
  end

  it 'creates a template config at the create location' do
    expect(chef_run).to create_template(configuration_file).with(:variables => { :port => 8080, :document_root => "/var/www/admin/html"})
  end

  it 'creates the template config with the content I expect' do
    expect(chef_run).to render_file(configuration_file).with_content("Listen 8080")
    expect(chef_run).to render_file(configuration_file).with_content("DocumentRoot /var/www/admin/html")
  end

  it 'template notifies the apache service when it changes' do
    resource = chef_run.template(configuration_file)
    expect(resource).to notify("service[apache2]").to(:restart)
  end



  it 'creates a template config at the create location' do
    expect(chef_run).to create_template(power_users_configuration_file).with(:variables => { :port => 8000, :document_root => "/var/www/powerusers/html"})
  end

  it 'creates the template config with the content I expect' do
    expect(chef_run).to render_file(power_users_configuration_file).with_content("Listen 8000")
    expect(chef_run).to render_file(power_users_configuration_file).with_content("DocumentRoot /var/www/powerusers/html")
  end

  it 'template notifies the apache service when it changes' do
    resource = chef_run.template(power_users_configuration_file)
    expect(resource).to notify("service[apache2]").to(:restart)
  end


end