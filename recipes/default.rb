#
# Cookbook:: 2_Tomcat
# Recipe:: default
#
# Copyright:: 2018, Evan Haxton, All Rights Reserved.

# Install Java
package 'java-1.7.0-openjdk-devel'

# Add tomcat group
execute 'tomcat_group_add' do
  command 'sudo groupadd tomcat'
  creates '/home/vagrant/.addTomcatGroup'
  not_if { ::File.exist?('/home/vagrant/.addTomcatGroup') }
end

# Add tomcat user
execute 'tomcat_user_add' do
  command 'sudo useradd -M -s /bin/nologin -g tomcat -d /opt/tomcat tomcat'
  creates '/home/vagrant/.addTomcatUser'
  not_if { ::File.exist?('/home/vagrant/.addTomcatUser') }
end
