#
# Cookbook:: chef-mongo-kitchen-vagrant
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Specifies APT repository information and adds an additional APT repository to the existing list of repositories
apt_repository 'mongodb-org' do
  # repo_name             String

  # The base of the Debian distribution.
  uri                   'https://repo.mongodb.org/apt/ubuntu'

  # Usually a distribution’s codename, such as trusty, xenial or bionic.
  distribution          'xenial/mongodb-org/3.6'

  # Package groupings, such as ‘main’ and ‘stable’. Default value: empty array.
  components            ['multiverse']
  
  arch                  'amd64,arm64'
  # trusted               True, False
  
  # Determines whether or not to add the repository as a source repo as well.
  deb_src               false
  
  # The GPG keyserver where the key for the repo should be retrieved.
  keyserver             'keyserver.ubuntu.com'
  
  # If a keyserver is provided, this is assumed to be the fingerprint; otherwise it can be either the URI of GPG key for the repo, or a cookbook_file.
  key                   '2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5'

  # key_proxy             String
  # cookbook              String
  # cache_rebuild         True, False
  # sensitive             True, False

  # Default. Creates a repository file at /etc/apt/sources.list.d/ and builds the repository listing.
  action :add
end

# Defines the update frequency for APT repositories
apt_update 'Update the apt cache daily' do
 # Determines how frequently (in seconds) APT repository updates are made.
 frequency 86_400

 # Update the Apt repository at the interval specified by the frequency property.
 action :update
end

# Installs the package.
package 'mongodb-org'

# Manages the state of a service.
service 'mongod' do
 # A list of properties that controls how the chef-client is to attempt to manage a service
 supports status: true

 # Identifies the steps the chef-client will take to bring the node into the desired state
 # Enables a service at boot and then starts the service
 action [:enable, :start]
end