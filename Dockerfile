FROM node:12.18.3 as builder

WORKDIR /user/src/app

COPY . .

RUN npm i --production

RUN ionic build

FROM node:12.18.3-slim
ENV NODE_ENV=production

WORKDIR /user/src/app

COPY --from=builder /user/src/app/www .

EXPOSE 8100

CMD [""]