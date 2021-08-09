FROM node:8.7.0-alpine as base

COPY package.json .

RUN npm set progress=false && \
    npm config set depth 0 && \
    npm install --only=production && \
    npm cache clean

# copy production node_modules aside
RUN cp -R node_modules prod_node_modules


# ---- Test ----
# run linters, setup and tests
FROM base AS test
COPY . .
RUN  npm run lint && npm run setup && npm run test

FROM base as release

WORKDIR /app

# Copy contents of dist folder to /opt/app
COPY --from=dependencies /root/chat/prod_node_modules ./node_modules
COPY . .

# Give ownership to daemon user
RUN ["chown", "-R", "appuser:appuser", "."]
USER appuser

# Expose port 3000 to the network
EXPOSE 3000

CMD ["npm", "start", "--"]
