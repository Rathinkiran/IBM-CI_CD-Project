# Stage 1: Build the React application
FROM node:18 AS build-stage  
# Use a valid stage name

WORKDIR /app

# Copy package.json and package-lock.json first to leverage caching
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application
COPY . .

# Build the Vite project (outputs to /app/dist)
RUN npm run build

# Stage 2: Serve the built application using Nginx
FROM nginx:alpine

# Copy built files from the previous stage
COPY --from=build-stage /app/dist /usr/share/nginx/html

# Expose the default Nginx port
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
