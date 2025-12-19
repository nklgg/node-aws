# Use a lightweight Node.js image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package files first (for better caching)
COPY package*.json ./

# Install only production dependencies
RUN npm ci --only=production

# Copy the rest of your app code
COPY . .

# Expose the port your app runs on (e.g., 3000)
EXPOSE 3000

# Start command (make sure this matches your package.json)
CMD ["npm", "start"]