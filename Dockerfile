FROM node:16-alpine as builder
WORKDIR "/app"
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# /app/build <--- all the stuff 

FROM nginx
# Expose port 80 for AWS Elastic Beanstalk
EXPOSE 80 
COPY --from=builder /app/build /usr/share/nginx/html

# The default command of the NGINX Image is to run nginx for us,
# that's why we don't do that here