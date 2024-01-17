#!/bin/bash

sudo apt-get update
sudo apt-get install -y apache2
sudo apt-get install -y mysql-server
sudo apt-get install -y php libapache2-mod-php php-mysql

sudo systemctl restart apache2

echo Apache Status:
sudo systemctl status apache2
echo MySQL Status:
sudo systemctl status mysql
