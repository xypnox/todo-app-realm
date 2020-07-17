#!/bin/sh

echo "What do you want to name the project as?"
read ProjName

echo "Downloading zip package from GitHub\n"
curl -L https://github.com/amitu/realm-starter/archive/master.zip -o master.zip
echo "Finished Downloading\n"

unzip master.zip >> /dev/null

mv realm-starter-master/ ${ProjName}/

# Clean Up
rm master.zip

cd ${ProjName}

git init

cd ..

echo "\nYour project is ready. Type 'cd ${ProjName}' to enter the directory and start working\n"
