FROM node:18-alpine

WORKDIR /app

# Install production dependencies only
COPY package*.json ./
RUN npm ci --only=production

# Copy source
COPY . .

EXPOSE 3000

CMD ["node", "src/index.js"]
