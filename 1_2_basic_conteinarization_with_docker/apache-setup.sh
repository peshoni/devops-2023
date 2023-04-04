#!/bin/bash

echo "* Create directory for source files..."
mkdir apache  

echo "* Copy files from a vagrant folder, which is synced with the host machine to the apache folder..."
cp /vagrant/* apache
 
cd apache
echo "* Build image from here..."

docker build -t my-apache .
echo "* An image was built..."

echo "* Run a new container from the new image..."
docker run -d -p 8080:80 --name apache my-apache
echo "* Image application waits on localhost:8080 ..." 
