#
# Cookbook:: 2_Tomcat
# Recipe:: default
#
# Copyright:: 2018, Evan Haxton, All Rights Reserved.

# Install Java
package 'java-1.7.0-openjdk-devel'

# Add group tomcat
# sudo groupadd tomcat
group 'tomcat' do
  group_name 'tomcat'
end

# Add Tomcat User
# sudo useradd -M -s /bin/nologin -g tomcat -d /opt/tomcat tomcat
user 'tomcat' do
  manage_home false
  shell '/bin/nologin'
  group 'tomcat'
  home '/opt/tomcat'
end

# download tomcat install
remote_file '/tmp/apache-tomcat-8.5.29.tar.gz' do
  source 'https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.29/bin/apache-tomcat-8.5.29.tar.gz'
end

# create the target directory
# sudo mkdir /opt/tomcat
directory '/opt/tomcat' do
  group 'tomcat'
end

# deploy tomcat
execute 'tomcat_deploy' do
  command 'sudo tar xvf /tmp/apache-tomcat-8.5.29.tar.gz -C /opt/tomcat --strip-components=1'
  not_if { ::File.exist?('/opt/tomcat/logs/catalina.out') }
end

# recursively change the group to tomcat
# sudo chgrp -R tomcat /opt/tomcat
execute 'group_permissions' do
  command 'chgrp -R tomcat /opt/tomcat'
end

# sudo chmod g+x conf
directory '/opt/tomcat/conf' do
  mode '0650'
end

# sudo chmod -R g+r conf
execute 'conf_permissions' do
  command 'chmod -R g+r /opt/tomcat/conf'
end

# Change ownership to specific directories
# $ sudo chown -R tomcat webapps/ work/ temp/ logs/
%w( webapps work temp logs ).each do |path|
  directory "/opt/tomcat/#{path}" do
    owner 'tomcat'
  end
end
