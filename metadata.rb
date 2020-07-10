name 'nextcloud'
maintainer 'Nghiem Ba Hieu'
maintainer_email 'hi3unb@gmail.com'
license 'Apache-2.0'
description 'Installs/Configures nextcloud'
long_description 'Installs/Configures nextcloud'
version '0.1.0'
chef_version '>= 13.0'

depends 'mariadb', '~> 3.2.0'
depends 'selinux_policy', '~> 2.0'

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/nextcloud/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/nextcloud'
