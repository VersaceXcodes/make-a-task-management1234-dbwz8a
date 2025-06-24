# Stage 1: Build the Vite React frontend
FROM node:18 AS frontend-build
WORKDIR /app/vitereact
# Copy package files and install dependencies with --legacy-peer-deps
COPY vitereact/package.json ./
RUN npm install --legacy-peer-deps
# Copy the rest of the frontend files and build
COPY vitereact ./
RUN npm run build

# Debug: List what was actually built
RUN echo "=== DEBUG: Listing vitereact directory contents after build ===" && ls -la /app/vitereact/
RUN echo "=== DEBUG: Checking for dist directory ===" && ls -la /app/vitereact/dist/ || echo "dist directory not found"
RUN echo "=== DEBUG: Checking for public directory ===" && ls -la /app/vitereact/public/ || echo "public directory not found"
RUN echo "=== DEBUG: Checking build output ===" && find /app/vitereact -name "*.js" -o -name "*.css" -o -name "*.html" | head -20

# Stage 2: Set up the Node.js backend
FROM node:18
WORKDIR /app/backend
# Copy package files and install production dependencies
COPY backend/package.json ./
# Install dependencies
RUN npm install --production
# Copy the backend files
COPY backend ./
# Copy the frontend build output - According to vite.config.ts, Vite outputs to 'public' directory
COPY --from=frontend-build /app/vitereact/public /app/backend/public
# Expose the port the backend will run on
EXPOSE 3000
# Set environment variables
ENV PORT=3000
ENV HOST=0.0.0.0
# Command to start the backend server - make sure it listens on all interfaces
CMD ["sh", "-c", "node initdb.js && NODE_ENV=production node server.js"]