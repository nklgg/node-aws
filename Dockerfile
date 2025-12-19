# Stage 1: The Builder
FROM node:18-alpine AS builder
WORKDIR /app

# Copy package files and install ALL dependencies (including TypeScript)
COPY package*.json ./
RUN npm install

# Copy everything and build the project
COPY . .
RUN npm run build

# Stage 2: The Final Production Image
FROM node:18-alpine
WORKDIR /app

# Only copy the compiled JavaScript from the builder stage
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/package*.json ./

# Install ONLY production dependencies to keep the image small
RUN npm ci --only=production

EXPOSE 3000

# Start the compiled app
CMD ["node", "dist/index.js"]