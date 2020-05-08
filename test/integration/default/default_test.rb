# # encoding: utf-8

# Inspec test for recipe nextcloud::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

if os.redhat?
  %w[epel-release yum-utils unzip
    bash-completion policycoreutils-python-utils
    mlocate bzip2 curl wget].each do |require_pkg|
    describe package(require_pkg) do
      it { should be_installed }
    end
  end

  describe package('httpd') do
    it { should be_installed }
  end

  describe service('httpd') do
    it { should be_enabled }
    it { should be_running }
  end

  describe command('dnf repolist --repo remi') do
    its('exit_status') { should eq 0 }
  end

  describe command('dnf module --installed list php:remi-7.4') do
    its('exit_status') { should eq 0 }
  end

  %w[php php-gd php-mbstring php-intl
    php-pecl-apcu php-mysqlnd
    php-opcache php-json php-pecl-zip].each do |php_package|
    describe package(php_package) do
      it { should be_installed }
    end
  end

  describe package('MariaDB-server') do
    it { should be_installed }
  end

  describe service('mysql') do
    it { should be_enabled }
    it { should be_running }
  end

  describe file('/etc/httpd/conf.d/cloud.conf') do
    it { should exist }
    its('owner') { should cmp 'root' }
    its('group') { should cmp 'root' }
  end
end
