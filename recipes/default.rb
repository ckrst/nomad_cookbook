#
# Cookbook:: nomad_cookbook
# Recipe:: default
#
# Copyright:: 2022, The Authors, All Rights Reserved.

user 'nomad'
group 'nomad'

remote_file "#{Chef::Config[:file_cache_path]}/nomad.zip" do
    source "https://releases.hashicorp.com/nomad/#{node['nomad']['version']}/nomad_#{node['nomad']['version']}_linux_#{node['nomad']['architecture']}.zip"
    owner 'root'
    group 'root'
    mode '0755'
    action :create
    not_if { ::File.exist?("#{Chef::Config[:file_cache_path]}/nomad.zip") }
end

archive_file 'nomad' do
    path "#{Chef::Config[:file_cache_path]}/nomad.zip"
    destination '/tmp/nomad'
    action :extract
    not_if { ::File.exist?("/tmp/nomad") }
end

bash 'move_nomad' do
    cwd '/usr/local/bin'
    code <<-EOH
        cp /tmp/nomad /usr/local/bin/nomad
    EOH
    not_if { ::File.exist?('/usr/local/bin/nomad') }
end

template '/etc/systemd/system/nomad.service' do
    source 'nomad.service.erb'
    owner 'root'
    group 'root'
    mode '0755'
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

template '/etc/nomad.d/server.hcl' do
    owner 'root'
    group 'root'
end

template '/etc/nomad.d/client.hcl' do
    owner 'root'
    group 'root'
end

service 'nomad.service' do
    supports status: true, restart: true, reload: true
    action [:enable, :start]
end



