#
# Cookbook:: nomad_cookbook
# Recipe:: default
#
# Copyright:: 2022, The Authors, All Rights Reserved.

user 'nomad'
group 'nomad'

remote_file "/tmp/nomad.zip" do
    source "https://releases.hashicorp.com/nomad/#{node['nomad']['version']}/nomad_#{node['nomad']['version']}_linux_#{node['nomad']['architecture']}.zip"
    owner 'root'
    group 'root'
    mode '0755'
    action :create
    not_if { ::File.exist?("/tmp/nomad.zip") }
end

archive_file 'nomad' do
    path "/tmp/nomad.zip"
    destination '/usr/local/bin/'
    action :extract
    not_if { ::File.exist?("/usr/local/bin/nomad") }
end

directory '/etc/nomad.d' do
    owner 'root'
    group 'root'
    mode '0700'
end

template '/etc/nomad.d/nomad.hcl' do
    owner 'root'
    group 'root'
end

template '/etc/systemd/system/nomad.service' do
    source 'nomad.service.erb'
    owner 'root'
    group 'root'
    mode '0755'
end

service 'nomad.service' do
    supports status: true, restart: true, reload: true
    subscribes :reload, 'file[/etc/nomad]', :immediately
    action [:enable, :start]
end



