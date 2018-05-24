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
