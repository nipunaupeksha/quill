FROM node:20

WORKDIR /app

COPY package.json package-lock.json* ./

RUN npm cache clean --force && \
    npm install -g npm@latest && \
    npm install

COPY . .

ENV NEXT_TELEMETRY_DISABLED 1

ENV NODE_ENV dev
ENV CONVEX_DEPLOYMENT prod:lovely-salmon-504|01e9643b21c3f591de51a7aeacdeeaeb55800d770bb6ba5ce773e74bb3110c9e394c56c191046505489236effe3cff48252fef
ENV CONVEX_DEPLOY_KEY prod:lovely-salmon-504|01e9643b21c3f591de51a7aeacdeeaeb55800d770bb6ba5ce773e74bb3110c9e394c56c191046505489236effe3cff48252fef
ENV NEXT_PUBLIC_CONVEX_URL https://lovely-salmon-504.convex.cloud
ENV NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY pk_test_d29uZHJvdXMtbWFzdG9kb24tNjEuY2xlcmsuYWNjb3VudHMuZGV2JA
ENV CLERK_SECRET_KEY sk_test_UPj9EwtuVRSroatUDG7jWIjtNIXZVLQhRZBZ3o1pbw
ENV EDGE_STORE_ACCESS_KEY na1YDkytiyuadb0BPilpCwhsTShqsD9i
ENV EDGE_STORE_SECRET_KEY NA4jvL58BQoMEMGvnobaZrTha8sUSVpjdLBvTGYtQIVo3t82

RUN npm run build

ENV NEXT_TELEMETRY_DISABLED 1

EXPOSE 3000
RUN useradd -ms /bin/bash admin
RUN chown -R admin:admin /app
RUN chmod 755 /app
USER admin

ENV HOSTNAME 0.0.0.0
ENV PORT 3000

CMD npx convex deploy && ./node_modules/.bin/next start
# CMD ["npx convex deploy", "./node_modules/.bin/next", "start"]