#
# Cookbook Name:: openstack-dashboard
# Attributes:: default
#
# Copyright 2012, AT&T, Inc.
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
#

# Set to some text value if you want templated config files
# to contain a custom banner at the top of the written file
default["openstack-dashboard"]["custom_template_banner"] = "
# This file autogenerated by Chef
# Do not edit, changes will be overwritten
"

default["openstack-dashboard"]["debug"] = false

# This user's password is stored in an encrypted databag
# and accessed with openstack-common cookbook library's
# db_password routine.
default["openstack-dashboard"]["db"]["username"] = "dash"

# The Keystone role used by default for users logging into the dashboard
default["openstack-dashboard"]["keystone_default_role"] = "Member"

# This is the name of the Chef role that will install the Keystone Service API
default["openstack-dashboard"]["keystone_service_chef_role"] = "keystone"

default["openstack-dashboard"]["server_hostname"] = nil
default["openstack-dashboard"]["use_ssl"] = true
default["openstack-dashboard"]["ssl"]["cert"] = "horizon.pem"
default["openstack-dashboard"]["ssl"]["key"] = "horizon.key"

default["openstack-dashboard"]["swift"]["enabled"] = "False"

default["openstack-dashboard"]["theme"] = "default"

case node["platform"]
when "fedora", "centos", "redhat"
  default["openstack-dashboard"]["ssl"]["dir"] = "/etc/pki/tls"
  default["openstack-dashboard"]["local_settings_path"] = "/etc/openstack-dashboard/local_settings"
  # TODO(shep) - Fedora does not generate self signed certs by default
  default["openstack-dashboard"]["platform"] = {
    "horizon_packages" => ["openstack-dashboard", "MySQL-python"],
    "package_overrides" => ""
  }
when "ubuntu"
  default["openstack-dashboard"]["ssl"]["dir"] = "/etc/ssl"
  default["openstack-dashboard"]["local_settings_path"] = "/etc/openstack-dashboard/local_settings.py"
  default["openstack-dashboard"]["platform"] = {
    "horizon_packages" => ["lessc","openstack-dashboard", "python-mysqldb"],
    "package_overrides" => "-o Dpkg::Options::='--force-confold' -o Dpkg::Options::='--force-confdef'"
  }
end

default["openstack-dashboard"]["dash_path"] = "/usr/share/openstack-dashboard/openstack_dashboard"
default["openstack-dashboard"]["stylesheet_path"] = "/usr/share/openstack-dashboard/openstack_dashboard/templates/_stylesheets.html"
default["openstack-dashboard"]["wsgi_path"] = node["openstack-dashboard"]["dash_path"] + "/wsgi/django.wsgi"
default["openstack-dashboard"]["session_backend"] = "memcached"

default["openstack-dashboard"]["ssl_offload"] = "false"
default["openstack-dashboard"]["plugins"] = nil
