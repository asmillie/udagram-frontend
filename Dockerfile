# Build Stage One
# Copy source files and install required packages
# Run ionic build to generate html and js files
FROM node:12.18.3 as build-stage-1

WORKDIR /user/src/app

COPY . .

RUN npm install -g @ionic/cli

RUN npm install

RUN ionic build

# Build Stage Two
# Copy server.js and www folder from previous build stage
# Install express.js
FROM node:12.18.3 as build-stage-2

WORKDIR /user/src/app

COPY --from=build-stage-1 /user/src/app/www ./www
COPY --from=build-stage-1 /user/src/app/server.js .

RUN npm install express@4.17.1

# Final build
# Copy files from previous build stage
# Set node_env to production
# Expose default ionic port 8100
# Run express server to serve ionic site
FROM node:12.18.3-slim
ENV NODE_ENV=production

WORKDIR /user/src/app

COPY --from=build-stage-2 /user/src/app .

EXPOSE 8100

CMD ["node","server.js"]