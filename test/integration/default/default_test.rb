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
end
