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
end
