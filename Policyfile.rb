# Policyfile.rb - Describe how you want Chef Infra Client to build your system.
#
# For more information on the Policyfile feature, visit
# https://docs.chef.io/policyfile/

# A name that describes what the system you're building with Chef does.
name 'nomad_cookbook'

# Where to find external cookbooks:
default_source :supermarket

# run_list: chef-client will run these recipes in the order specified.
run_list 'nomad_cookbook::default'

# Specify a custom source for a single cookbook:
cookbook 'nomad_cookbook', path: '.'
cookbook 'docker', '~> 11.3.0', :supermarket