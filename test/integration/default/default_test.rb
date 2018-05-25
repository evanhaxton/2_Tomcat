# Java should be installed
describe package('java-1.7.0-openjdk-devel') do
  it { should be_installed }
end

# Validate java installation is present
describe file('/usr/bin/java') do
  it { should exist }
end

# check if tomcat group exists
describe group('tomcat') do
  it { should exist }
end

# check if tomcat group exists
describe user('tomcat') do
  it { should exist }
  its('group') { should eq 'tomcat' }
end

# make sure that the download is successful
describe file('/tmp/apache-tomcat-8.5.29.tar.gz') do
  it { should exist }
end

# check for existance of tomcat server
describe file('/opt/tomcat') do
  it { should exist }
  it { should be_directory }
end

# check group permissions
describe file('/opt/tomcat/conf') do
  it { should exist }
  its('owner') { should eq 'root' }
  its('mode') { should cmp '0650' }
end

# check file permissions on specific directories
%w( webapps work temp logs ).each do |path|
    describe file ("/opt/tomcat/#{path}") do
      it { should exist }
      it { should be_owned_by 'tomcat' }
    end
end

# check on the status of Tomcat service
describe service('tomcat') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe command('curl http://localhost:8080') do
  its('stdout') { should match(/Tomcat/) }
end
