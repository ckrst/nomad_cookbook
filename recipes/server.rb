
template '/etc/nomad.d/server.hcl' do
    owner 'root'
    group 'root'
    variables tplvars: {
        'bootstrap_expect' => node['nomad']['server']['bootstrap_expect'],
    }
    notifies :action, service[nomad.service], :immediatly
end