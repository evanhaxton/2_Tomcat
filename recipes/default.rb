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

# make sure that wget is installed
package 'wget'

# Download tomcat installation
execute 'tomcat_download' do
  command 'wget --directory-prefix=/tmp https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.29/bin/apache-tomcat-8.5.29.tar.gz'
  not_if { ::File.exist?('/tmp/apache-tomcat-8.5.29.tar.gz') }
end

# create tomcat directory
execute 'tomcat_directory' do
  command 'sudo mkdir /opt/tomcat'
  not_if { ::File.exist?('/opt/tomcat') }
end

# deploy tomcat
execute 'tomcat_download' do
  command 'sudo tar xvf /tmp/apache-tomcat-8.5.29.tar.gz -C /opt/tomcat --strip-components=1'
  not_if { ::File.exist?('/opt/tomcat/logs/catalina.out') }
end
