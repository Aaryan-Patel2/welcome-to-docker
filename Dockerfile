# Start your image with a node base image
FROM node:18-alpine

# The /app directory should act as the main application directory
WORKDIR /app

# Copy the app package and package-lock.json file (Basically defining dependencies/setup for the base image)
COPY package*.json ./

# Copy local directories to the current local directory of our docker image (/app)
COPY ./src ./src
COPY ./public ./public

# Install node packages, install serve, build the app, and remove dependencies at the end
RUN npm install \
    && npm install -g serve \
    && npm run build \
    && rm -fr node_modules 
#While .dockerignore prevents the repeatable instance of the node_modules of being replicated, rm -fr removes before a fresh installation of the base image occurs

EXPOSE 3000

# Start the app using serve command
CMD [ "serve", "-s", "build"]