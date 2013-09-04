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

#TODO
cat /home/$userName/$projectName/$projectName/settings.py | awk '/TEMP_DIR/ {print FNR}'

