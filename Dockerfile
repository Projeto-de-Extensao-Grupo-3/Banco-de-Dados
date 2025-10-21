FROM mysql:latest
WORKDIR /
COPY ./src/ /docker-entrypoint-initdb.d/
EXPOSE 3306