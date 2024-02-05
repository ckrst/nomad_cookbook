template '/etc/nomad.d/client.hcl' do
    owner 'root'
    group 'root'
    notifies :action, service[nomad.service], :immediatly
end