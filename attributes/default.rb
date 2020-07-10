default['nextcloud']['mysql_password'] = 'change-me'
default['nextcloud']['version'] = '18.0.6'
default['nextcloud']['source'] = "https://download.nextcloud.com/server/releases/nextcloud-#{node['nextcloud']['version']}.tar.bz2"
default['nextcloud']['checksum'] = '3aa185f69c4e5ec7de3b3d5792003aeb4bd16a350865e447c9363019c69b15b2'

default['nextcloud']['config']['webroot'] = '/var/www/nextcloud/'

default['nextcloud']['config']['dbtype'] = 'mysql'
default['nextcloud']['config']['dbname'] = 'nextcloud'
default['nextcloud']['config']['dbhost'] = '127.0.0.1:3306'
default['nextcloud']['config']['dbuser'] = 'ocuser'
default['nextcloud']['config']['dbpassword'] = node['nextcloud']['mysql_password']
default['nextcloud']['config']['trusted_domains'] = ['localhost']
default['nextcloud']['config']['cloud_domain'] = 'localhost'
default['nextcloud']['config']['datadirectory'] = ::File.join(node['nextcloud']['config']['webroot'], 'data')
default['nextcloud']['config']['appsdirectory'] = ::File.join(node['nextcloud']['config']['webroot'], 'apps')

default['nextcloud']['config']['mail_smtpmode'] = 'smtp'
default['nextcloud']['config']['mail_sendmailmode'] = 'smtp'
default['nextcloud']['config']['mail_smtpmode'] = 'smtp'
default['nextcloud']['config']['mail_smtpauth'] = true
default['nextcloud']['config']['mail_smtpauthtype'] = 'LOGIN'
default['nextcloud']['config']['mail_smtphost'] = 'localhost'
default['nextcloud']['config']['mail_smtpport'] = 25
default['nextcloud']['config']['mail_smtptimeout'] = 10
default['nextcloud']['config']['mail_domain'] = 'example.com'
default['nextcloud']['config']['mail_from_address'] = 'nextcloud'
default['nextcloud']['config']['mail_smtpname'] = ''
default['nextcloud']['config']['mail_smtppassword'] = ''
