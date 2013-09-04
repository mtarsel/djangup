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

echo "written to wsgi.py"

#TODO add static file directories to settings.py
cat /home/$userName/$projectName/$projectName/settings.py | awk '/TEMP_DIR/ {print FNR}'

