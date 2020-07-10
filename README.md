# haproxy-vagrant-project
Demo project for setup load balancer with 2 web server 


# Prerequisites
1.  Install [Vagrant](http://www.vagrantup.com/downloads.html)
2.  Install [Virtualbox](https://www.virtualbox.org/wiki/Downloads)
3.  Either clone this repo with ``` git clone https://github.com/parthi9an/haproxy-vagrant-project.git ``` or just download the [current zip file](https://github.com/parthi9an/haproxy-vagrant-project/archive/master.zip) and extract it in an empty directory.

# What does the Vagrantfile do?
* It sets up a 3 VM mini-network inside Virtualbox.  
	- haproxy (192.168.56.1), 
	- web1 (192.168.56.11), 
	- web2 (192.168.56.12)
	
* It sets up the following port for haproxy interface:
    - HAProxy Admin Page - [http://localhost:8080/haproxy?stats](http://localhost:8080/haproxy?stats)
	- Load balancer Page - [http://localhost:8081/](http://localhost:8081/)

* It installs Apache on the two web servers, and configures it with a index page that identifies which host you're viewing the page on.
* It installs HAProxy on the haproxy host, and integrated with the two webservers pre-configured. 

# Getting started
1.  Open 3 terminal windows -- one for each host.  Change to the directory containing the Vagrantfile.
2.  In terminal #1, run ``` vagrant up haproxy && vagrant ssh haproxy ```
3.  In terminal #2, run ``` vagrant up web1 && vagrant ssh web1 ```
4.  In terminal #3, run ``` vagrant up web2 && vagrant ssh web2 ```
5.  Open up HAProxy admin page for the stats [http://localhost:8080/haproxy?stats](http://localhost:8080/haproxy?stats).
6.  Open up Load balancer interface to see the web application[http://localhost:8081/](http://localhost:8081/). 
7.  Open up [http://192.168.56.11/](http://192.168.56.11/) in a browser to see if web1's Apache is working.
8.  Open up [http://192.168.56.12/](http://192.168.56.12/) in a browser to see if web2's Apache is working.
5.  To stop Apache on one of the webservers to simulate an outage, run ``` sudo service apache2 stop ```  To start it again, run ``` sudo service apache2 start ```
7.  To make changes to haproxy, edit the config file with ``` sudo nano /etc/haproxy/haproxy.cfg ```  When you want to apply the changes, run ``` sudo service haproxy reload ```  If you break things and want to reset back, just run ``` sudo cp /etc/haproxy/haproxy.cfg.orig /etc/haproxy/haproxy.cfg && sudo service haproxy reload ```
8.  When you're all done, type ``` exit ``` at the shell to get back to your local terminal.
9.  To shut down the VM's, run ``` vagrant halt web1 web2 haproxy ```
10.  To remove the VM's from your hard drive, run ``` vagrant destroy web1 web2 haproxy ```