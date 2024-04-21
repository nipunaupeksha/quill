FROM node:20

WORKDIR /app

COPY package.json package-lock.json* ./

RUN npm cache clean --force && \
    npm install -g npm@latest && \
    npm install

COPY . .

ENV NEXT_TELEMETRY_DISABLED 1

ENV NODE_ENV dev
ENV CONVEX_DEPLOYMENT xxxx
ENV CONVEX_DEPLOY_KEY xxxx
ENV NEXT_PUBLIC_CONVEX_URL xxxx
ENV NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY xxxx
ENV CLERK_SECRET_KEY xxxx
ENV EDGE_STORE_ACCESS_KEY xxxx
ENV EDGE_STORE_SECRET_KEY xxxx

RUN npm run build

ENV NEXT_TELEMETRY_DISABLED 1

EXPOSE 3000

RUN chown -R 10014:10014 /app
RUN chmod 755 /app
USER 10014

ENV HOSTNAME 0.0.0.0
ENV PORT 3000

CMD npx convex deploy && ./node_modules/.bin/next start