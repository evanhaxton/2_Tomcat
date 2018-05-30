# 2_Tomcat

This cookbook installs and configures a simple web site using the Tomcat application server

Usage
=====

Add 'tomcat' to your node's run list.

Requirements
============
Supports only CentOS or other RHEL variants at this time.
It is expected that ChefDK, chef-client and inspec are installed on the testing platform

The components that this cookbook were tested against were as follows

Chef Development Kit Version: 2.5.3
chef-client version: 13.8.5
berks version: 6.3.1
kitchen version: 1.20.0
inspec version: 1.51.21

The Chef Development Kit may be downloaded at https://downloads.chef.io/chefdk/3.0.36
Inspec may be downloaded at https://www.inspec.io/downloads/

Please note that git is a requirement for the deployment of Chef.

Optionally Vagrant may be downloaded at https://www.vagrantup.com/downloads.html.  
This is not a requirement for the operation of the cookbook however this utility can be
useful if other configuration options are to be considered for the deployment.

Please note that testing was conducted on a Mac utilizing Oracle VirtualBox Manager version 5.2.12.  Downloads for this utility can be found at https://www.virtualbox.org/wiki/Downloads.
Also note that this is an optional utility as testing can be conducted utilizing the chef-client.  Please consult the chef documentation at https://docs.chef.io/ for further details

Testing
=======

This cookbook was developed utilizing test kitchen and Vagrant.  During each run,
the resulting server is deployed to VirtualBox.

To run the test, please be in the 1_MongoDB directory

A `.kitchen.yml` file is provided. Run `kitchen test` to verify this cookbook.

The kitchen test cycle is composed of the following steps:  

o `kitchen converge`.  This creates an instance of the deployed image

o `kitchen verify`.    This command verifies that the deployed instance is operating as expected.

o `kitchen destroy`.   Will remove the deployed instance


Optional commands:

o `kitchen login`      Will allow the user to connect to a deployed image


Environment validation
======================

o Login into the deployed instance utilizing `kitchen login`
o Run `curl localhost:8080` to produce.  The test is also validated as part of the test cycle.

Apache Tomcat/8.5.29 Documentation page
