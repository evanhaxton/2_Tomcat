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

# create the target directory
# sudo mkdir /opt/tomcat
directory '/opt/tomcat' do
  group 'tomcat'
  not_if { ::File.exist?('/opt/tomcat') }
end

# download tomcat install
# cd /tmp
# wget http://apache.cs.utah.edu/tomcat/tomcat-8/v8.5.20/bin/apache-tomcat-8.5.20.tar.gz
remote_file '/tmp/apache-tomcat-8.5.29.tar.gz' do
  source 'https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.29/bin/apache-tomcat-8.5.29.tar.gz'
  notifies :run, 'execute[tomcat_deploy]', :immediately
  not_if { ::File.exist?('/tmp/apache-tomcat-8.5.29.tar.gz') }
end

# deploy tomcat
execute 'tomcat_deploy' do
  command 'sudo tar xvf /tmp/apache-tomcat-8.5.29.tar.gz -C /opt/tomcat --strip-components=1'
  not_if { ::File.exist?('/opt/tomcat/conf') }
end

# recursively change the group to tomcat
# sudo chgrp -R tomcat /opt/tomcat
execute 'group_permissions' do
  command 'chgrp -R tomcat /opt/tomcat'
  not_if { ::File.exist?('/etc/systemd/system/tomcat.service') }
end

# sudo chmod g+x conf
directory '/opt/tomcat/conf' do
  mode '0650'
  not_if { ::File.exist?('/etc/systemd/system/tomcat.service') }
end

# sudo chmod -R g+r conf
execute 'conf_permissions' do
  command 'chmod -R g+r /opt/tomcat/conf'
  not_if { ::File.exist?('/etc/systemd/system/tomcat.service') }
end

# Change ownership to specific directories
# $ sudo chown -R tomcat webapps/ work/ temp/ logs/
%w( webapps work temp logs ).each do |path|
  directory "/opt/tomcat/#{path}" do
    owner 'tomcat'
    not_if { ::File.exist?('/etc/systemd/system/tomcat.service') }
  end
end

# Create and source Tomcat service
# sudo vi /etc/systemd/system/tomcat.service
template '/etc/systemd/system/tomcat.service' do
  source 'tomcat.service.erb'
end

# start tomcat service
# sudo systemctl daemon-reload
# sudo systemctl start tomcat
# sudo systemctl enable tomcat
service 'tomcat' do
  action [:enable, :start]
end
