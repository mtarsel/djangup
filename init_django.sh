#!/bin/bash

sudo apt-get update
sudo apt-get install python-pip python-dev apache2-prefork-dev apache2 apache2.2-common apache2-mpm-prefork apache2-utils libexpat1 ssl-cert libapache2-mod-wsgi
pip install django

echo "Please enter new user's name"
read userName

sudo adduser $userName -m

echo "Please enter Django project name: "
read projectName

sudo su django -c ./setup_django.sh userName=$userName projectName=$projectName #executes commands in 'setup_django.sh' for user django 


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

echo "writiing to wsgi.py"

sed -e '17s/$/sys.path.insert(0,os.sep.join(os.path.abspath(__file__).split(os.sep)[:-2]))/' -i /home/$userName/$projectName/$projectName/wsgi.py

echo "written to wsgi.py"

a2dissite default
a2ensite $projectName

service apache2 restart

