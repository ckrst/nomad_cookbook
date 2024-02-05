
template '/etc/nomad.d/server.hcl' do
    owner 'root'
    group 'root'
    variables tplvars: {
        bootstrap_expect => 3,
    }
    notifies :action, service[nomad.service], :immediatly
end