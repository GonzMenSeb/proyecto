#!/bin/bash

#Stop the container
docker stop vite-container

#Erase the container
docker rm vite-container

#Erase the image
docker rmi vite-app

