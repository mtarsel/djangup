#!/bin/bash

sudo apt-get update
sudo apt-get install python-pip python-dev apache2-prefork-dev apache2 apache2.2-common apache2-mpm-prefork apache2-utils libexpat1 ssl-cert libapache2-mod-wsgi
pip install django

echo "Please enter new user's name"
read userName

sudo useradd -m $userName

echo "Please enter Django project name: "
read projectName

sudo su ${userName} -c "userName=$userName projectName=$projectName ./setup_django.sh"
#executes commands in 'setup_django.sh' for user django 


#### APACHE CONFIGS ####

echo "Configuring Apache with Django.... "

printf "
WSGIScriptAlias / /home/$userName/$projectName/$projectName/wsgi.py

WSGIPythonPath /home/$userName/$projectName

Alias /static /home/$userName/$projectName/$projectName/static
<Directory /home/$userName/$projectName/$projectName>
<Files wsgi.py>
Order deny,allow
Allow from all
</Files>
</Directory>" > /etc/apache2/httpd.conf 

printf "<VirtualHost *:80>
        ServerName $projectName.com
        ServerAlias $projectName.com
        WSGIScriptAlias / /home/$userName/$projectName/$projectName/wsgi.py
        Alias /static/ /home/$userName/$projectName/$projectName/static/
        <Location "/static/">
            Options -Indexes
        </Location>
</VirtualHost>" > /etc/apache2/sites-available/$projectName

a2dissite default

a2ensite $projectName

service apache2 restart

