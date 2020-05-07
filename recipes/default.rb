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
          epel-release bash-completion] do
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
