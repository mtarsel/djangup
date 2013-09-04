#!/bin/bash

#sudo apt-get update
#sudo apt-get install python-pip python-dev apache2-prefork-dev apache2 apache2.2-common apache2-mpm-prefork apache2-utils libexpat1 ssl-cert libapache2-mod-wsgi
#pip install django

echo "Please enter Django project name: "
read projectName

#cd

django-admin.py startproject $projectName

cd $projectName/$projectName

mkdir templates
mkdir static
cd static
mkdir css 
mkdir js
mkdir img

echo "About to write.... "

printf "
WSGIScriptAlias / /root/$projectName/$projectName/wsgi.py

WSGIPythonPath /root/$projectName

Alias /static /root/$projectName/$projectName/static
<Directory /root/$projectName/$projectName>
<Files wsgi.py>
Order deny,allow
Allow from all
</Files>
</Directory>" > /home/mick/projects/djangup/httpd.conf
#/etc/apache2/httpd.conf 

echo "writiing to wsgi"
sed '17i sys.path.insert(0,os.sep.join(os.path.abspath(__file__).split(os.sep)[:-2]))'  /home/mick/projects/djangup/$projectName/$projectName/wsgi.py
#/root/$projectName/$projectName/wsgi.py

echo "written to wsgi"
#a2dissite default
#a2ensite $projectName

#service apache2 restart
