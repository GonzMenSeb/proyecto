#!/bin/bash

# Build the Docker image with the tag 'vite-app'
docker build -t vite-app .

# Run the container in detached mode, mapping port 5173 and naming it 'vite-container'
docker run -d -p 5173:5173 --name vite-container vite-app

