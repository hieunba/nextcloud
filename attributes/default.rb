default['nextcloud']['mysql_password'] = 'change-me'
default['nextcloud']['source'] = 'https://download.nextcloud.com/server/releases/nextcloud-18.0.4.tar.bz2'
default['nextcloud']['checksum'] = 'fad8e12632b352247ffc5ae181d4e414d732b9072caa0401774cfdb93a714329'

default['nextcloud']['config']['webroot'] = '/var/www/nextcloud/'

default['nextcloud']['config']['dbtype'] = 'mysql'
default['nextcloud']['config']['dbname'] = 'nextcloud'
default['nextcloud']['config']['dbhost'] = '127.0.0.1:3306'
default['nextcloud']['config']['dbuser'] = 'ocuser'
default['nextcloud']['config']['dbpassword'] = node['nextcloud']['mysql_password']
default['nextcloud']['config']['trusted_domains'] = ['localhost']
default['nextcloud']['config']['cloud_domain'] = 'localhost'
default['nextcloud']['config']['datadirectory'] = ::File.join(node['nextcloud']['config']['webroot'], 'data')

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
