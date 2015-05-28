#
# Cookbook Name:: apache
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'apache::default' do
  context 'When all attributes are default, on ubuntu 12.04' do
     let(:chef_run) do
        runner = ChefSpec::ServerRunner.new(platform: 'ubuntu',
          version: '12.04',
          step_into: ['apache_vhost'])

       runner.converge(described_recipe)
     end

     let(:configuration_file) { "/etc/apache2/conf.d/admin.conf" }
     let(:power_users_configuration_file) { "/etc/apache2/conf.d/powerusers.conf" }
     let(:super_lions_configuration_file) { "/etc/apache2/conf.d/superlions.conf" }

     it_should_behave_like "an apache server running an apache service"

     it 'creates a file with correct attributes' do
       expect(chef_run).to create_file("/var/www/index.html").with(owner: "root", group: "root", mode: "0644")
     end

  end

  context 'When all attributes are default, on ubuntu 14.04' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu',
        version: '14.04',
        step_into: ['apache_vhost'])
      runner.converge(described_recipe)
    end

    let(:configuration_file) { "/etc/apache2/conf-enabled/admin.conf" }
    let(:power_users_configuration_file) { "/etc/apache2/conf-enabled/powerusers.conf" }
    let(:super_lions_configuration_file) { "/etc/apache2/conf-enabled/superlions.conf" }

    it_should_behave_like "an apache server running an apache service"

    it 'the index.html has the appropriate content' do
      expect(chef_run).to render_file('/var/www/html/index.html').with_content('Hello, world!')
    end

    it 'the index.html has the correct attributes' do
      expect(chef_run).to create_file('/var/www/html/index.html').with(:owner => "root", :group => "root", :mode => "0644")
    end

 end
end
