# Use official Node.js LTS image
FROM node:20

# Set working directory inside the container
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the app
COPY . .

# Expose port (match your app's port)
EXPOSE 5173

# Start the app
CMD ["npm", "run","dev"]

