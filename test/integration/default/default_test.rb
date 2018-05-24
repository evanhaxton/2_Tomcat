# Java should be installed
describe package('java-1.7.0-openjdk-devel') do
  it { should be_installed }
end

# Validate java installation is present
describe file('/usr/bin/java') do
  it { should exist }
end

# check if tomcat group exists
describe(command('cat /etc/group')) do
  its('stdout') { should match(/tomcat/) }
end

# check if tomcat group exists
describe(command('cat /etc/passwd')) do
  its('stdout') { should match(/tomcat/) }
end

# validate that wget is installed
describe package('wget') do
  it { should be_installed }
end

# make sure that the download is successful
describe file('/tmp/apache-tomcat-8.5.29.tar.gz') do
  it { should exist }
end

# check for existance of tomcat server
describe file('/opt/tomcat') do
  it { should exist }
end
