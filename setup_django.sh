#!/bin/bash


#### DJANGO INSTALLATION ####

cd /home/$userName

django-admin.py startproject $projectName

cd $projectName/$projectName

mkdir templates
mkdir static
cd static
mkdir css 
mkdir js
mkdir img

echo "writiing to wsgi.py"

#TODO set line number dynamically
sed -e '17s/$/sys.path.insert(0,os.sep.join(os.path.abspath(__file__).split(os.sep)[:-2]))/' -i /home/$userName/$projectName/$projectName/wsgi.py

sed -i "/import os/c\import os, sys" /home/$userName/$projectName/$projectName/wsgi.py

echo "written to wsgi.py"


sed -i "/STATIC_ROOT/c\STATIC_ROOT = \\'/home/$userName/$projectName/$projectName/\\'" /home/$userName/$projectName/$projectName/settings.py

sed -i "/STATICFILES_DIRS = /c\STATICFILES_DIRS = (\\'/home/$userName/$projectName/$projectName/static/\\'," /home/$userName/$projectName/$projectName/settings.py

sed -i "/TEMPLATE_DIRS = /c\TEMPLATE_DIRS = (\\'/home/$userName/$projectName/$projectName/templates/\\'," /home/$userName/$projectName/$projectName/settings.py