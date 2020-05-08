#
# Cookbook:: nextcloud
# Recipe:: default
#
# Copyright:: 2020, Nghiem Ba Hieu
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

package %w[policycoreutils-python-utils mlocate
          epel-release bash-completion bzip2] do
  action :install
end

package 'httpd'

service 'httpd' do
  action %i[enable start]
end

remi_pkg_local_path = "#{Chef::Config[:file_cache_path]}/remi-release-8.rpm"

remote_file remi_pkg_local_path do
  source 'https://rpms.remirepo.net/enterprise/remi-release-8.rpm'
  action :create
end

package 'remi-release' do
  source remi_pkg_local_path
  action :install
end

execute 'install php:remi-7.4 module' do
  command 'dnf module install -y php:remi-7.4'
  not_if 'dnf module --installed list php:remi-7.4'
end

package %w[php php-gd php-mbstring php-intl
  php-pecl-apcu php-mysqlnd
  php-opcache php-json php-pecl-zip] do
  action :install
end

service 'php-fpm' do
  action %i[enable start]
end

mariadb_repository 'install'

mariadb_server_install 'package' do
  action [:install, :create]
  password node['nextcloud']['mysql_password']
end

mariadb_user node['nextcloud']['config']['dbuser'] do
  database_name node['nextcloud']['config']['dbname']
  password node['nextcloud']['mysql_password']
  ctrl_password node['nextcloud']['mysql_password']
  action :create
end

mariadb_database node['nextcloud']['config']['dbname'] do
  user node['nextcloud']['config']['dbuser']
  password node['nextcloud']['mysql_password']
  encoding 'utf8mb4'
  collation 'utf8mb4_general_ci'
  sql 'flush privileges'
  action :create
end

require 'uri'
parsed_uri = URI.parse(node['nextcloud']['source'])
nextcloud_filename = parsed_uri.request_uri.gsub(/\/server\/releases\//, '')

nextcloud_artifact_local_path = "#{Chef::Config[:file_cache_path]}/#{nextcloud_filename}"

remote_file nextcloud_artifact_local_path do
  source node['nextcloud']['source']
  checksum node['nextcloud']['checksum'] if node['nextcloud']['checksum']
  action :create
end

nextcloud_config_path = '/var/www/nextcloud/config/config.php'
nextcloud_autoconfig_path = '/var/www/nextcloud/config/autoconfig.php'
nextcloud_objectstore_config_path = '/var/www/nextcloud/config/objectstore.config.php'

directory '/var/www' do
  owner 'root'
  group 'root'
  mode 0o755
  action :create
end

execute 'extract nextcloud artifact' do
  command "tar xf #{nextcloud_artifact_local_path} -C /var/www/"
  creates nextcloud_config_path
end

execute 'update permissions for nextcloud directory' do
  command "chown -R apache: /var/www/nextcloud"
  creates nextcloud_config_path
end

directory '/var/www/nextcloud/data' do
  owner 'apache'
  group 'apache'
  mode 0o770
  action :create
end

execute 'allow httpd connect to database' do
  command "setsebool -P httpd_can_network_connect on"
end

template nextcloud_config_path do
  source 'config.php.erb'
  owner 'apache'
  group 'apache'
  mode 0o640
  variables(
    dbtype: node['nextcloud']['config']['dbtype'],
    dbname: node['nextcloud']['config']['dbname'],
    dbhost: node['nextcloud']['config']['dbhost'],
    dbuser: node['nextcloud']['config']['dbuser'],
    dbpassword: node['nextcloud']['config']['dbpassword']
  )
  action :delete
end

template nextcloud_objectstore_config_path do
  source 'objectstore.config.php.erb'
  owner 'apache'
  group 'apache'
  mode 0o640
  action :create
end

template nextcloud_autoconfig_path do
  source 'autoconfig.php.erb'
  owner 'apache'
  group 'apache'
  mode 0o640
  variables(
    dbtype: node['nextcloud']['config']['dbtype'],
    dbname: node['nextcloud']['config']['dbname'],
    dbhost: node['nextcloud']['config']['dbhost'],
    dbuser: node['nextcloud']['config']['dbuser'],
    dbpassword: node['nextcloud']['config']['dbpassword']
  )
  action :create
  not_if { ::File.exist?(nextcloud_config_path) }
end

template '/etc/httpd/conf.d/cloud.conf' do
  source 'nextcloud.conf.erb'
  owner 'root'
  group 'root'
  mode 0o775
  action :create
  notifies :reload, 'service[httpd]', :delayed
end
